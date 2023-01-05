import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commute/app/data/models/fb_commute_model.dart';
import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/services/fb_user_service.dart';
import 'package:commute/app/modules/home/repositories/print_commute_repository.dart';
import 'package:commute/constants.dart';
import 'package:commute/utils/functions/get_date_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:get/get.dart';
import 'package:printing/printing.dart';

class PrintCommuteController extends GetxController {
  final PrintCommuteRepository repository;

  PrintCommuteController({required this.repository});

  final FbUser _localUser = Get.find<FbUserService>().fbUser;
  late DateTime _targetMonth;

  Map<String, FbCommute> _commutes = {};

  List<List<String>> commutesList = [];

  num totalWorkUnit = 0;

  @override
  void onInit() async {
    _targetMonth = Timestamp.now().toDate();

    _commutes = await repository.getCommutes(_localUser.id!, _targetMonth);
    for(String i in _commutes.keys){
      print(_commutes[i]!.endAt);
    }
    _generateCommuteList();
    update();

    super.onInit();
  }

  void printPressed() async {
    final pdf = pw.Document();
    final pw.Font font = await PdfGoogleFonts.nanumGothicRegular();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Text(
              "<${_targetMonth.year}. ${_targetMonth.month}월 근무 내역서>",
              style: pw.TextStyle(font: font, fontSize: 18),
            ),
            pw.SizedBox(height: 20),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              pw.Text(
                '성명: ${_localUser.name}',
                style: pw.TextStyle(font: font, fontSize: 12),
              ),
              pw.SizedBox(width: 10),
              pw.Text(
                '소속: ${_localUser.department}',
                style: pw.TextStyle(font: font, fontSize: 12),
              ),
              pw.SizedBox(width: 10),
              pw.Text(
                '직위 : ${_localUser.position}',
                style: pw.TextStyle(font: font, fontSize: 12),
              ),
            ]),
            pw.SizedBox(height: 10),
            pw.Container(
                height: 1,
                padding: pw.EdgeInsets.symmetric(vertical: 2),
                width: double.infinity,
                color: PdfColor.fromHex("#000000")),
            pw.Expanded(
                child: pw.ListView.separated(
                    padding: pw.EdgeInsets.zero,
                    itemBuilder: (context, idx) {
                      if (idx == 0) {
                        return pw.SizedBox(
                          height: 18,
                          child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.SizedBox(
                                width: 80,
                                child: pw.Center(
                                  child: pw.Text(
                                    "날짜",
                                    style:
                                        pw.TextStyle(font: font, fontSize: 12),
                                  ),
                                ),
                              ),
                              pw.SizedBox(
                                width: 100,
                                child: pw.Center(
                                  child: pw.Text(
                                    "출근 시간",
                                    style:
                                        pw.TextStyle(font: font, fontSize: 12),
                                  ),
                                ),
                              ),
                              pw.SizedBox(
                                width: 100,
                                child: pw.Center(
                                  child: pw.Text(
                                    "퇴근 시간",
                                    style:
                                        pw.TextStyle(font: font, fontSize: 12),
                                  ),
                                ),
                              ),
                              pw.SizedBox(
                                width: 60,
                                child: pw.Center(
                                  child: pw.Text(
                                    "근무 단위",
                                    style:
                                        pw.TextStyle(font: font, fontSize: 12),
                                  ),
                                ),
                              ),
                              pw.SizedBox(
                                width: 100,
                                child: pw.Center(
                                  child: pw.Text(
                                    "비고",
                                    style:
                                        pw.TextStyle(font: font, fontSize: 12),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      if (idx == commutesList.length + 1) {
                        return pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 14,
                                child: pw.Text(
                                  "총 근무 단위 : ${totalWorkUnit} 단위",
                                  style: pw.TextStyle(font: font, fontSize: 10),
                                ),
                              )
                            ]);
                      }
                      return pw.SizedBox(
                          height: 14,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.SizedBox(
                                  width: 80,
                                  child: pw.Center(
                                    child: pw.Text(
                                      commutesList[idx - 1][0],
                                      style: pw.TextStyle(
                                          font: font, fontSize: 10),
                                    ),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text(
                                      commutesList[idx - 1][1],
                                      style: pw.TextStyle(
                                          font: font, fontSize: 10),
                                    ),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text(
                                      commutesList[idx - 1][2],
                                      style: pw.TextStyle(
                                          font: font, fontSize: 10),
                                    ),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 60,
                                  child: pw.Center(
                                    child: pw.Text(
                                      commutesList[idx - 1][3],
                                      style: pw.TextStyle(
                                          font: font, fontSize: 10),
                                    ),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text(
                                      commutesList[idx - 1][4],
                                      style: pw.TextStyle(
                                          font: font, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ]));
                    },
                    itemCount: commutesList.length + 2,
                    separatorBuilder: (context, int index) => pw.Container(
                        height: 1,
                        padding: pw.EdgeInsets.symmetric(vertical: 2),
                        width: double.infinity,
                        color: PdfColor.fromHex("#000000")))),
          ]); // Center
        }));

    Get.dialog(
      Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        child: SizedBox(
          height: 400,
          child: PdfPreview(
            build: (format) => pdf.save(),
          ),
        ),
      ),
    );
  }

  void toLeft() async {
    if (_targetMonth.month == 1) {
      _targetMonth = DateTime(_targetMonth.year - 1, 12);
    } else {
      _targetMonth = DateTime(_targetMonth.year, _targetMonth.month - 1);
    }
    _commutes = await repository.getCommutes(_localUser.id!, _targetMonth);
    _generateCommuteList();
    update();
  }

  void toRight() async {
    if (_targetMonth.month == 12) {
      _targetMonth = DateTime(_targetMonth.year + 1, 1);
    } else {
      _targetMonth = DateTime(_targetMonth.year, _targetMonth.month + 1);
    }
    _commutes = await repository.getCommutes(_localUser.id!, _targetMonth);
    _generateCommuteList();
    update();
  }

  void _generateCommuteList() {
    totalWorkUnit = 0;
    commutesList = [];
    for(String i in _commutes.keys){
      print(_commutes[i]!.endAt);
    }
    for (int i = 0;
        i < DateTime(_targetMonth.year, _targetMonth.month + 1, 0).day;
        i++) {
      FbCommute? dataPath = _commutes[_getDateStringWithidx(i)];
      CommuteStatus status = _calcStatus(dataPath);
      String workUnit = '';
      if (status == CommuteStatus.endExist) {
        workUnit = _calcWorkUnit(dataPath!);
        totalWorkUnit += num.parse(workUnit != '' ? workUnit : "0");
      }

      commutesList.add([
        _getDateStringWithidxView(i),
        status != CommuteStatus.dataNotExist
            ? dateTimeToString(dataPath!.comeAt!.toDate())
            : "",
        status == CommuteStatus.endExist
            ? dateTimeToString(dataPath!.endAt!.toDate())
            : "",
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
    Timestamp distanceStamp = Timestamp.fromMillisecondsSinceEpoch(
        commute.endAt!.millisecondsSinceEpoch -
            commute.comeAt!.millisecondsSinceEpoch);
    DateTime distance = distanceStamp.toDate();
    int total = distance.subtract(Duration(hours: 9)).hour * 60 +
        distance.minute -
        ((commute.workAtLunch == true) ? 0 : 60);
    if (total > 390) {
      return planUnitList[2];
    } else if (total > 285) {
      return planUnitList[1];
    } else if (total < 60) {
      return "0";
    }
    return planUnitList[0];
  }

  String _getDateStringWithidx(int idx) {
    return getDateString(
        DateTime(_targetMonth.year, _targetMonth.month, idx + 1));

  }

  String _getDateStringWithidxView(int idx) {
    String k = getDateString(
        DateTime(_targetMonth.year, _targetMonth.month, idx + 1));
    return k.substring(0,4)+"-"+k.substring(4,6)+"-"+k.substring(6,8)+weekDaytoString(DateTime(_targetMonth.year, _targetMonth.month, idx + 1).weekday);
  }

  String weekDaytoString(int week){
    List<String> weekString = ['(월)','(화)','(수)','(목)','(금)','(토)','(일)'];
    return weekString[week-1];
  }
}
