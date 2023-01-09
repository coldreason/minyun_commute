import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/constants.dart';
import 'package:commute/utils/functions/get_date_string.dart';
import 'package:get/get.dart';

import '../models/fb_plan_model.dart';

class FbPlanProvider extends GetConnect {
  CollectionReference planRef =
      FirebaseFirestore.instance.collection(FirebaseConstants.plans);

  @override
  void onInit() {}

  Future<Map<String, List<FbPlan>>> getPlansByMonth(DateTime month) async {
    DocumentSnapshot<Object?> documentSnapshot =
        await planRef.doc(getMonthString(month)).get();
    Map<String, List<FbPlan>> ret = {};
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    for (String userId in data.keys) {
      for (String dateString in (data[userId] as Map<String, dynamic>).keys) {
        List<FbPlan> bufList = ret[dateString] ?? [];
        bufList.add(FbPlan.fromJson(data[userId][dateString]));
        ret[dateString] = bufList;
      }
    }
    return ret;
  }

  Future<void> setPlan(
      String id, DateTime date, Map<String, FbPlan> plans) async {
    plans.forEach((key, value) async {
      String dateString = getDateString(value.comeAt!.toDate());
      String monthString = getMonthString(value.comeAt!.toDate());

      DocumentSnapshot<Object?> documentSnapshot =
          await planRef.doc(monthString).get();

      Map<String, Map<String, dynamic>> plansPerUser =
          (documentSnapshot.data() as Map<String, dynamic>)[value.id!] ?? {};

      plansPerUser[dateString] = value.toJson();
      await planRef.doc(monthString).set({value.id!:plansPerUser}, SetOptions(merge: true));
    });
  }

  Future<void> deletePlan(String id, DateTime date) async {
    DocumentSnapshot<Object?> documentSnapshot =
        await planRef.doc(getMonthString(date)).get();
    Map<String, dynamic> plansPerUser =
        (documentSnapshot.data() as Map<String, dynamic>)[id]!;
    plansPerUser.remove(getDateString(date));
    await planRef
        .doc(getMonthString(date))
        .set({id:plansPerUser}, SetOptions(merge: true));
  }

  Future<Map<String, FbPlan>> getFbPlanByIdMonth(
      String id, DateTime month) async {
    DocumentSnapshot<Object?> documentSnapshot =
        await planRef.doc(getMonthString(month)).get();
    Map<String, dynamic> plansPerUser =
        (documentSnapshot.data() as Map<String, dynamic>)[id] ?? {};

    return {
      for (String e in plansPerUser.keys) e: FbPlan.fromJson(plansPerUser[e])
    };
  }
}
