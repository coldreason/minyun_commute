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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final HomeRepository homeRepository;

  HomeController({required this.homeRepository});

  final List<String> planTimesH = [
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
  ];
  final planTimesM = [
    "00",
    "10",
    "20",
    "30",
    "40",
    "50",
  ];

  final planUnitList = [
    "1",
    "1.5",
    "2",
  ];

  NumberFormat formatter = NumberFormat("00");

  late TabController tabController;
  late TextEditingController commentController;
  late ScrollController scrollControllerB;

  FbCommute? localCommute;
  FbUser? localUser;
  late DateTime targetMonth;
  List<DateTime> selectedDate = [];
  Map<String, FbPlan> myPlans = {};
  Map<String, List<FbPlan>> allPlans = {};
  Map<String, FbUser> allUser = {};
  Map<String, FbCommute> commutes = {};

  String planGoWorkSettingH = "08";
  String planGoWorkSettingM = "00";
  String planGoHomeSettingH = "08";
  String planGoHomeSettingM = "00";
  String planUnit = "1";



  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    commentController = TextEditingController();
    scrollControllerB = ScrollController();
    DateTime date = Timestamp.now().toDate();
    targetMonth = date;
    if (!Get.find<FbUserService>().initialized) Get.offAllNamed(Routes.LOGIN);
    if (!Get.find<FbAllUserService>().initialized) Get.offAllNamed(Routes.LOGIN);
    allUser = Get.find<FbAllUserService>().fbAllUser;
    localUser = Get.find<FbUserService>().fbUser;
    if (!Get.find<FbCommuteService>().initialized) {
      String month = date.year.toString() + formatter.format(date.month);
      String key = date.year.toString() +
          formatter.format(date.month) +
          formatter.format(date.day);
      commutes = await homeRepository.getCommutes(
          Get.find<FbUserService>().fbUser.id!, month);
      Get.find<FbCommuteService>().fbCommute = commutes[key] ??
          FbCommute(
              id: Get.find<FbUserService>().fbUser.id, workAtLunch: false);
      localCommute = Get.find<FbCommuteService>().fbCommute;
    }
    getPlans();
    getAllPlans();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

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
      print('datetimeclicked');
      print(dateTime.month);
      print(targetMonth.month);
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

  void monthChange(DateTime month){
    targetMonth = month;
    selectedDate = [];
    print('targetmonth');
    print(targetMonth.month);
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

  void setPlan() async{
    String month = targetMonth.year.toString() + formatter.format(targetMonth.month);
    Map<String, FbPlan> plans = Map();

    selectedDate.forEach((element) {
      plans[localUser!.id! +
          month +
          formatter.format(element.day)] =
          FbPlan(
              id: localUser!.id!,
              comeAt: Timestamp.fromDate(DateTime(targetMonth.year,targetMonth.month,element.day,int.parse(planGoWorkSettingH),int.parse(planGoWorkSettingM))),
              endAt: Timestamp.fromDate(DateTime(targetMonth.year,targetMonth.month,element.day,int.parse(planGoHomeSettingH),int.parse(planGoHomeSettingM))),
              unit: planUnit);
    });
      await homeRepository.setPlans(localUser!.id!, month, plans);
      selectedDate = [];
      getPlans();
  }

  void deletePlan(DateTime date) async {
    String month = date.year.toString() + formatter.format(date.month);
    String planId = month + formatter.format(date.day);
    await homeRepository.deletePlan(month, myPlans[planId]!.id! + planId);
    myPlans.remove(planId);
    update();
  }

  //page3
  void monthChangeAll(DateTime month){
    targetMonth = month;
    getAllPlans();
  }

  void getAllPlans() async {
    String month = targetMonth.year.toString() + formatter.format(targetMonth.month);
    Map<String, List<FbPlan>> ret = await homeRepository.getPlansbyMonth(month);
    allPlans= ret;
    print(allPlans);
    update();
  }
}
