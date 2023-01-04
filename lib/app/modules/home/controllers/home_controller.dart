import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/services/auth_type_service.dart';
import 'package:commute/app/data/services/fb_my_plan_service.dart';
import 'package:commute/app/data/services/screen_type_service.dart';
import 'package:commute/app/modules/home/bindings/commute_check_binding.dart';
import 'package:commute/app/modules/home/bindings/plan_all_binding.dart';
import 'package:commute/app/modules/home/bindings/plan_commute_binding.dart';
import 'package:commute/app/modules/home/bindings/print_commute_binding.dart';
import 'package:commute/app/modules/home/repositories/home_repository.dart';
import 'package:commute/app/data/services/fb_commute_service.dart';
import 'package:commute/app/data/services/fb_user_service.dart';
import 'package:commute/app/routes/app_pages.dart';
import 'package:commute/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final HomeRepository repository;

  HomeController({required this.repository});

  late TabController tabController;
  final AuthType authType = Get.find<AuthTypeService>().authType;
  final FbUser localUser = Get.find<FbUserService>().fbUser;
  int offset = 0;
  int getTabCntByAuthType(AuthType authType){
    if(authType==AuthType.viewer){
      return 3;
    }
    return 4;
  }

  @override
  void onInit() async {
    offset = authType==AuthType.viewer?1:0;
    int _tabCnt = getTabCntByAuthType(authType);
    tabController = TabController(length: _tabCnt, vsync: this);
    List<Function> bindings = [CommuteCheckBinding().dependencies,PlanCommuteBinding().dependencies,PlanAllBinding().dependencies,PrintCommuteBinding().dependencies];
    tabController.addListener(() {
      bindings[offset+tabController.index]();
    });

    super.onInit();
    update();
  }

  //header
  void logout() {
    Get.find<FbUserService>().clear();
    Get.find<FbCommuteService>().clear();
    Get.find<FbMyPlanService>().clear();
    repository.clearCachedUser();
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
    print(Get.find<ScreenTypeService>().userScreenType);
  }
}
