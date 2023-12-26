import 'package:flutter_application/shared/components/components.dart';
import 'package:flutter_application/shared/network/local/cach_helper.dart';

import '../../modules/shop_app/login/login.dart';

void Signout(context) {
  CachHelper.removeData(key: 'token');
  navigatorTOAndEnd(context, shopLogin());
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = ' ';
