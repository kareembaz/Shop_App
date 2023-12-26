import 'package:flutter_application/layout/counter/cubit/cubit.dart';

abstract class counterStates {}

class counterInitialState extends counterStates {}

class counterPLusState extends counterStates {
  final int counter;
  counterPLusState(this.counter);
}

class counterMiniState extends counterStates {
  final int counter;
  counterMiniState(this.counter);
}
