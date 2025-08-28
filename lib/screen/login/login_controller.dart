import 'package:absensi/utils/getx_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:absensi/router/routes.dart';
import 'package:absensi/utils/data_dummy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var obscure = true.obs;

  late TextEditingController emailCtrl;
  late TextEditingController passwordCtrl;

  final formKey = GlobalKey<FormState>();

  void toggleObscure() => obscure.value = !obscure.value;

  @override
  void onInit() {
    super.onInit();
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();

    emailCtrl.addListener(() => email.value = emailCtrl.text);
    passwordCtrl.addListener(() => password.value = passwordCtrl.text);
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email wajib diisi';
    const pattern =
        r"^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";
    final reg = RegExp(pattern);
    if (!reg.hasMatch(value.trim())) return 'Format email tidak valid';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password wajib diisi';
    if (value.length < 6) return 'Minimal 6 karakter';
    return null;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    if (isLoading.value) return;
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 600));

    final stored = dummyUsers[email.value.trim()];
    if (stored != null && stored == password.value) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('email', email.value);

      moveOff(Routes.home, arg: email.value.trim());
    } else {
      showError("Email atau password salah");
    }

    isLoading.value = false;
  }
}
