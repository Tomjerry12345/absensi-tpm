import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

void move(String dest, {dynamic arg}) {
  Get.toNamed(dest, arguments: arg);
}

void moveOff(String dest, {dynamic arg}) {
  Get.offNamed(dest, arguments: arg);
}

SnackbarController _getSnackbar(
    {String title = "", String msg = "", Color? backgroundColor}) {
  return Get.snackbar(
    title,
    msg,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor,
    colorText: const Color(0xFFFFFFFF),
    margin: const EdgeInsets.all(16),
    borderRadius: 8,
    duration: const Duration(seconds: 3),
  );
}

void showSuccess(String message, {String title = 'Success'}) {
  _getSnackbar(
      title: title, msg: message, backgroundColor: const Color(0xFF4CAF50));
}

void showError(String message, {String title = 'Error'}) {
  _getSnackbar(
      title: title, msg: message, backgroundColor: const Color(0xFFF44336));
}
