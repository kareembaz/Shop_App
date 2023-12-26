import 'package:flutter_application/layout/news_home/appcubit/app_states.dart';
import 'package:flutter_application/shared/network/local/cach_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class appCubit extends Cubit<appStates> {
  appCubit() : super(appInitialState());
  static appCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool? chageSaveDark}) {
    if (chageSaveDark != null) {
      isDark = chageSaveDark;
    } else {
      isDark = !isDark;
      CachHelper.putBoolCachDark(key: 'isDark', value: isDark).then((value) {
        emit(chageModeAppState());
      });
    }
  }
}
