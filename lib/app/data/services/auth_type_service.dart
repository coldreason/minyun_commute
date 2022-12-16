import 'package:commute/constants.dart';
import 'package:get/get.dart';

class AuthTypeService extends GetxService {
  AuthType _authType = AuthType.viewer;

  AuthType get authType => _authType;

  set authType(AuthType authType) {
    _authType = authType;
  }
}