import 'package:app_write_learn/app/data/model/employee_model.dart';
import 'package:app_write_learn/app/data/repository/auth_repositotory.dart';
import 'package:app_write_learn/app/utils/custome_snackbar.dart';
import 'package:app_write_learn/app/utils/full_screen_dialog_loader.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/appwrite_constant.dart';

class EmployeeController extends GetxController {
  AuthRepository authRepository;

  EmployeeController(this.authRepository);

  /// form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // text controller
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  // form validation
  bool isFormValid = false;

  late String imageFileId;

  // Get Storage
  final GetStorage _getStorage = GetStorage();

  var imagePath = ''.obs;
  RxBool isEdit = false.obs;
  late EmployeeModel employeeModel;
  final ImagePicker _picker = ImagePicker();

  void clearTextEditingController () {
    nameController.clear();
    departmentController.clear();
  }

  @override
  void onReady() {
    super.onReady();
    if(Get.arguments != null){
      employeeModel = Get.arguments;
      isEdit.value = true;
      nameController.text = employeeModel.name!;
      departmentController.text = employeeModel.department!;
      imagePath.value = '${AppwriteConstant.endPoint}/storage/buckets/${AppwriteConstant.employeeBucketsId}/files/${employeeModel.image}/view?project=${AppwriteConstant.projectId}';
    }

  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    departmentController.dispose();
  }

  String? validateName(String name) {
    if (name.isEmpty) {
      return "Provider Valid Name";
    }
    return null;
  }

  String? validateDepartment(String department) {
    if (department.isEmpty) {
      return "Provider Valid Department";
    }
    return null;
  }

  void selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path;
    } else {
      CustomSnackBar.showErrorSnackBar(
          context: Get.context!,
          title: 'Error',
          message: 'Image selection cancelled');
    }
  }

  void validateAndSave(
      {required String name, required String department}) async {
    isFormValid = formKey.currentState!.validate();
    if (!isFormValid) {
      return;
    } else {
      formKey.currentState!.save();
      if (imagePath.isNotEmpty) {
        try {
          FullScreenDialogLoader.showDialog();
          await authRepository
              .uploadEmployeeImage(imagePath.value)
              .then((value) async {
            FullScreenDialogLoader.cancelDialog();
            imageFileId = value.$id;
            await authRepository.createEmployee({
              'name': name,
              'department': department,
              'createdBy': _getStorage.read('userId'),
              'image': imageFileId,
              'createdAt': DateTime.now().toIso8601String(),
            }).then((newValue) {
              FullScreenDialogLoader.cancelDialog();
              CustomSnackBar.showSuccessSnackBar(
                  context: Get.context!,
                  title: 'Success',
                  message: 'Data saved');
              clearTextEditingController();
            }).catchError((newError) async {
              FullScreenDialogLoader.cancelDialog();
              if (newError is AppwriteException) {
                CustomSnackBar.showErrorSnackBar(
                    context: Get.context!,
                    title: 'Error',
                    message: newError.response['message']);
              } else {
                CustomSnackBar.showErrorSnackBar(
                    context: Get.context!,
                    title: 'Error',
                    message: 'Something went wrong');
              }
            await authRepository.deleteEmployeeImage(imageFileId);
            });
          }).catchError((error) {
            FullScreenDialogLoader.cancelDialog();
            if (error is AppwriteException) {
              CustomSnackBar.showErrorSnackBar(
                  context: Get.context!,
                  title: 'Error',
                  message: error.response['message']);
            } else {
              CustomSnackBar.showErrorSnackBar(
                  context: Get.context!,
                  title: 'Error',
                  message: 'Something went wrong');
            }
          });
        } catch (e) {
          FullScreenDialogLoader.cancelDialog();
          CustomSnackBar.showErrorSnackBar(
              context: Get.context!,
              title: 'Error',
              message: 'Something went wrong');
        }
      } else {
        FullScreenDialogLoader.cancelDialog();
        CustomSnackBar.showErrorSnackBar(
            context: Get.context!,
            title: 'Error',
            message: 'Please  select image');
      }
    }
  }

  updateEmployee(Map map) async {

  }

}
