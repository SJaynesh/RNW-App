part of 'connectivity_bloc.dart';

class ConnectivityState extends Equatable {
  final bool isConnected;

  const ConnectivityState({this.isConnected = true});

  ConnectivityState copyWith({bool? isConnected}) {
    return ConnectivityState(isConnected: isConnected ?? this.isConnected);
  }

  @override
  List<Object?> get props => [isConnected];
}
