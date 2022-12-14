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

  Future<FbUser?> getUser(String userId) async {
    DocumentSnapshot<FbUser> documentSnapshot = await userRef.doc(userId).get();
    return documentSnapshot.data();
  }

  Future<Map<String, FbUser>> getAllUser() async {
    QuerySnapshot<FbUser> querySnapshot = await userRef.get();

    return {
      for (QueryDocumentSnapshot<FbUser> e in querySnapshot.docs) e.id: e.data()
    };
  }
}
