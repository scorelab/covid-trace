import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/data/repository.dart';
import 'package:slcovid_tracker/models/user.dart';

part 'upload_event.dart';
part 'upload_state.dart';

@Injectable()
class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final Repository _repository;

  UploadBloc(
    this._repository,
  ) : super(Initializing());

  @override
  Stream<UploadState> mapEventToState(
    UploadEvent event,
  ) async* {
    print(event);

    if (event is GetExposedEvent) {
      yield (await _repository.getExposedLocationsOnce()).fold<UploadState>(
        (l) => NonInfected(),
        (r) {
          // TODO - Update this if we are showing user exposed or not
          return NonInfected();
        },
      );
    }

    if (event is GetCodeEvent) {
      yield Loading();
      User user = (await _repository.getSignedInUser()).getOrElse(() => null);

      yield (await _repository.getInfectedCode(user.id)).fold<UploadState>(
        (l) => NonInfected(),
        (r) {
          if (r != null)
            return GotCode(code: r);
          else
            return NoCode();
        },
      );
    }

    if (event is UploadDataEvent) {
      yield Loading();

      User user = (await _repository.getSignedInUser()).getOrElse(() => null);

      var locations = (await _repository.checkedOutLocations().first);

      yield (await _repository.uploadData(user, locations)).fold<UploadState>(
        (l) => DataUploadFailed(error: l),
        (r) => DataUploadSuccess(),
      );

      yield DataUploadSuccess();
    }
  }
}
