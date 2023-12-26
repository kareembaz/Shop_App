import 'package:flutter/material.dart';
import 'package:flutter_application/layout/news_home/ccbit/states.dart';
import 'package:flutter_application/modules/news_screens/business_screen/business_screen.dart';
import 'package:flutter_application/modules/news_screens/science_screen/science_screen.dart';
import 'package:flutter_application/modules/news_screens/setting_screen/sports_screen.dart';
import 'package:flutter_application/modules/news_screens/sports_screen/sports_screen.dart';
import 'package:flutter_application/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class newsCubit extends Cubit<newsStates> {
  newsCubit() : super(newsInitialState());

  static newsCubit get(context) => BlocProvider.of(context);

  int currentItems = 0;
  List<BottomNavigationBarItem> bottonItem = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
  ];

  List<Widget> Screens = [
    businessScreen(),
    sportsScreen(),
    scienceScreen(),
    SettingsScreen(),
  ];
  void changeBottonNavBar(int index) {
    currentItems = index;
    if (index == 1) {
      getsports();
    }
    if (index == 2) {
      getscience();
    }
    emit(newsButtonNavState());
  }

  List<dynamic> business = [];
// https://newsapi.org/ v2/top-headlines? country=eg &category=business &apiKey=857a1e619e2a4b3694049dd8ae14b9fb i
  void getBusiness() {
    emit(newsBusinessLoadingState());

    // if (business.length == 0) {
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'sources': 'bbc-news',
        // 'category': 'business',
        // sources=bbc-news
        'apiKey': '857a1e619e2a4b3694049dd8ae14b9fb',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);

      emit(newsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(newsGetBusinessErorrState(error.toString()));
    });
    // } else {
    //   emit(newsGetBusinessSuccessState());
    // }
  }

  List<dynamic> sports = [];
// https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=857a1e619e2a4b3694049dd8ae14b9fb
  void getsports() {
    emit(newsSoprtsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'sports',
          // sources=bbc-news
          'apiKey': '857a1e619e2a4b3694049dd8ae14b9fb',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(newsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(newsGetSportsErorrState(error.toString()));
      });
    } else {
      emit(newsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];
// https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=857a1e619e2a4b3694049dd8ae14b9fb
  void getscience() {
    emit(newsScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'science',
          // sources=bbc-news
          'apiKey': '857a1e619e2a4b3694049dd8ae14b9fb',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);

        emit(newsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(newsGetScienceErorrState(error.toString()));
      });
    } else {
      emit(newsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
// https://newsapi.org/v2/everything?q=tesla&apiKey=857a1e619e2a4b3694049dd8ae14b9fb
  void getSearch(String value) {
    emit(SearchLoadingState());
    search = [];

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '857a1e619e2a4b3694049dd8ae14b9fb',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      // print(search[0]['title']);

      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErorrState(error.toString()));
    });
  }
}
