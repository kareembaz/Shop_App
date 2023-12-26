import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application/modules/todo_screens/archived_screen/archived_screen.dart';
// import 'package:flutter_application/modules/todo_screens/done_screen/done_screen.dart';
import 'package:flutter_application/layout/todo_home/cubit/cubit.dart';
import 'package:flutter_application/layout/todo_home/cubit/states.dart';
// import 'package:flutter_application/modules/todo_screens/tasks_screen/tasks_screen.dart';
import 'package:flutter_application/shared/components/components.dart';
// import 'package:flutter_application/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// import 'package:sqflite/sqflite.dart';

class HomeLyoutScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var fromKey = GlobalKey<FormState>();

  var fromConttrl = TextEditingController();
  var timeConttrl = TextEditingController();
  var dateConttrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => todoCubit()..CreateDatabase(),
      child: BlocConsumer<todoCubit, todoStates>(
        listener: (context, state) {
          if (state is insertIntoDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          todoCubit cubit = todoCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 176, 89, 191),
            ),
            body: ConditionalBuilder(
              condition: state is! getDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              elevation: 20.0,
              onPressed: () {
                if (cubit.isButtonSheet) {
                  if (fromKey.currentState!.validate()) {
                    cubit.insertIntoDatabase(
                      title: fromConttrl.text,
                      date: dateConttrl.text,
                      time: timeConttrl.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet((context) => Container(
                            color: Colors.grey[200],
                            padding: EdgeInsets.all(20.0),
                            child: Form(
                              key: fromKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultFromField(
                                    control: fromConttrl,
                                    inputType: TextInputType.text,
                                    textlabel: 'Task Title',
                                    prefix: Icons.title,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Title must not Empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFromField(
                                    control: timeConttrl,
                                    inputType: TextInputType.datetime,
                                    textlabel: 'Task Time',
                                    prefix: Icons.watch_later,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Time must not Empty';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeConttrl.text =
                                            value!.format(context).toString();
                                        print(value.format(context).toString());
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFromField(
                                    control: dateConttrl,
                                    inputType: TextInputType.datetime,
                                    textlabel: 'Task date',
                                    prefix: Icons.date_range,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'date must not Empty';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2024-01-01'),
                                      ).then((value) {
                                        dateConttrl.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.changeBottonSheet(isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottonSheet(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.floatingActionIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.task_alt,
                    ),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.download_done,
                    ),
                    label: 'DOne',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive_outlined,
                    ),
                    label: 'Archived',
                  ),
                ]),
          );
        },
      ),
    );
  }
}
