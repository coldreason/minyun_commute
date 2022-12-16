import 'package:commute/app/data/models/fb_user_model.dart';
import 'package:commute/app/data/services/auth_type_service.dart';
import 'package:commute/app/modules/login/repositoryies/login_repository.dart';
import 'package:commute/app/data/services/fb_all_user_service.dart';
import 'package:commute/app/data/services/fb_user_service.dart';
import 'package:commute/app/routes/app_pages.dart';
import 'package:commute/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginRepository repository;

  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final FbAllUserService _fbAllUserService = Get.find<FbAllUserService>();
  final AuthTypeService _authTypeService = Get.find<AuthTypeService>();
  final FbUserService _fbUserService = Get.find<FbUserService>();
  bool passwordVisibility = false;
  String ip = "";

  LoginController({required this.repository});

  @override
  void onInit() async {
    super.onInit();

    ip = (await repository.getIp()) ?? "error";
    if (ip != 'error' && ip.substring(0, 7) == '163.152') {
      print('at work');
      _authTypeService.authType = AuthType.user;
    }
    // _authTypeService.authType = AuthType.user;
    if (_fbAllUserService.initialized == false) {
      _fbAllUserService.fbAllUser = await repository.getAllUser();
    }
    signInSilently();
    update();
  }

  void signInSilently() async {
    FbUser? fbUser = repository.getCachedUser();
    if (fbUser != null) {
      _fbUserService.fbUser = fbUser;
      Get.toNamed(Routes.HOME);
    }
  }

  void signIn() async {
    FbUser? fbUser =
        await repository.getUser(emailAddressController.value.text);
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
      _fbUserService.fbUser = fbUser;
      repository.setCachedUser(fbUser);
      Get.toNamed(Routes.HOME);
    }
  }

  void changePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    update();
  }
}
