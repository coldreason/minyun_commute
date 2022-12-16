import 'package:commute/app/data/providers/fb_user_cached_provider.dart';
import 'package:commute/app/modules/home/bindings/plan_commute_binding.dart';
import 'package:commute/app/modules/home/repositories/home_repository.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'commute_check_binding.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
          repository:
              HomeRepository(fbUserCachedProvider: FbUserCachedProvider())),
    );
    CommuteCheckBinding().dependencies();
    PlanCommuteBinding().dependencies();
  }
}
