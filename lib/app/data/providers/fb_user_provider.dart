import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/constants.dart';
import 'package:get/get.dart';

import '../models/fb_user_model.dart';

class FbUserProvider extends GetConnect {

  CollectionReference<FbUser> userRef = FirebaseFirestore.instance
      .collection(FirebaseConstants.user)
      .withConverter<FbUser>(
    fromFirestore: (snapshot, _) => FbUser.fromJson(snapshot.data()!),
    toFirestore: (FbUser, _) => FbUser.toJson(),
  );

  Future<FbUser?> getUser(String userId)async{
    DocumentSnapshot<FbUser> userDoc = await userRef.doc(userId).get();
    FbUser? user = userDoc.data();
    return user;
  }

  Future<Map<String,FbUser>> getAllUser() async {
    QuerySnapshot<FbUser> doc = await userRef.get();
    Map<String,FbUser> ret = {};
    doc.docs.forEach((element) {
      ret[element.id] = element.data();
    });
    return ret;
  }

  @override
  void onInit() {
  }

}
