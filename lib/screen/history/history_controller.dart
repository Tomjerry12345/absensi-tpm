import 'dart:convert';
import 'package:absensi/model/absensi.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryController extends GetxController {
  var history = <AbsensiModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> riwayat = prefs.getStringList("riwayatAbsensi") ?? [];

    history.value =
        riwayat.map((e) => AbsensiModel.fromMap(jsonDecode(e))).toList();
  }
}
