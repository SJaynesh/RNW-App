part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityEvent extends Equatable {}

class ConnectivityChecked extends ConnectivityEvent {
  @override
  List<Object?> get props => [];
}
