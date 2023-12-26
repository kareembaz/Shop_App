import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/layout/shop_home/login_model.dart';
import 'package:flutter_application/modules/shop_app/login/cubit/states_login.dart';
import 'package:flutter_application/modules/shop_app/registor_screen/register_model.dart';
import 'package:flutter_application/modules/shop_app/registor_screen/registor_cubit/states.dart';
import 'package:flutter_application/shared/network/end_point/end_point.dart';
import 'package:flutter_application/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class registorCubit extends Cubit<registerStates> {
  registorCubit() : super(registorInitialeState());
  static registorCubit get(context) => BlocProvider.of(context);
  late RegisterModel registorData;

//  هنا يتم استقبال من الموديل
  void userregistor({
    required String? email,
    required String? password,
    required String? name,
    required String? phone,
  }) async {
    emit(registorLoadingState());
    DioHelper.postData(
      url: REGISTOR,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    ).then((value) {
      registorData = RegisterModel.formJson(value.data);
      print(registorData.status);

      emit(registorSccessState(registorData));
    }).catchError((error) {
      print(error.toString());
      emit(registoreErorrState(error.toString()));
    });
  }

  IconData suffic = Icons.remove_red_eye_sharp;
  bool ispassWord = true;
  void changePasswordVisility() {
    ispassWord = !ispassWord;
    suffic = ispassWord ? Icons.remove_red_eye_sharp : Icons.visibility_off;
    emit(showRegistorPasswordState());
  }
}
