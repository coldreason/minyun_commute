import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/app/data/models/fb_plan_model.dart';
import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/services/fb_my_plan_service.dart';
import 'package:commute/app/data/services/fb_user_service.dart';
import 'package:commute/app/modules/home/repositories/plan_commute_repository.dart';
import 'package:commute/constants.dart';
import 'package:commute/utils/functions/get_date_string.dart';

import 'package:get/get.dart';

class PlanCommuteController extends GetxController {
  final PlanCommuteRepository repository;

  PlanCommuteController({required this.repository});

  late DateTime targetMonth;
  late FbUser localUser;

  FbMyPlanService myPlanService = Get.find<FbMyPlanService>();

  List<DateTime> selectedDate = [];
  Map<String, FbPlan> myPlans = {};

  String planGoWorkSettingH = planTimesH[0];
  String planGoWorkSettingM = planTimesM[0];
  String planGoHomeSettingH = planTimesH[0];
  String planGoHomeSettingM = planTimesM[0];

  String planUnit = planUnitList[0];

  num sumPlanUnit = 0;

  @override
  void onInit() async {
    targetMonth = Timestamp.now().toDate();
    localUser = Get.find<FbUserService>().fbUser;
    getPlans();
    super.onInit();
    update();
  }


  bool checkSelected(DateTime dateTime) {
    return selectedDate.contains(dateTime);
  }

  void dateClicked(DateTime dateTime) {
    if (dateTime.month != targetMonth.month) {
    } else if (selectedDate.contains(dateTime)) {
      selectedDate.remove(dateTime);
    } else {
      selectedDate.add(dateTime);
    }
    _calcSumOfWorkUnitWithNotFixed();
    update();
  }

  void _calcSumOfWorkUnitWithNotFixed() {
    _calcSumOfPlanUnit();
    sumPlanUnit = sumPlanUnit + selectedDate.length * num.parse(planUnit);
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
    _calcSumOfWorkUnitWithNotFixed();
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
  }

  void _calcSumOfPlanUnit() {
    sumPlanUnit = 0;
    myPlans.forEach((key, value) {
      sumPlanUnit = sumPlanUnit + num.parse(value.unit!);
    });
  }

  void getPlans() async {
    myPlans = myPlanService.getFbPlans(targetMonth) ??
        await repository.getPlans(localUser.id!, targetMonth);
    myPlanService.setFbPlans(targetMonth, myPlans);
    _calcSumOfPlanUnit();
    update();
  }

  void setPlan() async {
    Map<String, FbPlan> plans = <String, FbPlan>{};

    for (DateTime element in selectedDate) {
      plans[getDateString(element)] = FbPlan(
          id: localUser.id!,
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
    }
    plans.forEach((key, value) {
      myPlans[key]=value;
    });
    myPlanService.setFbPlans(targetMonth, myPlans);
    await repository.setPlans(localUser.id!, targetMonth, plans);
    selectedDate = [];
    getPlans();
  }

  void deletePlan(DateTime date) async {
    await repository.deletePlan(localUser.id!, date);
    myPlans.remove(getDateString(date));
    myPlanService.setFbPlans(date, myPlans);
    _calcSumOfPlanUnit();
    update();
  }
}
