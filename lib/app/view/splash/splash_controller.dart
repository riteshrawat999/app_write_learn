import 'package:app_write_learn/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {

  final GetStorage _getStorage = GetStorage();


  @override
  void onReady() async {
    super.onReady();

      if(_getStorage.read('userId')!=null){
        Get.offAllNamed(Routes.home);
      }else{
        Get.offAllNamed(Routes.login);
      }


  }








}