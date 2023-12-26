import 'dart:convert';

import 'package:flutter_application/layout/shop_home/search_model.dart';
import 'package:flutter_application/modules/shop_app/search/cubit/search_states.dart';
import 'package:flutter_application/shared/components/constants.dart';
import 'package:flutter_application/shared/network/end_point/end_point.dart';
import 'package:flutter_application/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchsModel? searchModel;
  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(url: SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      searchModel = SearchsModel.fromJson(value.data);
      // print(searchModel!.data!.data?["name"]);
      print(searchModel!.data!.data![1]);

      printFullText(searchModel!.status.toString());
      printFullText(searchModel!.data.toString());

      emit(SearchScuessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErorrState());
    });
  }
}
