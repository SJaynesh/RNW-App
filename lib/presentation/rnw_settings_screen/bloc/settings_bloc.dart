import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rnw_institue/apis/repositorise/auth_repository.dart';
import 'package:rnw_institue/presentation/rnw_settings_screen/bloc/settings_state.dart';
import 'package:rnw_institue/presentation/rnw_settings_screen/model/rnw_version.dart';

part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final AuthRepository authRepository;
  SettingsBloc(super.initialState, this.authRepository) {
    on<VersionEvent>((_onVersionApiCall));
  }

  _onVersionApiCall(VersionEvent event, Emitter<SettingsState> emit) async {
    try {
      VersionModel versionModel = await authRepository.getVersionAPI();
      if (versionModel.data != null) {
        emit(state.copyWith(versionModel: versionModel, versionCode: versionModel.data?.version ?? '0.0'));
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
