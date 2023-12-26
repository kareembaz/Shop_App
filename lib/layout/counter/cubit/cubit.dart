import 'package:flutter_application/layout/counter/cubit/staes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class counterCubit extends Cubit<counterStates> {
  counterCubit() : super(counterInitialState());
  int count = 1;

  static counterCubit get(context) => BlocProvider.of(context);

  void plus() {
    count++;
    emit(counterPLusState(count));
  }

  void mini() {
    count--;
    emit(counterMiniState(count));
  }
}
