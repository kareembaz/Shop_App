import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/layout/todo_home/cubit/cubit.dart';
import 'package:flutter_application/layout/todo_home/cubit/states.dart';
import 'package:flutter_application/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<todoCubit, todoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = todoCubit.get(context).doneTasks;
        return ConditionalBuilder(
          condition: tasks.length > 0,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildTaskItem(tasks[index], context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(start: 20.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
            ),
            itemCount: tasks.length,
          ),
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.menu, color: Colors.grey, size: 150.0),
                Text(
                  'Not tasks yet, Please Add some Tasks ',
                  style: TextStyle(fontSize: 15.0, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
