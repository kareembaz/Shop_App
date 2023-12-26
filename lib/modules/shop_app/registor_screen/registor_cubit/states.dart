import 'package:flutter_application/layout/shop_home/login_model.dart';
import 'package:flutter_application/modules/shop_app/registor_screen/register_model.dart';

abstract class registerStates {}

class registorInitialeState extends registerStates {}

class registorLoadingState extends registerStates {}

class registorSccessState extends registerStates {
  final RegisterModel registorForTheModel;

  registorSccessState(this.registorForTheModel);
}

class registoreErorrState extends registerStates {
  final String error;

  registoreErorrState(this.error);
}

class showRegistorPasswordState extends registerStates {}
