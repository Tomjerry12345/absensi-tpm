import 'dart:convert';
import 'dart:io';

import 'package:absensi/model/absensi.dart';
import 'package:absensi/utils/getx_utils.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AbsensiController extends GetxController {
  var email = RxnString();

  var alamat = RxnString();
  var fotoSelfie = Rxn<File>();
  var sudahAbsen = false.obs;
  var dalamRadius = false.obs;

  // final kantorLat = -5.2057567;
  // final kantorLng = 119.4972033;

  final kantorLat = -5.1304614;
  final kantorLng = 119.478914;

  @override
  void onInit() {
    super.onInit();
    getEmail();
    cekStatusAbsensi();
    cekLokasi();
  }

  Future<void> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString("email") ?? "";
    this.email.value = email;
  }

  Future<void> cekStatusAbsensi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String today = DateFormat("yyyy-MM-dd").format(DateTime.now());

    List<String> riwayat = prefs.getStringList("riwayatAbsensi") ?? [];

    bool found = riwayat.any((data) {
      final map = jsonDecode(data);
      final absensi = AbsensiModel.fromMap(map);
      print(absensi);
      String tanggal = absensi.tanggal;
      return tanggal.startsWith(today);
    });

    sudahAbsen.value = found;
  }

  Future<void> cekLokasi() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      alamat.value = "Layanan lokasi mati";
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        alamat.value = "Izin lokasi ditolak";
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      alamat.value = "Izin lokasi permanen ditolak";
      return;
    }

    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      Placemark place = placemarks.first;
      alamat.value =
          "${place.street}, ${place.subLocality}, ${place.locality} (${pos.latitude}, ${pos.longitude})";
    } catch (e) {
      alamat.value = "${pos.latitude}, ${pos.longitude}";
    }

    double distance = Geolocator.distanceBetween(
      pos.latitude,
      pos.longitude,
      kantorLat,
      kantorLng,
    );
    dalamRadius.value = distance <= 100;
  }

  Future<void> ambilFoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      fotoSelfie.value = File(picked.path);
    }
  }

  Future<void> absenSekarang(BuildContext context) async {
    if (!dalamRadius.value || fotoSelfie.value == null) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String now = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());

    AbsensiModel absensi = AbsensiModel(
      tanggal: now,
      statusLokasi: dalamRadius.value ? "Valid" : "Tidak Valid",
      fotoPath: fotoSelfie.value!.path,
    );

    List<String> riwayat = prefs.getStringList("riwayatAbsensi") ?? [];
    riwayat.add(jsonEncode(absensi.toMap()));
    await prefs.setStringList("riwayatAbsensi", riwayat);

    sudahAbsen.value = true;
    showSuccess("Absensi berhasil disimpan!");
  }
}
