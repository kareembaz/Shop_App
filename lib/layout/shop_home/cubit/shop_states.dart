import 'package:flutter_application/layout/shop_home/change_favorites_model.dart';
import 'package:flutter_application/layout/shop_home/login_model.dart';
import 'package:flutter_application/layout/shop_home/profile_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class chanageBottonNavBarState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSucessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSucessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {}

class ShopSellectFavState extends ShopStates {}

class ShopSucessSellectFavState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSucessSellectFavState(this.model);
}

class ShopErrorSellectFavState extends ShopStates {}

class ShoploadingGetFavoriteDataState extends ShopStates {}

class ShopSucessGetFavoriteDataState extends ShopStates {}

class ShopErrorGetFavoriteDataState extends ShopStates {}

class ShoploadingGetProfileDataState extends ShopStates {}

class ShopSucessGetProfileDataState extends ShopStates {
  final ProfileModel userModel;

  ShopSucessGetProfileDataState(this.userModel);
}

class ShopErrorGetProfileDataState extends ShopStates {}

class ShoploadingGetUpdateDataState extends ShopStates {}

class ShopSucessGetUpdateDataState extends ShopStates {
  final ProfileModel userModel;

  ShopSucessGetUpdateDataState(this.userModel);
}

class ShopErrorGetUpdateDataState extends ShopStates {}
