import 'package:flutter_mvvm_architecture_a_z/bloc/user_bloc.dart';
import 'package:flutter_mvvm_architecture_a_z/data/repository/repository.dart';
import 'package:flutter_mvvm_architecture_a_z/data/service/web_service.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjection() async {
  getIt.registerLazySingleton<WebService>(() => WebService());
  getIt.registerLazySingleton<Repository>(() => Repository(getIt<WebService>()));
  getIt.registerFactory<UserBloc>(() => UserBloc(repository: getIt<Repository>()));
}