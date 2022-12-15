import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/modules/login/repositoryies/login_repository.dart';
import 'package:commute/app/data/services/fb_all_user_service.dart';
import 'package:commute/app/data/services/fb_user_service.dart';
import 'package:commute/app/routes/app_pages.dart';
import 'package:commute/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final LoginRepository loginRepository;

  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  bool passwordVisibility = false;
  final box = GetStorage();
  String ip = "";

  LoginController({required this.loginRepository});

  @override
  void onInit() async {
    super.onInit();

    ip = (await loginRepository.getIp()) ?? "error";
    if (Get.find<FbAllUserService>().initialized == false) {
      Get.find<FbAllUserService>().fbAllUser =
          await loginRepository.getAllUser();
    }
    signInSilently();
    update();
  }

  void signInSilently() async {
    Map<String,dynamic>? userMap = box.read(FirebaseConstants.user);
    if (userMap != null) {
      Get.find<FbUserService>().fbUser = FbUser.fromJson(userMap);
      Get.toNamed(Routes.HOME);
    }
  }

  void signIn() async {
    FbUser? fbUser =
        await loginRepository.getUser(emailAddressController.value.text);
    if (fbUser == null) {
      Get.dialog(
        AlertDialog(
          title: Text('존재하지 않는 아이디입니다.'),
        ),
      );
    } else if (passwordTextController.value.text != fbUser.password) {
      Get.dialog(
        AlertDialog(
          title: Text('비밀번호가 일치하지 않습니다.'),
        ),
      );
    } else {
      emailAddressController.clear();
      passwordTextController.clear();
      Get.find<FbUserService>().fbUser = fbUser;
      box.write(FirebaseConstants.user, fbUser);
      Get.toNamed(Routes.HOME);
    }
  }

  void changePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    update();
  }
}
