// هنا الموديل الذي نستقبل فيه الداتا الجايه من الداتا بيز
class RegisterModel {
  late bool status;
  late String message;
  late userData? data;

  RegisterModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // هنا يوجد مشكله وايرور لان عندما يتم تسجيل الدخول صحيح يرجع الداتا كامله اما عندما لا يتم تسجيل دخول صحيح  يحدث مشكله ان مينفعشي نرجع null
    data = json['data'] != null ? userData.formJson(json['data']) : null;
  }
}

class userData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  // userData(
  //   this.id,
  //   this.name,
  //   this.email,
  //   this.phone,
  //   this.image,
  //   this.points,
  //   this.credit,
  //   this.token,
  // );
  userData.formJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
