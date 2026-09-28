import 'package:equatable/equatable.dart';

import '../model/rnw_version.dart';

class SettingsState extends Equatable {
  final VersionModel? versionModel;
  final String? versionCode;

  const SettingsState({this.versionModel, this.versionCode});

  @override
  List<Object?> get props => [versionModel, versionCode];

  SettingsState copyWith({
    VersionModel? versionModel,
    String? versionCode,
  }) {
    return SettingsState(
      versionModel: versionModel ?? this.versionModel,
      versionCode: versionCode ?? this.versionCode,
    );
  }
}
