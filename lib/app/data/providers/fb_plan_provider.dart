import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/constants.dart';
import 'package:get/get.dart';

import '../models/fb_plan_model.dart';

class FbPlanProvider extends GetConnect {

  CollectionReference planRef = FirebaseFirestore.instance
      .collection(FirebaseConstants.plan);
  @override
  void onInit() {
  }

  Future<Map<String,List<FbPlan>>> getPlansByMonth(String month) async {
    QuerySnapshot<Map<String, dynamic>> doc = await planRef.doc(month).collection(month).get();
    Map<String,List<FbPlan>> ret = {};
    doc.docs.forEach((element) {
      String key = element.id.substring(element.id.length-8);
      List<FbPlan> bufList = (ret[key]??[]) as List<FbPlan>;
      bufList.add(FbPlan.fromJson(element.data()));
      ret[key] = bufList;
    });
    return ret;
  }

  Future<void> setPlan(String id, String month,Map<String,FbPlan> plans) async{

    plans.forEach((key, value) async{
      await planRef.doc(month).collection(month).doc(key).set(value.toJson());
    });
  }

  Future<void> deletePlan(String month,String key) async{
      await planRef.doc(month).collection(month).doc(key).delete();
  }


  Future<Map<String,FbPlan>> getFbPlanByIdMonth(String id, String month) async {
    QuerySnapshot<Map<String, dynamic>> doc = await planRef.doc(month).collection(month).where("id",isEqualTo: id).get();

    Map<String,FbPlan> ret = {};
    doc.docs!.forEach((element) {
      String key = element.id.substring(element.id.length-8);
      ret[key] = FbPlan.fromJson(element.data());
    });
    return ret;
  }

}
