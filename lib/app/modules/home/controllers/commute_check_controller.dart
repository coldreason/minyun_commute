import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/app/data/models/fb_commute_model.dart';
import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/services/fb_commute_service.dart';
import 'package:commute/app/data/services/fb_user_service.dart';
import 'package:commute/app/modules/home/repositories/commute_check_repository.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommuteCheckController extends GetxController {
  final CommuteCheckRepository repository;

  CommuteCheckController({required this.repository});

  final TextEditingController commentController = TextEditingController();

  FbCommute? localCommute;
  late FbUser localUser;
  late DateTime targetMonth;

  @override
  void onInit() async {

    targetMonth = Timestamp.now().toDate();
    localUser = Get.find<FbUserService>().fbUser;
    if (!Get.find<FbCommuteService>().initialized) {
      Get.find<FbCommuteService>().fbCommute = await repository.getCommute(
          localUser.id!, targetMonth);
    }
    localCommute = Get.find<FbCommuteService>().fbCommute;
    super.onInit();
    update();

  }

  void changeLunchTimeWork(bool value) async {
    localCommute!.workAtLunch = value;

    Get.find<FbCommuteService>().fbCommute = await repository.setCommute(
        localUser.id!,
        Timestamp.now().toDate(),
        localCommute!);
    update();
  }

  void checkStart() async {
    localCommute!.comeAt = Timestamp.now();
    Get.find<FbCommuteService>().fbCommute = await repository.setCommute(
        localUser.id!,
        localCommute!.comeAt!.toDate(),
        localCommute!);
    update();
  }

  void checkFinish() async {
    localCommute!.endAt = Timestamp.now();
    Get.find<FbCommuteService>().fbCommute = await repository.setCommute(
        localUser.id!,
        localCommute!.endAt!.toDate(),
        localCommute!);
    update();
  }

  void checkFinishAgain() async {
    localCommute!.comment = commentController.value.text;
    checkFinish();
    commentController.clear();
  }
}
