import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/constants.dart';
import 'package:commute/utils/functions/get_date_string.dart';
import 'package:get/get.dart';

import '../models/fb_commute_model.dart';

class FbCommuteProvider extends GetConnect {
  CollectionReference commuteRef =
      FirebaseFirestore.instance.collection(FirebaseConstants.commute);

  @override
  void onInit() {}

  Future<Map<String, FbCommute>> getCommutesByMonth(
      String id, DateTime month) async {
    QuerySnapshot<Map<String, dynamic>> doc =
        await commuteRef.doc(id).collection(getMonthString(month)).get();
    Map<String, FbCommute> fbCommutesMap = {};
    doc.docs.forEach((element) {
      fbCommutesMap[element.id] = FbCommute.fromJson(element.data());
    });
    return fbCommutesMap;
  }

  Future<FbCommute> getCommuteByDate(String id, DateTime date) async {
    var doc = await commuteRef
        .doc(id)
        .collection(getMonthString(date))
        .doc(getDateString(date))
        .get();
    if (doc.data() != null) return FbCommute.fromJson(doc.data()!);
    return FbCommute(id: id, workAtLunch: false);
  }

  Future<FbCommute> setCommute(
      String id, DateTime date, FbCommute fbCommute) async {
    await commuteRef
        .doc(id)
        .collection(getMonthString(date))
        .doc(getDateString(date))
        .set(fbCommute.toJson());
    return fbCommute;
  }


}
