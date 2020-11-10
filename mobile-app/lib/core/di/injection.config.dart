// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../states/auth_bloc/auth_bloc.dart';
import '../../states/checkin_bloc/checkin_bloc.dart';
import '../../states/exposed_bloc/exposed_bloc.dart';
import '../../data/firebase/firebase_repository.dart';
import '../../data/firebase/firebase_repository_impl.dart';
import '../../data/local/dao/location_dto.dart';
import '../../data/local/database/database.dart';
import '../../data/repository.dart';
import '../../data/repository_impl.dart';
import '../../data/local/user/user_repository.dart';
import '../../data/local/user/user_repository_impl.dart';
import '../../states/verify_bloc/verify_bloc.dart';
import '../../data/verify/verify_repository.dart';
import '../../data/verify/verify_repository_impl.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final locationModule = _$LocationModule();
  gh.factory<FirebaseRepository>(() => FirebaseRepositoryImpl());
  final locationDao = await locationModule.prefs;
  gh.factory<LocationDao>(() => locationDao);
  gh.factory<UserRepository>(() => UserRepositoryImpl());
  gh.factory<VerifyRepository>(() => VerifyRepositoryImpl());
  gh.lazySingleton<Repository>(() => RepositoryImpl(
        get<VerifyRepository>(),
        get<FirebaseRepository>(),
        get<UserRepository>(),
        get<LocationDao>(),
      ));
  gh.factory<VerifyBloc>(() => VerifyBloc(get<Repository>()));
  gh.factory<AuthBloc>(() => AuthBloc(get<Repository>()));
  gh.factory<CheckInBloc>(() => CheckInBloc(get<Repository>()));
  gh.factory<ExposedBloc>(() => ExposedBloc(get<Repository>()));
  return get;
}

class _$LocationModule extends LocationModule {}
