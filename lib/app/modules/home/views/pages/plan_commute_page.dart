import 'package:commute/app/modules/home/controllers/plan_commute_controller.dart';
import 'package:commute/constants.dart';
import 'package:commute/utils/helpers/masks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selectable_list/selectable_list.dart';
import 'package:table_calendar/table_calendar.dart';

class PlanCommutePage extends GetView<PlanCommuteController> {
  const PlanCommutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          GetBuilder<PlanCommuteController>(builder: (_) {
            return Row(
              children: [
                Expanded(
                  child: SelectableList<String, String>(
                      items: planTimesH,
                      itemBuilder: (context, text, selected, onTap) => ListTile(
                          title: Text("$text시"),
                          selected: selected,
                          onTap: () {
                            onTap!();
                            controller.settingClicked();
                          }),
                      selectedValue: controller.planGoWorkSettingH,
                      onItemSelected: (target) =>
                        controller.changePlanGoWorkSettingH(target)
                      ,
                      onItemDeselected: (target)=>{}
                      ),
                ),
                Expanded(
                  child: SelectableList<String, String>(
                      items: planTimesM,
                      itemBuilder: (context, text, selected, onTap) => ListTile(
                          title: Text("$text분"),
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
                          title: Text("$text시"),
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
                          title: Text("$text분"),
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
                          title: Text("$text단위"),
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
          GetBuilder<PlanCommuteController>(builder: (_){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                Text('총 근무 단위 : '),
                Text(controller.sumPlanUnit.toString()),
              ],),
            );
          },

          ),
          GetBuilder<PlanCommuteController>(builder: (_) {
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
                      dateStringFormatter.format(date.month) +
                      dateStringFormatter.format(date.day);
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
                                          "${dateStringFormatter.format(controller.myPlans[key]!.comeAt!.toDate().hour)}:${dateStringFormatter.format(controller.myPlans[key]!.comeAt!.toDate().minute)}-${dateStringFormatter.format(controller.myPlans[key]!.endAt!.toDate().hour)}:${dateStringFormatter.format(controller.myPlans[key]!.endAt!.toDate().minute)}(${controller.myPlans[key]!.unit})",
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
                      dateStringFormatter.format(date.month) +
                      dateStringFormatter.format(date.day);
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
                                          "${dateStringFormatter.format(controller.myPlans[key]!.comeAt!.toDate().hour)}:${dateStringFormatter.format(controller.myPlans[key]!.comeAt!.toDate().minute)}-${dateStringFormatter.format(controller.myPlans[key]!.endAt!.toDate().hour)}:${dateStringFormatter.format(controller.myPlans[key]!.endAt!.toDate().minute)}(${controller.myPlans[key]!.unit})",
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
                      dateStringFormatter.format(date.month) +
                      dateStringFormatter.format(date.day);
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
                                          "${dateStringFormatter.format(controller.myPlans[key]!.comeAt!.toDate().hour)}:${dateStringFormatter.format(controller.myPlans[key]!.comeAt!.toDate().minute)}-${dateStringFormatter.format(controller.myPlans[key]!.endAt!.toDate().hour)}:${dateStringFormatter.format(controller.myPlans[key]!.endAt!.toDate().minute)}(${controller.myPlans[key]!.unit})",
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