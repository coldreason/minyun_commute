import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/app/data/models/fb_plan_model.dart';
import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/services/fb_all_user_service.dart';
import 'package:commute/app/data/services/fb_user_service.dart';
import 'package:commute/app/modules/home/repositories/plan_all_repository.dart';
import 'package:commute/constants.dart';
import 'package:commute/utils/functions/get_date_string.dart';

import 'package:get/get.dart';

class PlanAllController extends GetxController {
  final PlanAllRepository repository;

  PlanAllController({required this.repository});

  FbUser localUser = Get
      .find<FbUserService>()
      .fbUser;
  Map<String, List<FbPlan>> allPlans = {};
  Map<String, List<FbPlan>> viewPlans = {};
  Map<String, FbUser> allUser = {};
  List<bool> filter = [true,true];
  late DateTime targetMonth;

  @override
  void onInit() async {
    targetMonth = Timestamp.now().toDate();


    allUser = Get
        .find<FbAllUserService>()
        .fbAllUser;
    localUser = Get
        .find<FbUserService>()
        .fbUser;
    await getAllPlans();
    super.onInit();
    update();
  }

  void monthChangeAll(DateTime month) async{
    targetMonth = month;
    await getAllPlans();
    update();
  }

  Future<void> getAllPlans() async {
    allPlans = await repository.getPlansbyMonth(targetMonth);
  }

  void filterSelected(bool selected,int department){
    filter[department] = selected;
    update();
  }

  List<String> getCalanderListString(DateTime dateTime,UserScreenType userScreenType) {
    List<FbPlan> plans = allPlans[getDateString(dateTime)]??[];
    List<String> ret = [];
    for(FbPlan v in plans){
      if(allUser[v.id]!.department=="국어사전실"&& filter[0]==true){
        ret.add("${allUser[v.id]!.name!} ${userScreenType == UserScreenType.pcWeb ?"${dateTimeToString(v.comeAt!.toDate())} - ${dateTimeToString(v.endAt!.toDate())}":""}");
      }
      if(allUser[v.id]!.department=="중한사전실"&& filter[1]==true){
        ret.add("${allUser[v.id]!.name!} ${userScreenType == UserScreenType.pcWeb ?"${dateTimeToString(v.comeAt!.toDate())} - ${dateTimeToString(v.endAt!.toDate())}":""}");
      }
    }
    return ret;
  }
}
