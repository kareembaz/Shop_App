class HomeModel {
  late bool status;
  late HomeDataModel data;

  HomeModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.formJson(json['data']);
  }
}

class HomeDataModel {
  late List<bannerModel> banners = [];
  late List<productsModel> products = [];
  HomeDataModel.formJson(Map<String, dynamic> json) {
    json['banners'].forEach((elemet) {
      banners.add(bannerModel.formJson(elemet));
    });
    json['products'].forEach((elemet) {
      products.add(productsModel.formJson(elemet));
    });
  }
}

class bannerModel {
  late int id;
  late String image;
  bannerModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class productsModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  productsModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
