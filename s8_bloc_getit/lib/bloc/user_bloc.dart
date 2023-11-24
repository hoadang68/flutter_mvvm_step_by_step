import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_architecture_a_z/bloc/user_event.dart';
import 'package:flutter_mvvm_architecture_a_z/bloc/user_state.dart';
import 'package:flutter_mvvm_architecture_a_z/data/repository/repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.repository})
      : super(UserInitial()) {
    on<FetchUser>(fetchUser);
  }

  final Repository repository;

  void fetchUser(FetchUser event, Emitter<UserState> emit) async {
    emit(UserInitial());
    try {
      final items = await repository.getListUser();
      emit(UserLoaded(items));
    } catch (_) {
      emit(UserError());
    }
  }
}
