import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/constants.dart';
import 'package:commute/utils/functions/get_date_string.dart';
import 'package:get/get.dart';

import '../models/fb_commute_model.dart';

class FbCommuteProvider extends GetConnect {
  CollectionReference commuteRef =
      FirebaseFirestore.instance.collection(FirebaseConstants.commutes);

  @override
  void onInit() {}

  Future<Map<String, FbCommute>> getCommutesByMonth(
      String id, DateTime month) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await commuteRef
        .doc(id)
        .collection(id)
        .doc(getMonthString(month))
        .get();
    Map<String, dynamic>? data = documentSnapshot.data();
    if (data == null) return {};

    return {for (String e in data!.keys) e: FbCommute.fromJson(data![e])};
  }

  Future<FbCommute> getCommuteByDate(String id, DateTime date) async {
    Map<String, FbCommute> commutesPerMonth =
        await getCommutesByMonth(id, date);

    return commutesPerMonth[getDateString(date)] ??
        FbCommute(id: id, workAtLunch: false);
  }

  Future<FbCommute> setCommute(
      String id, DateTime date, FbCommute fbCommute) async {
    await commuteRef
        .doc(id)
        .collection(id)
        .doc(getMonthString(date))
        .set({getDateString(date):fbCommute.toJson()},SetOptions(merge: true));
    return fbCommute;
  }
}
