import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/repositories/login_repository.dart';
import 'package:commute/app/data/services/fb_all_user_service.dart';
import 'package:commute/app/data/services/fb_user_service.dart';
import 'package:commute/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginRepository loginRepository;

  late TextEditingController emailAddressController;
  late TextEditingController passwordTextController;
  late bool passwordVisibility;

  LoginController({required this.loginRepository});

  @override
  void onInit() async{
    super.onInit();
    emailAddressController = TextEditingController();
    passwordTextController = TextEditingController();
    passwordVisibility = false;

    Get.find<FbAllUserService>().fbAllUser = await loginRepository.getAllUser();
    //for testing
    FbUser? fbUser = await loginRepository.getUser('dreason');
    Get.find<FbUserService>().fbUser = fbUser!;
    Get.toNamed(Routes.HOME);

  }

  void signIn()async{
    FbUser? fbUser = await loginRepository.getUser(emailAddressController.value.text);
    if(fbUser==null){
      Get.dialog(
        AlertDialog(
          title: Text('존재하지 않는 아이디입니다.'),
        ),
      );
    }
    else if(passwordTextController.value.text != fbUser.password){
      Get.dialog(
        AlertDialog(
          title: Text('비밀번호가 일치하지 않습니다.'),
        ),
      );
    }
    else{
      emailAddressController.clear();
      passwordTextController.clear();
      Get.find<FbUserService>().fbUser = fbUser;
      Get.toNamed(Routes.HOME);
    }
  }

  void changePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
