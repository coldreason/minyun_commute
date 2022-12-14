import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:get/get.dart';

class FbUserService extends GetxService {
  bool _initialized = false;
  FbUser? _fbUser;

  FbUser get fbUser => _fbUser!;

  @override
  bool get initialized => _initialized;

  void clear() {
    _fbUser = null;
    _initialized = false;
  }

  set fbUser(FbUser fbUser) {
    _initialized = true;
    _fbUser = fbUser;
  }
}
