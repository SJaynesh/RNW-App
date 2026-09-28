import 'package:rnw_institue/utils/app_export.dart';

class LocaleState {
  final Locale locale;

  LocaleState({required this.locale});

  LocaleState copyWith({Locale? locale}) {
    return LocaleState(
      locale: locale ?? this.locale,
    );
  }
}
