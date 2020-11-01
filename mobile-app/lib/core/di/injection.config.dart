// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../states/auth_bloc/auth_bloc.dart';
import '../../data/auth/auth_repository.dart';
import '../../data/auth/auth_repository_impl.dart';
import '../../data/repository.dart';
import '../../data/repository_impl.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<AuthRepository>(() => AuthRepositoryImpl());
  gh.lazySingleton<Repository>(() => RepositoryImpl(get<AuthRepository>()));
  gh.factory<AuthBloc>(() => AuthBloc(get<Repository>()));
  return get;
}
