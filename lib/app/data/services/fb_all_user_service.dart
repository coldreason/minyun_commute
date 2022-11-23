import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:get/get.dart';

class FbAllUserService extends GetxService{
  bool _initialized = false;
  Map<String,FbUser>? _fbAllUser;
  Map<String,FbUser> get fbAllUser => _fbAllUser!;

  bool get initialized => _initialized;

  set fbAllUser(Map<String,FbUser> fbAllUser) {
    _initialized = true;
    _fbAllUser = fbAllUser;
  }
}