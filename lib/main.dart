import 'package:commute/app/data/services/fb_all_user_service.dart';
import 'package:commute/app/data/services/fb_commute_service.dart';
import 'package:commute/app/data/services/fb_user_service.dart';
import 'package:commute/app/flutter_flow/flutter_flow_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterFlowTheme.initialize();
  Get.put(FbUserService());
  Get.put(FbAllUserService());
  Get.put(FbCommuteService());

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "민족문화 연구원 출퇴근2",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
