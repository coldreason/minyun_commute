import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/app/data/models/fb_commute_model.dart';
import 'package:commute/app/data/models/fb_plan_model.dart';
import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/services/fb_my_plan_service.dart';
import 'package:commute/app/modules/home/bindings/commute_check_binding.dart';
import 'package:commute/app/modules/home/bindings/plan_commute_binding.dart';
import 'package:commute/app/modules/home/repositories/home_repository.dart';
import 'package:commute/app/data/services/fb_all_user_service.dart';
import 'package:commute/app/data/services/fb_commute_service.dart';
import 'package:commute/app/data/services/fb_user_service.dart';
import 'package:commute/app/routes/app_pages.dart';
import 'package:commute/constants.dart';
import 'package:commute/utils/helpers/masks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final HomeRepository homeRepository;

  HomeController({required this.homeRepository});

  late TabController tabController;


  UserScreenType userScreenType = UserScreenType.pcWeb;
  FbUser? localUser;
  late DateTime targetMonth;
  Map<String, List<FbPlan>> allPlans = {};
  Map<String, FbUser> allUser = {};
  Map<String, FbCommute> commutes = {};

  @override
  void onInit() async {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      if (tabController.index == 0) {
        CommuteCheckBinding().dependencies();
      }if(tabController.index==1){
        PlanCommuteBinding().dependencies();
      }
    });

    targetMonth = Timestamp.now().toDate();

    // user state do not received : error
    if (!Get.find<FbUserService>().initialized ||
        !Get.find<FbAllUserService>().initialized)
      Get.offAllNamed(Routes.LOGIN);

    allUser = Get.find<FbAllUserService>().fbAllUser;
    localUser = Get.find<FbUserService>().fbUser;

    getAllPlans();
    getAllCommutes();
    super.onInit();
  }

  void setUserScreenSize(int size){
    if(size>800)userScreenType = UserScreenType.pcWeb;
    else if(size > 550) userScreenType = UserScreenType.tablet;
    else userScreenType = UserScreenType.mobile;
    update();
  }

  //header
  void logout() {
    Get.find<FbUserService>().clear();
    Get.find<FbCommuteService>().clear();
    Get.find<FbMyPlanService>().clear();
    Get.offAllNamed(Routes.LOGIN);
  }


  String getTargetMonthString() {
    return targetMonth.year.toString() + dateStringFormatter.format(targetMonth.month);
  }



  //page3
  void monthChangeAll(DateTime month) {
    targetMonth = month;
    getAllPlans();
  }

  void getAllPlans() async {
    String month = getTargetMonthString();
    Map<String, List<FbPlan>> ret = await homeRepository.getPlansbyMonth(targetMonth);
    allPlans = ret;
    update();
  }

  String calcWorkUnit(FbCommute commute){
    DateTime distance = (Timestamp.fromMillisecondsSinceEpoch(commute.endAt!.millisecondsSinceEpoch - commute.comeAt!.millisecondsSinceEpoch)).toDate();
    int total = (distance.hour-9)*60 + distance.minute - ((commute!.workAtLunch==true)?0:60);
    if(total>390)return planUnitList[2];
    else if(total>285)return planUnitList[1];
    else if(total<60)return "";
    return planUnitList[0];
  }

  void getAllCommutes()async{
   commutes =  await homeRepository.getCommutes(localUser!.id!, targetMonth);
  }
}
