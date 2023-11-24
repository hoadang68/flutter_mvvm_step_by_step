import '../data/model/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final List<UserModel> users;
  UserLoaded(this.users);
}

class UserError extends UserState {}