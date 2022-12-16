import 'package:commute/app/data/providers/fb_user_cached_provider.dart';
import 'package:commute/app/data/providers/fb_user_provider.dart';
import 'package:commute/app/data/providers/ip_provider.dart';
import 'package:commute/app/modules/login/repositoryies/login_repository.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
          repository: LoginRepository(
              fbUserProvider: FbUserProvider(), ipProvider: IPProvider(), fbUserCachedProvider: FbUserCachedProvider())),
    );
  }
}
