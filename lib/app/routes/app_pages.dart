// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import 'package:commute/app/modules/home/bindings/home_binding.dart';
import 'package:commute/app/modules/home/views/home_view.dart';
import 'package:commute/app/modules/login/bindings/login_binding.dart';
import 'package:commute/app/modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
