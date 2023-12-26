import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/layout/appcubit/app_cubit.dart';
import 'package:flutter_application/layout/appcubit/app_states.dart';
import 'package:flutter_application/layout/bloc_opserver.dart';

import 'package:flutter_application/layout/shop_home/cubit/shop_cubit.dart';
import 'package:flutter_application/layout/shop_home/shop_layout.dart';
import 'package:flutter_application/modules/shop_app/login/login.dart';
import 'package:flutter_application/modules/shop_app/on_boarding/on_boarding.dart';
import 'package:flutter_application/shared/components/constants.dart';
import 'package:flutter_application/shared/network/local/cach_helper.dart';
import 'package:flutter_application/shared/network/remote/dio_helper.dart';
import 'package:flutter_application/shared/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:flutter_application/modules/login/login_screen.dart';
// import 'package:flutter_application/modules/user/user_screen.dart';

void main() async {
  //   بيتاكد ان كل ال  حاجه خلصصت قبل ما يرن الابليكشن
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.init();
  bool isDark = CachHelper.getData(key: 'isDark');

  Widget widget;

  bool onBoarding = CachHelper.getData(key: 'onBoarding');
  token = CachHelper.getData(key: 'token');

  // print(onBoarding);
  print(token);
  if (onBoarding != null) {
    if (token != null)
      widget = shopLayout();
    else
      widget = shopLogin();
  } else {
    widget = OnBoarding();
  }

  Bloc.observer = MyBlocObserver();

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({required this.isDark, required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => appCubit()..changeAppMode(chageSaveDark: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..homeGetData()
            ..getCateoriesData()
            ..getFavroitesData()
            ..getUserData(),
        )
      ],
      child: BlocConsumer<appCubit, appStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'news app',
            theme: LightTheme,
            darkTheme: DartTheme,
            themeMode:
                appCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: startWidget,
            ),
          );
        },
      ),
    );
  }
}
