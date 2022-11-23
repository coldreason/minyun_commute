import 'package:commute/app/data/models/fb_commute_model.dart';
import 'package:get/get.dart';

class FbCommuteService extends GetxService{
  bool _initialized = false;
  FbCommute? _fbCommute;
  FbCommute get fbCommute => _fbCommute!;

  bool get initialized => _initialized;

  void clear(){
    _fbCommute = null;
    _initialized = false;
  }

  set fbCommute(FbCommute fbCommute) {
    _initialized = true;
    _fbCommute = fbCommute;
  }
}