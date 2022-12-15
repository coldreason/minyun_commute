import 'package:commute/app/data/services/fb_all_user_service.dart';
import 'package:commute/app/data/services/fb_commute_service.dart';
import 'package:commute/app/data/services/fb_my_plan_service.dart';
import 'package:commute/app/data/services/fb_user_service.dart';
import 'package:commute/app/data/services/screen_type_service.dart';
import 'package:commute/app/flutter_flow/flutter_flow_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  await dependencies();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "민족문화 연구원 출퇴근",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

Future<void> dependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterFlowTheme.initialize();
  Get.put(FbUserService());
  Get.put(FbAllUserService());
  Get.put(FbCommuteService());
  Get.put(FbMyPlanService());
  Get.put(ScreenTypeService());
  await GetStorage.init();
}
