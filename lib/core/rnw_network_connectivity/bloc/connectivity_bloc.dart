import 'package:rnw_institue/utils/app_export.dart';
part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final InternetConnectionChecker _connectionChecker;
  StreamSubscription? _connectionSubscription;

  ConnectivityBloc(this._connectionChecker) : super(const ConnectivityState()) {
    on<ConnectivityChecked>(_onConnectivityChecked);

    _connectionSubscription =
        _connectionChecker.onStatusChange.listen((status) {
      final isConnected = status != InternetConnectionStatus.disconnected;
      Logger.lOG("CONECTIVITY STATUS CHANGED: $isConnected"); // Debug log
      add(ConnectivityChecked());
    });
  }

  Future<void> _onConnectivityChecked(
    ConnectivityChecked event,
    Emitter<ConnectivityState> emit,
  ) async {
    final isConnected = await _connectionChecker.hasConnection;
    Logger.lOG("CONECTIVITY STATUS: $isConnected"); // Debug log
    emit(state.copyWith(isConnected: isConnected));
  }

  @override
  Future<void> close() {
    _connectionSubscription?.cancel();
    return super.close();
  }
}
