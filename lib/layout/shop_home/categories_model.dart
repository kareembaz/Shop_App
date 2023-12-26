class CateogriesModel {
  bool? status;
  cateogriesDateModel? data;
  CateogriesModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    data = cateogriesDateModel.formJson(json['data']);
  }
}

class cateogriesDateModel {
  late int currentPage;
  List<DataModel>? data = [];

  cateogriesDateModel.formJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data!.add(DataModel.formJson(element));
    });
  }
}

class DataModel {
  int? id;
  late String name;
  late String image;

  DataModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
