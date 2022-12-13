import 'package:commute/constants.dart';
import 'package:commute/utils/helpers/masks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../data/models/fb_plan_model.dart';
import '../../controllers/home_controller.dart';


class PlanAllPage extends GetView<HomeController> {
  const PlanAllPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: GetBuilder<HomeController>(builder: (_) {
          return TableCalendar(
            rowHeight: controller.userScreenType == UserScreenType.pcWeb
                ? 130 : controller.userScreenType == UserScreenType.tablet
                ? 100
                :
            80,
            calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(color: Colors.orange),
                selectedDecoration:
                BoxDecoration(color: Theme
                    .of(context)
                    .primaryColor),
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
              controller.monthChangeAll(dateTime);
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarBuilders: CalendarBuilders(
              outsideBuilder: (context, date, events) {
                return DateBody(date: date, color: Colors.grey);
              },
              todayBuilder: (context, date, events) {
                String key = date.year.toString() +
                    dateStringFormatter.format(date.month) +
                    dateStringFormatter.format(date.day);
                return DateBody(
                  date: date,
                  color: Colors.orange,
                  body: PlanUsersTile(plans: controller.allPlans[key] ?? []),
                );
              },
              defaultBuilder: (context, date, events) {
                String key = date.year.toString() +
                    dateStringFormatter.format(date.month) +
                    dateStringFormatter.format(date.day);
                return DateBody(
                  date: date,
                  color: Colors.black,
                  body: PlanUsersTile(plans: controller.allPlans[key] ?? []),
                );
              },
            ),
            focusedDay: controller.targetMonth,
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2030),
          );
        }));
  }
}

class DateBody extends StatelessWidget {
  const DateBody({Key? key, required this.date, required this.color, this.body})
      : super(key: key);

  final DateTime date;
  final Color color;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4.0),
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: 20,
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    date.day.toString(),
                    style: TextStyle(color: color),
                  ),
                ],
              ),
            ),
            Expanded(child: body ?? Container())
          ],
        ));
  }
}

class PlanUsersTile extends GetView<HomeController> {
  const PlanUsersTile({Key? key, required this.plans}) : super(key: key);
  final List<FbPlan> plans;

  @override
  Widget build(BuildContext context) {
    double fontSize = controller.userScreenType == UserScreenType.pcWeb
        ? 10 : controller.userScreenType == UserScreenType.tablet ? 9 : 8;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, idx) {
          return Text(
              "${controller.allUser[plans[idx].id!]!.name!} ${controller
        .userScreenType == UserScreenType.pcWeb? "${dateStringFormatter.format(plans[idx].comeAt!.toDate().hour)}:${dateStringFormatter.format(plans[idx].comeAt!.toDate().minute)} - ${dateStringFormatter.format(plans[idx].endAt!.toDate().hour)}:${dateStringFormatter.format(plans[idx].endAt!.toDate().minute)}":""}",
          style: TextStyle(color: Colors.black, fontSize: fontSize),);
        },
      ),
    );
  }
}
