part of 'rnw_bottombar_bloc.dart';

@immutable
abstract class RnwBottombarEvent extends Equatable {}

class MainHomeInitialEvent extends RnwBottombarEvent {
  @override
  List<Object?> get props => [];
}

class CategoryEvent extends RnwBottombarEvent {
  @override
  List<Object?> get props => [];
}

class CommunityEvent extends RnwBottombarEvent {
  @override
  List<Object?> get props => [];
}

class UserProfilesEvent extends RnwBottombarEvent {
  @override
  List<Object?> get props => [];
}

class BackToInitial extends RnwBottombarEvent {
  @override
  List<Object?> get props => [];
}

class CreateUserDeviceTokenApiEvent extends RnwBottombarEvent {
  final String phoneNumber;
  final String oneSignalID;

  CreateUserDeviceTokenApiEvent({required this.phoneNumber, required this.oneSignalID});

  @override
  List<Object?> get props => [phoneNumber, oneSignalID];
}
