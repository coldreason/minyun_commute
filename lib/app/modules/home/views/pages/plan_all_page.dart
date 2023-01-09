import 'package:commute/app/modules/home/controllers/plan_all_controller.dart';
import 'package:commute/constants.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class PlanAllPage extends GetView<PlanAllController> {
  const PlanAllPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.pageResize();
    return SingleChildScrollView(
        child: GetBuilder<PlanAllController>(builder: (_) {
      return Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                FilterButton(
                  func: controller.filterSelected,
                  isChecked: controller.filter[0],
                  buttonIndex: 0,
                ),
                FilterButton(
                  func: controller.filterSelected,
                  isChecked: controller.filter[1],
                  buttonIndex: 1,
                ),
                MaterialButton(onPressed: controller.savePressed,child: Text('Save'),)
              ],
            ),
            WidgetsToImage(
              controller: controller.widgetsToImageController,
              child: Container(
                color: Colors.white,
                child: TableCalendar(
                  rowHeight: controller.screenType == UserScreenType.pcWeb
                      ? 140
                      : controller.screenType == UserScreenType.tablet
                          ? 100
                          : 80,
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
                    controller.monthChangeAll(dateTime);
                  },
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  calendarBuilders: CalendarBuilders(
                    outsideBuilder: (context, date, events) {
                      return DateBody(date: date, color: Colors.grey);
                    },
                    todayBuilder: (context, date, events) {
                      return DateBody(
                        date: date,
                        color: Colors.orange,
                        body: PlanUsersTile(
                          plans: controller.getCalanderListString(
                              date, controller.screenType),
                          userScreenType: controller.screenType,
                        ),
                      );
                    },
                    defaultBuilder: (context, date, events) {
                      return DateBody(
                        date: date,
                        color: Colors.black,
                        body: PlanUsersTile(
                          plans: controller.getCalanderListString(
                              date, controller.screenType),
                          userScreenType: controller.screenType,
                        ),
                      );
                    },
                  ),
                  focusedDay: controller.targetMonth,
                  firstDay: DateTime.utc(2020),
                  lastDay: DateTime.utc(2030),
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
    required this.func,
    required this.isChecked,
    required this.buttonIndex,
  }) : super(key: key);
  final Function func;
  final bool isChecked;
  final int buttonIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              filterString[buttonIndex],
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
        RoundCheckBox(
          isChecked: isChecked,
          checkedColor: courseColor[buttonIndex],
          size: 30,
          onTap: (selected) {
            func(selected, buttonIndex);
          },
        ),
      ],
    );
  }
}

List<Color> courseColor = [
  Colors.cyanAccent,
  Colors.greenAccent,
  Colors.yellow,
  Colors.orange,
  Colors.purpleAccent
];

List<String> filterString = [
  "국어사전실",
  "중한사전실",
];

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

class PlanUsersTile extends GetView<PlanAllController> {
  const PlanUsersTile(
      {Key? key, required this.plans, required this.userScreenType})
      : super(key: key);
  final List<String> plans;
  final UserScreenType userScreenType;

  @override
  Widget build(BuildContext context) {
    double fontSize = userScreenType == UserScreenType.pcWeb
        ? 10
        : userScreenType == UserScreenType.tablet
            ? 9
            : 8;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, idx) {
          return Text(
            plans[idx],
            style: TextStyle(color: Colors.black, fontSize: fontSize),
          );
        },
      ),
    );
  }
}
