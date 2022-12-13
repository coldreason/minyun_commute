import 'package:commute/app/data/providers/fb_plan_provider.dart';
import 'package:commute/app/modules/home/controllers/plan_commute_controller.dart';

import 'package:commute/app/modules/home/repositories/plan_commute_repository.dart';
import 'package:get/get.dart';


class PlanCommuteBinding{
  void dependencies() {
    Get.lazyPut<PlanCommuteController>(() => PlanCommuteController(
        repository: PlanCommuteRepository(fbPlanProvider: FbPlanProvider())));
  }
}
