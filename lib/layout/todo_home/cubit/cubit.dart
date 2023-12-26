import 'package:flutter/material.dart';
import 'package:flutter_application/modules/todo_screens/archived_screen/archived_screen.dart';
import 'package:flutter_application/modules/todo_screens/done_screen/done_screen.dart';
import 'package:flutter_application/layout/todo_home/cubit/states.dart';
import 'package:flutter_application/modules/todo_screens/tasks_screen/tasks_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class todoCubit extends Cubit<todoStates> {
  todoCubit() : super(todoInitialState());
  static todoCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    TasksScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  void changeIndex(int index) {
    currentIndex = index;
    emit(changeBottonNavBarState());
  }

  // Future<String> getname() async {
  //   return 'kaReem Baz ';
  // }
  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void CreateDatabase() {
    openDatabase(
      'todo1.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // time String
        // date String
        // status String

        print('the database is create');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('The Tables is create');
        }).catchError((error) {
          print('Error When Create Tables ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('database is opened');
        getDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(createDatabaseState());
    });
  }

  void insertIntoDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    // print('this is insert');
    await database?.transaction((txn) => txn
            .rawInsert(
          'INSERT INTO tasks(title ,date ,time, status) VALUES("$title","$date","$time","new")',
        )
            .then((value) {
          emit(insertIntoDatabaseState());
          print('${value} insert Completely ');

          getDatabase(database);
        }).catchError((error) {
          print('${error} in here not completely the insesrt');
        }));
  }

  void getDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(getDatabaseLoadingState());
    return database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach(
        (element) {
          if (element['status'] == 'new') {
            newTasks.add(element);
          } else if (element['status'] == 'done') {
            doneTasks.add(element);
          } else {
            archivedTasks.add(element);
          }
        },
      );
      emit(getDatabaseState());
    });
  }

  bool isButtonSheet = false;
  IconData floatingActionIcon = Icons.edit;

  void changeBottonSheet({
    required bool isShow,
    required IconData icon,
  }) {
    isButtonSheet = isShow;
    floatingActionIcon = icon;
    emit(changeBottonSheetState());
  }

  void updateDatabase({
    required String status,
    required int id,
  }) async {
    database?.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDatabase(database);
      emit(updateDatabaseState());
    });
  }

  void deleteTableOfDatabase({required int id}) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDatabase(database);
      emit(deleteDatabaseState());
    });
  }
}





//  sqlite of flutter

// Crete database
// Create Tables
// open database
// insert to database
// get fron database
// update in database
// delete from database

