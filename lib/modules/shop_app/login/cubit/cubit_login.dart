import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/layout/shop_home/login_model.dart';
import 'package:flutter_application/modules/shop_app/login/cubit/states_login.dart';
import 'package:flutter_application/shared/network/end_point/end_point.dart';
import 'package:flutter_application/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class loginCubit extends Cubit<loginStates> {
  loginCubit() : super(loginInitialeState());
  static loginCubit get(context) => BlocProvider.of(context);
  late loginModel loginForData;

//  هنا يتم استقبال من الموديل
  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(loginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginForData = loginModel.formJson(value.data);
      // print(loginForData);

      emit(loginSccessState(loginForData));
    }).catchError((error) {
      print(error.toString());
      emit(logineErorrState(error.toString()));
    });
  }

  IconData suffic = Icons.remove_red_eye_sharp;
  bool ispassWord = true;
  void changePasswordVisility() {
    ispassWord = !ispassWord;
    suffic = ispassWord ? Icons.remove_red_eye_sharp : Icons.visibility_off;
    emit(showPasswordState());
  }
}
