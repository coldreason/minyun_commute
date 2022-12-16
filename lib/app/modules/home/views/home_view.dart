import 'package:commute/app/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'pages/commute_check_page.dart';
import 'pages/plan_all_page.dart';
import 'pages/plan_commute_page.dart';
import 'pages/print_commutes_page.dart';

class HomeView extends GetView<HomeController> {

  List<Widget> _tabs = [Tab(
      child: Column(children: <Widget>[
        Icon(Icons.pending_actions),
        Text("출퇴근 관리")
      ])),
    Tab(icon: Icon(Icons.memory), text: "근무계획"),
    Tab(icon: Icon(Icons.library_books), text: "근무표"),
    Tab(icon: Icon(Icons.book_outlined), text: "근무내역")];

  List<Widget> _tabPages = [
    CommuteCheckPage(),
    PlanCommutePage(),
    PlanAllPage(),
    PrintCommutes()
  ];
  @override
  Widget build(BuildContext context) {
    controller.setUserScreenSize(MediaQuery.of(context).size.width.toInt());
    print(controller.offset);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: controller.logout,
        ),
        title: Text('${controller.localUser.name}님 안녕하세요',
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
            for(int i=0;i<controller.tabController.length;i++)_tabs[controller.offset+i]
          ],
        ),
      ),
      body:
      TabBarView(
        controller: controller.tabController,
        children: <Widget>[
          for(int i=0;i<controller.tabController.length;i++)_tabPages[controller.offset+i]
        ],
      ),
    );
  }
}
