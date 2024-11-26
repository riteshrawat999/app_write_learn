
part of 'app_pages.dart';

abstract class Routes{

  Routes._();
  static const splash= _Path.splash;
  static const login = _Path.login;
  static const home = _Path.home;
  static const signup = _Path.signup;
  static const employee = _Path.employee;

}

abstract class _Path {
  _Path._();
  static const splash ='/splash';
  static const login = '/login';
  static const home = '/home';
  static const signup = '/signup';
  static const employee = '/employee';

}