import 'package:cloud_firestore/cloud_firestore.dart';

class FbCommute {
  String? id;
  String? comment;
  Timestamp? comeAt;
  Timestamp? endAt;
  bool? workAtLunch;

  FbCommute({this.id, this.comment, this.comeAt, this.endAt,this.workAtLunch});

  FbCommute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    comeAt = json['comeAt'];
    endAt = json['endAt'];
    workAtLunch = json['workAtLunch'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['comeAt'] = comeAt;
    data['endAt'] = endAt;
    data['workAtLunch'] = workAtLunch;
    return data;
  }
}
