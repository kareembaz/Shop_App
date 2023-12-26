import 'package:flutter/material.dart';
import 'package:flutter_application/layout/counter/cubit/cubit.dart';
import 'package:flutter_application/layout/counter/cubit/staes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => counterCubit(),
      child: BlocConsumer<counterCubit, counterStates>(
        listener: (BuildContext context, counterStates state) {
          if (state is counterPLusState)
            print('PLus State & ${counterCubit.get(context).count}');
          if (state is counterMiniState)
            print('Mini State & ${counterCubit.get(context).count}');
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Counter',
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      counterCubit.get(context).mini();
                    },
                    child: Text(
                      'Min',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Text(
                      '${counterCubit.get(context).count}',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      counterCubit.get(context).plus();
                    },
                    child: Text(
                      'Max',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
