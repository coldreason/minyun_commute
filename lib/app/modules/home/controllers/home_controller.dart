import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/app/data/models/fb_commute_model.dart';
import 'package:commute/app/data/models/fb_plan_model.dart';
import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/repositories/home_repository.dart';
import 'package:commute/app/data/services/fb_all_user_service.dart';
import 'package:commute/app/data/services/fb_commute_service.dart';
import 'package:commute/app/data/services/fb_user_service.dart';
import 'package:commute/app/flutter_flow/flutter_flow_util.dart';
import 'package:commute/app/routes/app_pages.dart';
import 'package:commute/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final HomeRepository homeRepository;

  HomeController({required this.homeRepository});

  late TabController tabController;
  final TextEditingController commentController = TextEditingController();
  final ScrollController scrollControllerB = ScrollController();


  UserScreenType userScreenType = UserScreenType.pcWeb;
  FbCommute? localCommute;
  FbUser? localUser;
  late DateTime targetMonth;
  List<DateTime> selectedDate = [];
  Map<String, FbPlan> myPlans = {};
  Map<String, List<FbPlan>> allPlans = {};
  Map<String, FbUser> allUser = {};
  Map<String, FbCommute> commutes = {};

  String planGoWorkSettingH = planTimesH[0];
  String planGoWorkSettingM = planTimesM[0];
  String planGoHomeSettingH = planTimesH[0];
  String planGoHomeSettingM = planTimesM[0];
  String planUnit = planUnitList[0];

  @override
  void onInit() async {
    tabController = TabController(length: 4, vsync: this);
    targetMonth = Timestamp.now().toDate();

    // user state do not received : impossible
    if (!Get.find<FbUserService>().initialized ||
        !Get.find<FbAllUserService>().initialized)
      Get.offAllNamed(Routes.LOGIN);

    allUser = Get.find<FbAllUserService>().fbAllUser;
    localUser = Get.find<FbUserService>().fbUser;

    if (!Get.find<FbCommuteService>().initialized) {
      String month = getTargetMonthString();
      String key = month + formatter.format(targetMonth.day);
      commutes = await homeRepository.getCommutes(
          Get.find<FbUserService>().fbUser.id!, month);
      Get.find<FbCommuteService>().fbCommute = commutes[key] ??
          FbCommute(
              id: Get.find<FbUserService>().fbUser.id, workAtLunch: false);
      localCommute = Get.find<FbCommuteService>().fbCommute;
    }
    getPlans();
    getAllPlans();
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
    Get.offAllNamed(Routes.LOGIN);
  }

  // page1
  void changeLunchTimeWork(bool value) async {
    Timestamp stamp = Timestamp.now();
    Get.find<FbCommuteService>().fbCommute.workAtLunch = value;
    FbCommute p = await homeRepository.setCommute(
        Get.find<FbUserService>().fbUser.id!,
        stamp,
        Get.find<FbCommuteService>().fbCommute);
    localCommute = p;
    update();
  }

  void checkStart() async {
    Timestamp stamp = Timestamp.now();
    Get.find<FbCommuteService>().fbCommute.comeAt = stamp;
    FbCommute p = await homeRepository.setCommute(
        Get.find<FbUserService>().fbUser.id!,
        stamp,
        Get.find<FbCommuteService>().fbCommute);
    localCommute = p;
    update();
  }

  void checkFinish() async {
    Timestamp stamp = Timestamp.now();
    Get.find<FbCommuteService>().fbCommute.endAt = stamp;
    FbCommute p = await homeRepository.setCommute(
        Get.find<FbUserService>().fbUser.id!,
        stamp,
        Get.find<FbCommuteService>().fbCommute);
    localCommute = p;
    update();
  }

  void checkFinishAgain() async {
    Get.find<FbCommuteService>().fbCommute.comment =
        commentController.value.text;
    checkFinish();
    commentController.clear();
  }

  // page2
  bool checkSelected(DateTime dateTime) {
    return selectedDate.contains(dateTime);
  }

  void dateClicked(DateTime dateTime) {
    if (dateTime.month != targetMonth.month) {
    } else if (selectedDate.contains(dateTime)) {
      selectedDate.remove(dateTime);
      update();
    } else {
      selectedDate.add(dateTime);
      update();
    }
  }

  void changePlanGoWorkSettingH(String target) {
    planGoWorkSettingH = target;
    update();
  }

  void changePlanGoWorkSettingM(String target) {
    planGoWorkSettingM = target;
    update();
  }

  void changePlanGoHomeSettingH(String target) {
    planGoHomeSettingH = target;
    update();
  }

  void changePlanGoHomeSettingM(String target) {
    planGoHomeSettingM = target;
    update();
  }

  void changePlanUnit(String target) {
    planUnit = target;
    update();
  }

  void settingClicked() async {
    // await Future.delayed(Duration(milliseconds: 200));
    // scrollControllerB.animateTo(scrollControllerB.position.maxScrollExtent,
    //     duration: Duration(milliseconds: 800), curve: Curves.ease);
  }

  void monthChange(DateTime month) {
    targetMonth = month;
    selectedDate = [];
    getPlans();
    getAllPlans();
  }

  String getTargetMonthString() {
    return targetMonth.year.toString() + formatter.format(targetMonth.month);
  }

  void getPlans() async {
    String month = getTargetMonthString();
    Map<String, FbPlan> ret =
        await homeRepository.getPlans(localUser!.id!, month);
    myPlans = ret;
    update();
  }

  void setPlan() async {
    String month = getTargetMonthString();
    Map<String, FbPlan> plans = Map();

    selectedDate.forEach((element) {
      plans[localUser!.id! + month + formatter.format(element.day)] = FbPlan(
          id: localUser!.id!,
          comeAt: Timestamp.fromDate(DateTime(
              targetMonth.year,
              targetMonth.month,
              element.day,
              int.parse(planGoWorkSettingH),
              int.parse(planGoWorkSettingM))),
          endAt: Timestamp.fromDate(DateTime(
              targetMonth.year,
              targetMonth.month,
              element.day,
              int.parse(planGoHomeSettingH),
              int.parse(planGoHomeSettingM))),
          unit: planUnit);
    });
    await homeRepository.setPlans(localUser!.id!, month, plans);
    selectedDate = [];
    getPlans();
    getAllPlans();
  }

  void deletePlan(DateTime date) async {
    String month = date.year.toString() + formatter.format(date.month);
    String planId = month + formatter.format(date.day);
    await homeRepository.deletePlan(month, myPlans[planId]!.id! + planId);
    myPlans.remove(planId);
    update();
  }

  //page3
  void monthChangeAll(DateTime month) {
    targetMonth = month;
    getPlans();
    getAllPlans();
  }

  void getAllPlans() async {
    String month = getTargetMonthString();
    Map<String, List<FbPlan>> ret = await homeRepository.getPlansbyMonth(month);
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
}
