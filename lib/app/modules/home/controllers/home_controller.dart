import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/services/fb_my_plan_service.dart';
import 'package:commute/app/data/services/screen_type_service.dart';
import 'package:commute/app/modules/home/bindings/commute_check_binding.dart';
import 'package:commute/app/modules/home/bindings/plan_all_binding.dart';
import 'package:commute/app/modules/home/bindings/plan_commute_binding.dart';
import 'package:commute/app/modules/home/bindings/print_commute_binding.dart';
import 'package:commute/app/modules/home/controllers/plan_commute_controller.dart';
import 'package:commute/app/modules/home/repositories/home_repository.dart';
import 'package:commute/app/data/services/fb_commute_service.dart';
import 'package:commute/app/data/services/fb_user_service.dart';
import 'package:commute/app/routes/app_pages.dart';
import 'package:commute/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final HomeRepository homeRepository;

  HomeController({required this.homeRepository});

  late TabController tabController;

  FbUser localUser = Get.find<FbUserService>().fbUser;

  @override
  void onInit() async {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      if (tabController.index == 0) {
        CommuteCheckBinding().dependencies();
      }
      if (tabController.index == 1) {
        PlanCommuteBinding().dependencies();
      }
      if (tabController.index == 2) {
        PlanAllBinding().dependencies();
      }
      if (tabController.index == 3) {
        PrintCommuteBinding().dependencies();
      }
    });

    super.onInit();
  }

  //header
  void logout() {
    Get.find<FbUserService>().clear();
    Get.find<FbCommuteService>().clear();
    Get.find<FbMyPlanService>().clear();
    final box = GetStorage();
    box.write(FirebaseConstants.user, null);
    Get.offAllNamed(Routes.LOGIN);
  }

  void setUserScreenSize(int size) {
    if (size > 800) {
      Get.find<ScreenTypeService>().userScreenType = UserScreenType.pcWeb;
    } else if (size > 550) {
      Get.find<ScreenTypeService>().userScreenType = UserScreenType.tablet;
    } else {
      Get.find<ScreenTypeService>().userScreenType = UserScreenType.mobile;
    }
  }
}
