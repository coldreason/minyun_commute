import 'package:commute/app/data/providers/fb_plan_provider.dart';
import 'package:commute/app/modules/home/controllers/plan_all_controller.dart';
import 'package:commute/app/modules/home/repositories/plan_all_repository.dart';

import 'package:get/get.dart';

class PlanAllBinding {
  void dependencies() {
    Get.lazyPut<PlanAllController>(() => PlanAllController(
        repository:
        PlanAllRepository(fbPlanProvider: FbPlanProvider())));
  }
}
