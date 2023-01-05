import 'package:commute/constants.dart';
import 'package:get_storage/get_storage.dart';

import '../models/fb_user_model.dart';

class FbUserCachedProvider {

  final _box = GetStorage();

  FbUser? getCachedUser() {

    Map<String, dynamic>? userMap = _box.read(FirebaseConstants.users);
    if (userMap != null) {
      return FbUser.fromJson(userMap);
    }
    return null;
  }

  void setCachedUser(FbUser fbUser){
    _box.write(FirebaseConstants.users, fbUser.toJson());
  }

  void clearCachedUser()=> _box.remove(FirebaseConstants.users);
}
