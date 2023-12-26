import 'package:flutter/material.dart';

import 'package:flutter_application/shared/themes.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,
  Color color = const Color.fromARGB(255, 127, 69, 137),
  bool isUppercase = true,
  double radis = 0.0,
  required String text,
  required Function function,
}) =>
    Container(
        width: width,
        height: 40.0,
        child: MaterialButton(
          onPressed: () {
            function();
          },
          child: Text(
            isUppercase ? text.toUpperCase() : text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: defoultColor,
        ));

Widget defaultFromField({
  required TextEditingController control,
  required TextInputType inputType,
  required String textlabel,
  required IconData prefix,
  Function(dynamic value)? onFieldSubmitted,
  Function(dynamic value)? onChanged,
  required String? Function(dynamic value) validator,
  IconData? suffix,
  bool showPassword = false,
  Function? suffixPressed,
  Function()? ispassWord,
  Function()? onTap,
  bool showKeyborad = true,
}) =>
    TextFormField(
      keyboardType: inputType,
      controller: control,
      obscureText: showPassword,

      ///onFieldSubmitted --> print String when ypu end the text
      // onFieldSubmitted: (value) => print(value),
      onFieldSubmitted: onFieldSubmitted,

      // /// onChanged --> print String  first on first
      // onChanged: (value) => print(value),
      onChanged: onChanged,
      validator: validator,
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return 'email must not be empty';
      //   }
      //   return null;
      // },

      //  ontap فتح الساعه لكي تختار منها الساعه بدل ما تكتب الوقت بايدكوهذه مسوله من ال
      onTap: onTap,
      enabled: showKeyborad,
      decoration: InputDecoration(
        //hintText:'Email  Address',
        labelText: textlabel,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: ispassWord,
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Future navigatorTO(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));
//  عندما تنتقل للصفحه هذه يتم محو كل الفات  ولا يمكن العوده منها
Future navigatorTOAndEnd(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (Route<dynamic> route) => false,
    );

//   enum وبعد كدا بنحدد اللون عن طريق  toastهنا بنعمل
void shoowtoast({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorToastStates(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCEESS, ERROR, WARNING }

Color ColorToastStates(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCEESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}
