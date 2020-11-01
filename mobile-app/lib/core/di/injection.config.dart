// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/data/firebase/firebase_repository.dart';
import 'package:slcovid_tracker/data/firebase/firebase_repository_impl.dart';
import 'package:slcovid_tracker/data/verify/verify_repository.dart';
import 'package:slcovid_tracker/data/verify/verify_repository_impl.dart';
import 'package:slcovid_tracker/states/verify_bloc/verify_bloc.dart';

import '../../states/auth_bloc/auth_bloc.dart';
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
  gh.factory<VerifyRepository>(() => VerifyRepositoryImpl());
  gh.factory<FirebaseRepository>(() => FirebaseRepositoryImpl());
  gh.lazySingleton<Repository>(
      () => RepositoryImpl(get<VerifyRepository>(), get<FirebaseRepository>()));
  gh.factory<AuthBloc>(() => AuthBloc(get<Repository>()));
  gh.factory<VerifyBloc>(() => VerifyBloc(get<Repository>()));
  return get;
}
