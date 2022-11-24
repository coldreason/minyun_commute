import 'package:commute/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controllers/home_controller.dart';

class PlanAllPage extends GetView<HomeController> {
  const PlanAllPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        height: 60,
                        child: ListView.builder(
                          itemCount: (controller.allPlans[key] ?? []).length,
                          itemBuilder: (context, idx) {
                            return FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    "${controller.allUser[controller.allPlans[key]![idx].id!]!.name!} ${formatter.format(controller.allPlans[key]![idx].comeAt!.toDate().hour)}:${formatter.format(controller.allPlans[key]![idx].comeAt!.toDate().minute)}-${formatter.format(controller.allPlans[key]![idx].endAt!.toDate().hour)}:${formatter.format(controller.allPlans[key]![idx].endAt!.toDate().minute)}(${controller.allPlans[key]![idx].unit})",
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
                        height: 60,
                        child: ListView.builder(
                          itemCount: (controller.allPlans[key] ?? []).length,
                          itemBuilder: (context, idx) {
                            return FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    "${controller.allUser[controller.allPlans[key]![idx].id!]!.name!} ${formatter.format(controller.allPlans[key]![idx].comeAt!.toDate().hour)}:${formatter.format(controller.allPlans[key]![idx].comeAt!.toDate().minute)}-${formatter.format(controller.allPlans[key]![idx].endAt!.toDate().hour)}:${formatter.format(controller.allPlans[key]![idx].endAt!.toDate().minute)}(${controller.allPlans[key]![idx].unit})",
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
