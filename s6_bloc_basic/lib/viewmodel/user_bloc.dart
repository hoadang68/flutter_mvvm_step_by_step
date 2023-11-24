import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_architecture_a_z/viewmodel/user_event.dart';
import 'package:flutter_mvvm_architecture_a_z/viewmodel/user_state.dart';
import '../service/web_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.webService})
      : super(UserInitial()) {
    on<FetchUser>(fetchUser);
  }

  final WebService webService;

  void fetchUser(FetchUser event, Emitter<UserState> emit) async {
    emit(UserInitial());
    try {
      final items = await webService.getUser();
      emit(UserLoaded(items));
    } catch (_) {
      emit(UserError());
    }
  }
}
