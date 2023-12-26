import 'package:flutter_application/layout/shop_home/login_model.dart';

abstract class loginStates {}

class loginInitialeState extends loginStates {}

class loginLoadingState extends loginStates {}

class loginSccessState extends loginStates {
  final loginModel loginForTheModel;

  loginSccessState(this.loginForTheModel);
}

class logineErorrState extends loginStates {
  final String error;

  logineErorrState(this.error);
}

class showPasswordState extends loginStates {}
