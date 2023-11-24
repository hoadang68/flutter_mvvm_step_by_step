import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_architecture_a_z/service/web_service.dart';
import 'package:flutter_mvvm_architecture_a_z/viewmodel/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.webService}) : super(UserInitial()){fetchUser();}

  final WebService webService;

  void fetchUser() async {
    emit(UserInitial());
    try {
      final items = await webService.getUser();
      emit(UserLoaded(items));
    } catch (_) {
      emit(UserError());
    }
  }
}