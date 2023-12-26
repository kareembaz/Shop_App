import 'package:flutter/material.dart';
import 'package:flutter_application/layout/shop_home/cubit/shop_cubit.dart';
import 'package:flutter_application/layout/shop_home/cubit/shop_states.dart';
import 'package:flutter_application/modules/shop_app/login/login.dart';
import 'package:flutter_application/modules/shop_app/search/search_screen.dart';
import 'package:flutter_application/shared/components/components.dart';
import 'package:flutter_application/shared/network/local/cach_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class shopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                onPressed: () {
                  navigatorTO(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          body: cubit.Screens[cubit.currentItems],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentItems,
            onTap: (value) {
              cubit.changeNavBar(value);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home '),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.app_registration_rounded,
                  ),
                  label: 'Categories '),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: 'Favorite '),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Setting '),
            ],
          ),
        );
      },
    );
  }
}
