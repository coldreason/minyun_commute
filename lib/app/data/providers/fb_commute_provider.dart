import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/fb_commute_model.dart';

class FbCommuteProvider extends GetConnect {

  CollectionReference commuteRef = FirebaseFirestore.instance
      .collection(FirebaseConstants.commute);

  NumberFormat formatter = new NumberFormat("00");


  @override
  void onInit() {
  }

  Future<Map<String,FbCommute>> getCommutesByMonth(String id,String month) async {
    QuerySnapshot<Map<String, dynamic>> doc = await commuteRef.doc(id).collection(month).get();
    Map<String,FbCommute> ret = {};
    doc.docs!.forEach((element) {
      ret[element.id] = FbCommute.fromJson(element.data());
    });
    return ret;
  }

  Future<FbCommute> setCommute(String id,Timestamp stamp,FbCommute fbCommute) async{
    DateTime date = stamp.toDate();
    String month = date.year.toString() + formatter.format(date.month);
    String key = month + formatter.format(date.day);

    await commuteRef.doc(id).collection(month).doc(key).set(fbCommute.toJson());
    return fbCommute;
  }

}
