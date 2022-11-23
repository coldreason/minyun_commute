import 'package:commute/app/data/providers/fb_commute_provider.dart';
import 'package:commute/app/data/providers/fb_plan_provider.dart';
import 'package:commute/app/data/repositories/home_repository.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(homeRepository: HomeRepository(fbCommuteProvider: FbCommuteProvider(), fbPlanProvider: FbPlanProvider())),
    );
  }
}
