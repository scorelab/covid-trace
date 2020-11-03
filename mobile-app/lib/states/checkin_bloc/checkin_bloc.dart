import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/data/repository.dart';
import 'package:slcovid_tracker/models/location.dart';
import 'package:slcovid_tracker/screens/safeentrybeforecheckin/safeentrybeforecheckin_screen.dart';

part 'checkin_event.dart';

part 'checkin_state.dart';

@Injectable()
class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final Repository _repository;

  CheckInBloc(
    this._repository,
  ) : super(Initializing());

  @override
  Stream<CheckInState> mapEventToState(
    CheckInEvent event,
  ) async* {
    print(event);

    if (event is FetchLocationEvent) {
      yield Fetching();
      SafeEntryLocation qRLocation = _parseUrl(event.args);

      if (qRLocation != null) {
        yield (await _repository.getLocation(qRLocation.type, qRLocation.id))
            .fold(
                (l) => FetchFailed(error: l), (r) => FetchSuccess(location: r));
      } else
        yield InvalidQR();
    }
  }

  SafeEntryLocation _parseUrl(args) {
    if (args == null) return null;

    var splitUrl = args.url.split('/');
    print(splitUrl);

    if (splitUrl[3] != 'loc' || splitUrl.length != 6) return null;

    return SafeEntryLocation(splitUrl[4], splitUrl[5]);
  }
}
