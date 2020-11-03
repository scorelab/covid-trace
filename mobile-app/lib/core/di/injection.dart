import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/core/di/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<GetIt> configureDependencies() => $initGetIt(getIt);
