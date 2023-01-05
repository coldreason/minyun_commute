import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/constants.dart';
import 'package:get/get.dart';

import '../models/fb_user_model.dart';

class FbUserProvider extends GetConnect {
  DocumentReference<Map<String, dynamic>> userRef = FirebaseFirestore.instance
      .collection(FirebaseConstants.users)
      .doc(FirebaseConstants.users);

  Future<FbUser?> getUser(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await userRef.get();
    return FbUser.fromJson(documentSnapshot.data()![userId]);
  }

  Future<Map<String, FbUser>> getAllUser() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await userRef.get();

    return {
      for (String e in documentSnapshot.data()!.keys)
        e: FbUser.fromJson(documentSnapshot.data()![e])
    };
  }
}
