import 'package:app_write_learn/app/view/employee/employee_view.dart';
import 'package:app_write_learn/app/view/employee/empolyee_binding.dart';
import 'package:app_write_learn/app/view/home/home_binding.dart';
import 'package:app_write_learn/app/view/home/home_view.dart';
import 'package:app_write_learn/app/view/login/login_view.dart';
import 'package:app_write_learn/app/view/login/loing_binding.dart';
import 'package:app_write_learn/app/view/signup/signup_binding.dart';
import 'package:app_write_learn/app/view/signup/signup_view.dart';
import 'package:app_write_learn/app/view/splash/splash_binding.dart';
import 'package:app_write_learn/app/view/splash/splash_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class  AppPages {

  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(name: Routes.splash, page: ()=> const SplashView(),binding: SplashBinding()),
    GetPage(name: _Path.login, page: ()=>  LoginView(),binding: LoginBinding()),
    GetPage(name: _Path.signup, page: ()=>  SignupView(),binding: SignUpBinding()),
    GetPage(name: _Path.home, page: ()=>  HomeView(),binding: HomeBinding()),
    GetPage(name: _Path.employee, page: ()=>  EmployeeView(),binding: EmployeeBinding()),
  ];


}