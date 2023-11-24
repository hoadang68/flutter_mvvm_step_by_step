// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../bloc/user_bloc.dart' as _i5;
import '../data/repository/repository.dart' as _i4;
import '../data/service/web_service.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.WebService>(() => _i3.WebService());
    gh.factory<_i4.Repository>(() => _i4.Repository(gh<_i3.WebService>()));
    gh.factory<_i5.UserBloc>(
        () => _i5.UserBloc(repository: gh<_i4.Repository>()));
    return this;
  }
}
