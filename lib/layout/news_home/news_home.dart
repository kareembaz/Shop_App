import 'package:flutter/material.dart';
import 'package:flutter_application/layout/news_home/appcubit/app_cubit.dart';
import 'package:flutter_application/layout/news_home/ccbit/cubit.dart';
import 'package:flutter_application/layout/news_home/ccbit/states.dart';
import 'package:flutter_application/modules/news_screens/search_screen/search_screen.dart';
import 'package:flutter_application/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class newsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = newsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => searchScreen(),
                      ));
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  appCubit.get(context).changeAppMode();
                },
                icon: Icon(Icons.light_mode_outlined),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentItems,
            items: cubit.bottonItem,
            onTap: (value) {
              cubit.changeBottonNavBar(value);
            },
          ),
          body: cubit.Screens[cubit.currentItems],
        );
      },
    );
  }
}
