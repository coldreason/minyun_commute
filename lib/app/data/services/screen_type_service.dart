import 'package:commute/constants.dart';
import 'package:get/get.dart';

class ScreenTypeService extends GetxService {
  UserScreenType _userScreenType = UserScreenType.pcWeb;

  UserScreenType get userScreenType => _userScreenType;

  set userScreenType(UserScreenType userScreenType) {
    _userScreenType = userScreenType;
  }
}