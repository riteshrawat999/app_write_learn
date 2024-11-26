import 'package:app_write_learn/app/data/repository/auth_repositotory.dart';
import 'package:app_write_learn/app/routes/app_pages.dart';
import 'package:app_write_learn/app/utils/full_screen_dialog_loader.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/custome_snackbar.dart';

class LoginController extends GetxController {
  AuthRepository authRepository;
  LoginController(this.authRepository);
  // make controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isFormValid = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GetStorage _getStorage = GetStorage();

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  void clearTextEditingController() {
    emailController.clear();
    passwordController.clear();
  }

  // email validation
  String? validateEmail(String val) {
    if (!GetUtils.isEmail(val)) {
      return "Provide Valid Email";
    }
    return null;
  }

  // password validation
  String? validatePassword(String val) {
    if (val.isEmpty) {
      return 'Provide Valid Password';
    }
    return null;
  }

  moveToSignUp() {
    Get.toNamed(Routes.signup);
  }

  void validateAndLogin(
      {required String email, required String password}) async {
    isFormValid = formKey.currentState!.validate();
    if (!isFormValid) {
      return;
    } else {
      formKey.currentState!.save();
      try {
        FullScreenDialogLoader.showDialog();
        await authRepository
            .login({'email': email, 'password': password}).then((val) {

          FullScreenDialogLoader.cancelDialog();
          _getStorage.write('userId', val.userId);
          _getStorage.write('sessionId', val.$id);
          CustomSnackBar.showSuccessSnackBar(
              context: Get.context!,
              title: 'Success',
              message: 'Login Success');
          clearTextEditingController();
          Get.offAllNamed(Routes.home);
        }).catchError((error) {
          FullScreenDialogLoader.cancelDialog();
          if (error is AppwriteException) {
            print('Appwrite Error : ${error.response['message']}');
            CustomSnackBar.showErrorSnackBar(
                context: Get.context!, title: 'AppWriteError', message: error.response['message']);
          } else {
            CustomSnackBar.showErrorSnackBar(
                context: Get.context!, title: 'Error', message: 'Something went wrong');
          }
        });
      } catch (e) {
        FullScreenDialogLoader.cancelDialog();
        CustomSnackBar.showSuccessSnackBar(
            context: Get.context,
            title: 'Success',
            message: 'User account created');
      }
    }
  }
}
