import 'package:app_write_learn/app/data/provider/appwrite_provider.dart';
import 'package:app_write_learn/app/data/repository/auth_repositotory.dart';
import 'package:app_write_learn/app/view/employee/employee_controller.dart';
import 'package:get/get.dart';

class EmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> EmployeeController(AuthRepository(AppWriteProvider())));
  }
}