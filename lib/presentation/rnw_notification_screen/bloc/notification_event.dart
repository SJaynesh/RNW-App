part of 'notification_bloc.dart';

class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationListAPIEvent extends NotificationEvent {
  @override
  List<Object> get props => [];
}

class GetNotificationMarkAsReadEvent extends NotificationEvent {
  const GetNotificationMarkAsReadEvent({required this.notificationID});
  final int notificationID;

  @override
  List<Object> get props => [notificationID];
}
