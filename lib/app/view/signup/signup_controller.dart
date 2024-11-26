import 'package:app_write_learn/app/data/repository/auth_repositotory.dart';
import 'package:app_write_learn/app/routes/app_pages.dart';
import 'package:app_write_learn/app/utils/custome_snackbar.dart';
import 'package:app_write_learn/app/utils/full_screen_dialog_loader.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  AuthRepository authRepository;
  SignUpController(this.authRepository);
  // Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController namedController = TextEditingController();

  // form validation
  bool isFormValid = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    namedController.dispose();
  }

  void clearTextEditingController() {
    emailController.clear();
    passwordController.clear();
    namedController.clear();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide Valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Provide Valid Password";
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Provide Valid Name";
    }
    return null;
  }

  void validateAndSignUp(
      {required String email,
      required String password,
      required String name}) async {
    isFormValid = formKey.currentState!.validate();
    if (!isFormValid) {
      return;
    } else {
      formKey.currentState!.save();
      try {
        FullScreenDialogLoader.showDialog();
        await authRepository.signup({
          'userId': ID.unique(),
          'name': name,
          'email': email,
          'password': password,
        }).then((val) {
          FullScreenDialogLoader.cancelDialog();
          CustomSnackBar.showSuccessSnackBar(
              context: Get.context,
              title: 'Success',
              message: 'User account created');
          clearTextEditingController();
          Get.offAllNamed(Routes.login);
        }).catchError((error) {
          FullScreenDialogLoader.cancelDialog();
          if (error is AppwriteException) {
            CustomSnackBar.showErrorSnackBar(
                context: Get.context,
                title: 'Error',
                message: error.response['message']);
          } else {
            CustomSnackBar.showErrorSnackBar(
                context: Get.context,
                title: 'Error',
                message: 'Something Went Wrong');
          }
        });
      } catch (e) {
        FullScreenDialogLoader.cancelDialog();
        CustomSnackBar.showErrorSnackBar(
            context: Get.context,
            title: 'Error',
            message: 'Something Went Wrong');
      }
    }
  }
}
