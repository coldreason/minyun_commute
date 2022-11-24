import 'package:commute/app/flutter_flow/flutter_flow_theme.dart';
import 'package:commute/app/flutter_flow/flutter_flow_widgets.dart';
import 'package:commute/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:selectable_list/selectable_list.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.localUser!.name}님 안녕하세요',
            style: FlutterFlowTheme.of(context)
                .bodyText1
                .copyWith(color: Colors.white)),
        actions: [
          MaterialButton(
            onPressed: controller.logout,
            child: Text('로그아웃',
                style: FlutterFlowTheme.of(context)
                    .bodyText1
                    .copyWith(color: Colors.white)),
          )
        ],
        bottom: TabBar(
          controller: controller.tabController,
          tabs: <Widget>[
            Tab(
                child: Column(children: <Widget>[
              Icon(Icons.pending_actions),
              Text("출퇴근 관리")
            ])),
            Tab(icon: Icon(Icons.memory), text: "근무계획"),
            Tab(icon: Icon(Icons.library_books), text: "근무표"),
            Tab(icon: Icon(Icons.book_outlined), text: "근무내역")
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: <Widget>[
          CommuteCheckPage(),
          PlanCommutePage(),
          PlanAllPage(),
          PrintCommutes()
        ],
      ),
    );
  }
}

class PrintCommutes extends GetView<HomeController> {
  const PrintCommutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class PlanAllPage extends GetView<HomeController> {
  const PlanAllPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat("00");
    return SingleChildScrollView(
      child: TableCalendar(
        rowHeight: 120,
        calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(color: Colors.orange),
            selectedDecoration:
            BoxDecoration(color: Theme.of(context).primaryColor),
            todayTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white)),
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonDecoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20.0),
          ),
          formatButtonTextStyle: TextStyle(color: Colors.white),
          formatButtonShowsNext: false,
        ),
        onPageChanged: (dateTime) {
          controller.monthChange(dateTime);
        },
        startingDayOfWeek: StartingDayOfWeek.sunday,
        calendarBuilders: CalendarBuilders(
          outsideBuilder: (context, date, events) {
            return Container(
                margin: const EdgeInsets.all(4.0),
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ));
          },
          todayBuilder: (context, date, events) {
            String key = date.year.toString() +
                formatter.format(date.month) +
                formatter.format(date.day);
            return Container(
                margin: const EdgeInsets.all(4.0),
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height:60,
                        child: ListView.builder(
                          itemCount:
                          (controller.allPlans[key]??[]).length,
                          itemBuilder: (context, idx) {
                            return FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    "${controller.allUser[controller.allPlans[key]![idx]!.id!]!.name!} ${formatter.format(controller.allPlans[key]![idx]!.comeAt!.toDate().hour)}:${formatter.format(controller.allPlans[key]![idx]!.comeAt!.toDate().minute)}-${formatter.format(controller.allPlans[key]![idx]!.endAt!.toDate().hour)}:${formatter.format(controller.allPlans[key]![idx].endAt!.toDate().minute)}(${controller.allPlans[key]![idx]!.unit})",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ));
          },
          defaultBuilder: (context, date, events) {
            String key = date.year.toString() +
                formatter.format(date.month) +
                formatter.format(date.day);
            return Container(
                margin: const EdgeInsets.all(4.0),
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height:60,
                        child: ListView.builder(
                          itemCount:
                          (controller.allPlans[key]??[]).length,
                          itemBuilder: (context, idx) {
                            return FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    "${controller.allUser[controller.allPlans[key]![idx]!.id!]!.name!} ${formatter.format(controller.allPlans[key]![idx]!.comeAt!.toDate().hour)}:${formatter.format(controller.allPlans[key]![idx]!.comeAt!.toDate().minute)}-${formatter.format(controller.allPlans[key]![idx]!.endAt!.toDate().hour)}:${formatter.format(controller.allPlans[key]![idx].endAt!.toDate().minute)}(${controller.allPlans[key]![idx]!.unit})",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ));
          },
        ),
        focusedDay: controller.targetMonth,
        firstDay: DateTime.utc(2020),
        lastDay: DateTime.utc(2030),
      ),
    );
  }
}

class CommuteCheckPage extends GetView<HomeController> {
  const CommuteCheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<HomeController>(builder: (_) {
        return Container(
          child: (controller.localCommute == null)
              ? Container()
              : (controller.localCommute!.comeAt == null)
                  ? NotCommuteYetSheet(
                      func: controller.checkStart,
                    )
                  : (controller.localCommute!.endAt == null)
                      ? WorkingNowSheet(
                          func: controller.checkFinish,
                        )
                      : AlreadyGoHomeSheet(),
        );
      }),
    );
  }
}

class WorkingNowSheet extends StatelessWidget {
  const WorkingNowSheet({Key? key, required this.func}) : super(key: key);

  final Function func;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommutePageButton(
          func: func,
          text: '퇴근',
        ),
      ],
    );
  }
}

class AlreadyGoHomeSheet extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GetBuilder<HomeController>(builder: (_) {
          return Center(
            child: IntrinsicHeight(
              child: Container(
                color: CupertinoTheme.of(context).barBackgroundColor,
                child: CupertinoFormRow(
                  prefix: Row(
                    children: <Widget>[
                      Icon(
                        // Wifi icon is updated based on switch value.
                        controller.localCommute!.workAtLunch!
                            ? CupertinoIcons.wifi
                            : CupertinoIcons.wifi_slash,
                        color: controller.localCommute!.workAtLunch!
                            ? CupertinoColors.systemBlue
                            : CupertinoColors.systemRed,
                      ),
                      const SizedBox(width: 10),
                      const Text('점심시간 근무')
                    ],
                  ),
                  child: CupertinoSwitch(
                    // This bool value toggles the switch.
                    value: controller.localCommute!.workAtLunch!,
                    thumbColor: CupertinoColors.systemBlue,
                    trackColor: CupertinoColors.systemRed.withOpacity(0.14),
                    activeColor: CupertinoColors.systemRed.withOpacity(0.64),
                    onChanged: (bool? value) {
                      // This is called when the user toggles the switch.
                      controller.changeLunchTimeWork(value!);
                    },
                  ),
                ),
              ),
            ),
          );
        }),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
          child: TextFormField(
            obscureText: false,
            controller: controller.commentController,
            decoration: InputDecoration(
              labelText: 'Comment',
              labelStyle: FlutterFlowTheme.of(context).bodyText2,
              hintStyle: FlutterFlowTheme.of(context).bodyText2,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
            ),
            style: FlutterFlowTheme.of(context).bodyText1,
            maxLines: null,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommutePageButton(
              func: controller.checkFinishAgain,
              text: '다시퇴근',
            ),
          ],
        ),
      ],
    );
  }
}

class NotCommuteYetSheet extends StatelessWidget {
  const NotCommuteYetSheet({Key? key, required this.func}) : super(key: key);

  final Function func;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommutePageButton(
          func: func,
          text: '출근',
        ),
      ],
    );
  }
}

class CommutePageButton extends StatelessWidget {
  const CommutePageButton({Key? key, required this.func, required this.text})
      : super(key: key);

  final Function func;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: () {
        func();
      },
      text: text,
      options: FFButtonOptions(
        width: 150,
        height: 50,
        color: FlutterFlowTheme.of(context).primaryColor,
        textStyle: FlutterFlowTheme.of(context).subtitle2.override(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
        elevation: 3,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
      ),
    );
  }
}

class PlanCommutePage extends GetView<HomeController> {
  const PlanCommutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller.scrollControllerB,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Center(child: Text('출근 예정')),
              ),
              Expanded(
                child: Center(child: Text('퇴근 예정')),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          GetBuilder<HomeController>(builder: (_) {
            return Row(
              children: [
                Expanded(
                  child: SelectableList<String, String>(
                      items: planTimesH,
                      itemBuilder: (context, text, selected, onTap) => ListTile(
                          title: Text("${text}시"),
                          selected: selected,
                          onTap: () {
                            onTap!();
                            controller.settingClicked();
                          }),
                      selectedValue: controller.planGoWorkSettingH,
                      onItemSelected: (target) {
                        controller.changePlanGoWorkSettingH(target);
                      },
                      onItemDeselected: (target) {}),
                ),
                Expanded(
                  child: SelectableList<String, String>(
                      items: planTimesM,
                      itemBuilder: (context, text, selected, onTap) => ListTile(
                          title: Text("${text}분"),
                          selected: selected,
                          onTap: () {
                            onTap!();
                            controller.settingClicked();
                          }),
                      selectedValue: controller.planGoWorkSettingM,
                      onItemSelected: (target) {
                        controller.changePlanGoWorkSettingM(target);
                      },
                      onItemDeselected: (target) {}),
                ),
                Expanded(
                  child: SelectableList<String, String>(
                      items: planTimesH,
                      itemBuilder: (context, text, selected, onTap) => ListTile(
                          title: Text("${text}시"),
                          selected: selected,
                          onTap: () {
                            onTap!();
                            controller.settingClicked();
                          }),
                      selectedValue: controller.planGoHomeSettingH,
                      onItemSelected: (target) {
                        controller.changePlanGoHomeSettingH(target);
                      },
                      onItemDeselected: (target) {}),
                ),
                Expanded(
                  child: SelectableList<String, String>(
                      items: planTimesM,
                      itemBuilder: (context, text, selected, onTap) => ListTile(
                          title: Text("${text}분"),
                          selected: selected,
                          onTap: () {
                            onTap!();
                            controller.settingClicked();
                          }),
                      selectedValue: controller.planGoHomeSettingM,
                      onItemSelected: (target) {
                        controller.changePlanGoHomeSettingM(target);
                      },
                      onItemDeselected: (target) {}),
                ),
                Expanded(
                  child: SelectableList<String, String>(
                      items: planUnitList,
                      itemBuilder: (context, text, selected, onTap) => ListTile(
                          title: Text("${text}단위"),
                          selected: selected,
                          onTap: () {
                            onTap!();
                            controller.settingClicked();
                          }),
                      selectedValue: controller.planUnit,
                      onItemSelected: (target) {
                        controller.changePlanUnit(target);
                      },
                      onItemDeselected: (target) {}),
                ),
                MaterialButton(
                  onPressed: controller.setPlan,
                  child: Text('반영'),
                )
              ],
            );
          }),
          GetBuilder<HomeController>(builder: (_) {
            NumberFormat formatter = NumberFormat("00");

            return TableCalendar(
              rowHeight: 120,
              selectedDayPredicate: (day) {
                return controller.checkSelected(day);
              },
              calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(color: Colors.orange),
                  selectedDecoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  todayTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              onPageChanged: (dateTime) {
                controller.monthChange(dateTime);
              },
              startingDayOfWeek: StartingDayOfWeek.sunday,
              onDaySelected: (date, events) {
                controller.dateClicked(date);
              },
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, events) {
                  String key = date.year.toString() +
                      formatter.format(date.month) +
                      formatter.format(date.day);
                  return Container(
                      margin: const EdgeInsets.all(4.0),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          if (controller.myPlans[key] != null)
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                children: [
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${formatter.format(controller.myPlans[key]!.comeAt!.toDate().hour)}:${formatter.format(controller.myPlans[key]!.comeAt!.toDate().minute)}-${formatter.format(controller.myPlans[key]!.endAt!.toDate().hour)}:${formatter.format(controller.myPlans[key]!.endAt!.toDate().minute)}(${controller.myPlans[key]!.unit})",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          child: MaterialButton(
                                            onPressed: () {
                                              controller.deletePlan(date);
                                            },
                                            child: Icon(Icons.clear),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Container()
                        ],
                      ));
                },
                outsideBuilder: (context, date, events) {
                  return Container(
                      margin: const EdgeInsets.all(4.0),
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ));
                },
                todayBuilder: (context, date, events) {
                  String key = date.year.toString() +
                      formatter.format(date.month) +
                      formatter.format(date.day);
                  return Container(
                      margin: const EdgeInsets.all(4.0),
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.orange),
                                ),
                              ],
                            ),
                          ),
                          if (controller.myPlans[key] != null)
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                children: [
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${formatter.format(controller.myPlans[key]!.comeAt!.toDate().hour)}:${formatter.format(controller.myPlans[key]!.comeAt!.toDate().minute)}-${formatter.format(controller.myPlans[key]!.endAt!.toDate().hour)}:${formatter.format(controller.myPlans[key]!.endAt!.toDate().minute)}(${controller.myPlans[key]!.unit})",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          child: MaterialButton(
                                            onPressed: () {
                                              controller.deletePlan(date);
                                            },
                                            child: Icon(Icons.clear),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Container()
                        ],
                      ));
                },
                defaultBuilder: (context, date, events) {
                  String key = date.year.toString() +
                      formatter.format(date.month) +
                      formatter.format(date.day);
                  return Container(
                      margin: const EdgeInsets.all(4.0),
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          if (controller.myPlans[key] != null)
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                children: [
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${formatter.format(controller.myPlans[key]!.comeAt!.toDate().hour)}:${formatter.format(controller.myPlans[key]!.comeAt!.toDate().minute)}-${formatter.format(controller.myPlans[key]!.endAt!.toDate().hour)}:${formatter.format(controller.myPlans[key]!.endAt!.toDate().minute)}(${controller.myPlans[key]!.unit})",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          child: MaterialButton(
                                            onPressed: () {
                                              controller.deletePlan(date);
                                            },
                                            child: Icon(Icons.clear),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Container()
                        ],
                      ));
                },
              ),
              focusedDay: controller.targetMonth,
              firstDay: DateTime.utc(2020),
              lastDay: DateTime.utc(2030),
            );
          }),
        ],
      ),
    );
  }
}
