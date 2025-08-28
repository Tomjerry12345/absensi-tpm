import 'package:get/get.dart';
import 'package:absensi/screen/login/login_screen.dart';
import 'package:absensi/screen/home/home_screen.dart';

class Routes {
  static const login = '/login';
  static const home = '/home';

  static final pages = [
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
  ];
}
