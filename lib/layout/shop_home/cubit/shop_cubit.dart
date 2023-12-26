import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/layout/shop_home/categories_model.dart';
import 'package:flutter_application/layout/shop_home/cubit/shop_states.dart';
import 'package:flutter_application/layout/shop_home/change_favorites_model.dart';
import 'package:flutter_application/layout/shop_home/favorites_model.dart';
import 'package:flutter_application/layout/shop_home/home_model.dart';
import 'package:flutter_application/layout/shop_home/login_model.dart';
import 'package:flutter_application/layout/shop_home/profile_model.dart';
import 'package:flutter_application/modules/shop_app/cateogries/cateogries_screen.dart';
import 'package:flutter_application/modules/shop_app/favorites/favorites_screen.dart';
import 'package:flutter_application/modules/shop_app/products/product_screen.dart';
import 'package:flutter_application/modules/shop_app/setting/setting_screen.dart';
import 'package:flutter_application/shared/components/constants.dart';
import 'package:flutter_application/shared/network/end_point/end_point.dart';
import 'package:flutter_application/shared/network/remote/dio_helper.dart';
import 'package:flutter_application/shared/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentItems = 0;

  List<Widget> Screens = [
    ProductScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];
  void changeNavBar(int index) {
    currentItems = index;
    emit(chanageBottonNavBarState());
  }

  Map<int, bool> favorites = {};
  HomeModel? homeModel;
  void homeGetData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.formJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites!.addAll({
          element.id: element.inFavorites,
        });
      });
      print(favorites.toString());
      // printFullText(homeModel.toString());
      emit(ShopSucessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CateogriesModel? cateogriesModel;
  void getCateoriesData() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      cateogriesModel = CateogriesModel.formJson(value.data);
      // printFullText(cateogriesModel.toString());
      emit(ShopSucessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    //  هنا يتم تغير لون المفضل لحظيا وبعد كد يتم عمل المفضل في الباك ايند
    favorites[productId] = !favorites[productId]!;
    emit(ShopSellectFavState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.formJson(value.data);
      if (changeFavoritesModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavroitesData();
      }
      print(value.data);
      emit(ShopSucessSellectFavState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  FavroitesModel? favroitesModel;
  void getFavroitesData() {
    emit(ShoploadingGetFavoriteDataState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favroitesModel = FavroitesModel.fromJson(value.data);
      // printFullText(favroitesModel.toString());
      emit(ShopSucessGetFavoriteDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoriteDataState());
    });
  }

  late ProfileModel? userModel;
  void getUserData() {
    emit(ShoploadingGetProfileDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ProfileModel.fromJson(value.data);
      printFullText(userModel!.data!.name);

      emit(ShopSucessGetProfileDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetProfileDataState());
    });
  }

  void UpdateUserData({
    required String? name,
    required String? email,
    required String? phone,
  }) {
    emit(ShoploadingGetUpdateDataState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name!,
        'email': email!,
        'phone': phone!,
      },
    ).then((value) {
      userModel = ProfileModel.fromJson(value.data);
      printFullText(userModel!.data!.name);

      emit(ShopSucessGetUpdateDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUpdateDataState());
    });
  }
}
