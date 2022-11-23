import 'package:cloud_firestore/cloud_firestore.dart';

class FbPlan {
  String? id;
  Timestamp? comeAt;
  Timestamp? endAt;
  String? unit;

  FbPlan({this.id, this.comeAt, this.endAt, this.unit});

  FbPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comeAt = json['comeAt'];
    endAt = json['endAt'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['comeAt'] = comeAt;
    data['endAt'] = endAt;
    data['unit'] = unit;
    return data;
  }
}
