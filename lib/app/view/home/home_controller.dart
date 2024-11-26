import 'dart:ui';

import 'package:app_write_learn/app/data/model/employee_model.dart';
import 'package:app_write_learn/app/data/repository/auth_repositotory.dart';
import 'package:app_write_learn/app/routes/app_pages.dart';
import 'package:app_write_learn/app/utils/custome_snackbar.dart';
import 'package:app_write_learn/app/utils/full_screen_dialog_loader.dart';
import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController with StateMixin<List<EmployeeModel>> {
  AuthRepository authRepository;
  HomeController(this.authRepository);

  final GetStorage _getStorage = GetStorage();

  RxList<EmployeeModel> employeeList = <EmployeeModel>[].obs;


  @override
  void onReady() {
    super.onReady();
    getEmployee();
  }

  logout() async {
    try {
      FullScreenDialogLoader.showDialog();
      authRepository.logout(_getStorage.read('sessionId')).then((value) {
        FullScreenDialogLoader.cancelDialog();
        _getStorage.erase();
        Get.offAllNamed(Routes.login);
      }).catchError((val) {
        FullScreenDialogLoader.cancelDialog();
        if (val is AppwriteException) {
          CustomSnackBar.showErrorSnackBar(
              context: Get.context!,
              title: 'Error',
              message: val.response['message']);
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
  }

  moveToEditEmployee(EmployeeModel employeeModel){
    Get.toNamed(Routes.employee,arguments: employeeModel);
  }

  moveToEmployee() {
    Get.toNamed(Routes.employee);
  }

  void getEmployee() async{
    try{
      change(null,status: RxStatus.loading());
      await authRepository.getEmployees().then((val){
        Map<String,dynamic> data = val.toMap();
        List d = data['documents'].toList();
        employeeList.value = d.map((e) => EmployeeModel.fromMap(e['data'])).toList();
        change(null,status: RxStatus.success());
      }).catchError((error){
        if(error is AppwriteException){
          change(null,status: RxStatus.error(error.response['message']));
        }else{
          change(null,status: RxStatus.error('Something went wrong'));
        }
      });
    }catch(e){
     change(null,status: RxStatus.error('Something went wrong'));

    }
  }




}
