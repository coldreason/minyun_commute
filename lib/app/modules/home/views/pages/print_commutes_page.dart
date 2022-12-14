import 'package:commute/app/modules/home/controllers/print_commute_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrintCommutes extends GetView<PrintCommuteController> {
  const PrintCommutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<PrintCommuteController>(builder: (_) {
        return Column(
          children: [
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: controller.toLeft,
                      icon: Icon(Icons.chevron_left)),
                  Text("총 근무 단위 : ${controller.totalWorkUnit}"),
                  IconButton(
                      onPressed: controller.toRight,
                      icon: Icon(Icons.chevron_right))
                ],
              ),
            ),
            Expanded(
                child: ListView.separated(
              itemCount: controller.commutesList.length + 1,
              itemBuilder: (context, idx) {
                if (idx == 0) {
                  return SizedBox(
                    height: 20,
                    child: Row(
                      children: [
                        const PrintTile(
                          text: '날짜',
                        ),
                        const PrintTile(
                          text: '출근시간',
                        ),
                        const PrintTile(
                          text: '퇴근시간',
                        ),
                        PrintTile(
                          text: '근무단위',
                        ),
                        const PrintTile(
                          text: '비고',
                        ),
                      ],
                    ),
                  );
                }
                return Row(
                  children: [
                    PrintTile(text: controller.commutesList[idx - 1][0]),
                    PrintTile(text: controller.commutesList[idx - 1][1]),
                    PrintTile(text: controller.commutesList[idx - 1][2]),
                    PrintTile(text: controller.commutesList[idx - 1][3]),
                    PrintTile(text: controller.commutesList[idx - 1][4]),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            )),
          ],
        );
      }),
    );
  }
}

class PrintTile extends StatelessWidget {
  const PrintTile({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
