import 'package:flutter/material.dart';
import 'package:flutter_application/layout/todo_home/cubit/cubit.dart';
import 'package:flutter_application/modules/news_screens/web_view/web_view.dart';
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

// Items of the todo app
Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        todoCubit.get(context).deleteTableOfDatabase(id: model['id']);
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Color.fromARGB(255, 158, 73, 173),
              child: Text('${model['time']}',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${model['title']}',
                      style: TextStyle(
                        fontSize: 20.0,
                      )),
                  Text('${model['date']}',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      )),
                ],
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            IconButton(
              onPressed: () {
                todoCubit.get(context).updateDatabase(
                      status: 'done',
                      id: model['id'],
                    );
              },
              icon: Icon(
                size: 30.0,
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                todoCubit.get(context).updateDatabase(
                      status: 'archived',
                      id: model['id'],
                    );
              },
              icon: Icon(
                size: 30.0,
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );

// Items of the API of new by Dio
Widget buildIemsNews(listArticle, context) => InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => webViewScreen(listArticle['url']),
            ));
      },
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                    '${listArticle['urlToImage']}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${listArticle['title']}',
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 4,
                      ),
                    ),
                    Text(
                      '${listArticle['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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
