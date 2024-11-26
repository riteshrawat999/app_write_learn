import 'package:app_write_learn/app/data/provider/appwrite_provider.dart';
import 'package:app_write_learn/app/data/repository/auth_repositotory.dart';
import 'package:app_write_learn/app/view/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(AuthRepository(AppWriteProvider())));
  }
}