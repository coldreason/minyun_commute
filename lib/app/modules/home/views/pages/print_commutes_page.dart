import 'package:commute/app/data/models/fb_commute_model.dart';
import 'package:commute/utils/helpers/masks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class PrintCommutes extends GetView<HomeController> {
  const PrintCommutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<HomeController>(builder: (_) {
        return Container(
          child: ListView.separated(
            itemCount: DateTime(controller.targetMonth.year, controller.targetMonth.month + 1, 0).day+1,
            itemBuilder: (context, idx) {
              if(idx==0)return SizedBox(
                height: 20,
                child: Row(
                  children: [
                    PrintTile(text: '날짜',),
                    PrintTile(text: '출근시간',),
                    PrintTile(text: '퇴근시간',),
                    PrintTile(text: '근무단위',),
                    PrintTile(text: '비고',),
                  ],
                ),
              );
              FbCommute? dataPath = controller.commutes[controller.getTargetMonthString()+dateStringFormatter.format(idx)];
              bool dataExist = dataPath!=null;
              bool goExist = false;
              bool endExist = false;
              if(dataExist){
                if(dataPath.comeAt!=null)goExist = true;
                if(dataPath.endAt!=null)endExist = true;
              }
              return Row(
                children: [
                  PrintTile(text: "${controller.getTargetMonthString()}${dateStringFormatter.format(idx)}"),
                  PrintTile(text: goExist?"${dateStringFormatter.format(dataPath!.comeAt!.toDate().hour)}:${dateStringFormatter.format(dataPath!.comeAt!.toDate().minute)}":""),
                  PrintTile(text: endExist?"${dateStringFormatter.format(dataPath!.endAt!.toDate().hour)}:${dateStringFormatter.format(dataPath!.endAt!.toDate().minute)}":""),
                  PrintTile(text: (goExist&&endExist)?controller.calcWorkUnit(dataPath!):""),
                  PrintTile(text: dataExist?dataPath.comment??"":""),
                ],
              );
            }, separatorBuilder: (BuildContext context, int index) => const Divider(),
          )
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
        child: Text(text,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
