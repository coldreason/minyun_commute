import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/app/data/models/fb_commute_model.dart';
import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/services/fb_user_service.dart';
import 'package:commute/app/modules/home/repositories/print_commute_repository.dart';
import 'package:commute/constants.dart';
import 'package:commute/utils/functions/get_date_string.dart';

import 'package:get/get.dart';

class PrintCommuteController extends GetxController {
  final PrintCommuteRepository repository;

  PrintCommuteController({required this.repository});

  final FbUser localUser = Get.find<FbUserService>().fbUser;
  late DateTime targetMonth;
  Map<String, FbCommute> commutes = {};

  List<List<String>> commutesList = [];

  num totalWorkUnit = 0;

  @override
  void onInit() async {
    targetMonth = Timestamp.now().toDate();

    commutes = await repository.getCommutes(localUser.id!, targetMonth);

    _generateCommuteList();
    update();

    super.onInit();
  }

  void toLeft() async {
    if (targetMonth.month == 1) {
      targetMonth = DateTime(targetMonth.year - 1, 12);
    } else {
      targetMonth = DateTime(targetMonth.year, targetMonth.month - 1);
    }
    commutes = await repository.getCommutes(localUser.id!, targetMonth);
    _generateCommuteList();
    update();
  }

  void toRight() async {
    if (targetMonth.month == 12) {
      targetMonth = DateTime(targetMonth.year + 1, 1);
    } else {
      targetMonth = DateTime(targetMonth.year, targetMonth.month + 1);
    }
    commutes = await repository.getCommutes(localUser.id!, targetMonth);
    _generateCommuteList();
    update();

  }

  void _generateCommuteList() {
    totalWorkUnit = 0;
    commutesList = [];
    for (int i = 0;
        i < DateTime(targetMonth.year, targetMonth.month + 1, 0).day;
        i++) {
      FbCommute? dataPath = commutes[_getDateStringWithidx(i)];
      CommuteStatus status = _calcStatus(dataPath);
      String workUnit = '';
      if (status == CommuteStatus.endExist) {
        workUnit = _calcWorkUnit(dataPath!);
        totalWorkUnit += num.parse(workUnit != '' ? workUnit : "0");
      }

      commutesList.add([
        _getDateStringWithidx(i),
        status != CommuteStatus.dataNotExist
            ? dateTimeToString(dataPath!.comeAt!.toDate())
            : "",
        status == CommuteStatus.endExist ? dateTimeToString(dataPath!.endAt!.toDate()) : "",
        workUnit,
        status == CommuteStatus.endExist ? dataPath!.comment ?? "" : ""
      ]);
    }
  }

  CommuteStatus _calcStatus(FbCommute? fbCommute) {
    if (fbCommute == null) return CommuteStatus.dataNotExist;
    if (fbCommute.endAt != null) return CommuteStatus.endExist;
    return CommuteStatus.goExist;
  }

  String _calcWorkUnit(FbCommute commute) {
    DateTime distance = (Timestamp.fromMillisecondsSinceEpoch(
            commute.endAt!.millisecondsSinceEpoch -
                commute.comeAt!.millisecondsSinceEpoch))
        .toDate();
    int total = (distance.hour - 9) * 60 +
        distance.minute -
        ((commute.workAtLunch == true) ? 0 : 60);
    if (total > 390) {
      return planUnitList[2];
    } else if (total > 285) {
      return planUnitList[1];
    } else if (total < 60) {
      return "";
    }
    return planUnitList[0];
  }

  String _getDateStringWithidx(int idx) {
    return getDateString(
        DateTime(targetMonth.year, targetMonth.month, idx + 1));
  }


}
