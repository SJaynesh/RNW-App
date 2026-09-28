import 'package:rnw_institue/utils/app_export.dart';

import 'locale_event.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleState(locale: const Locale('en'))) {
    on<SetLocale>(_onSetLocale);
  }

  void _onSetLocale(SetLocale event, Emitter<LocaleState> emit) {
    emit(state.copyWith(locale: event.locale));
  }
}
