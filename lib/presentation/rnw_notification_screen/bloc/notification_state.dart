part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final NotificationModel? notificationModel;
  final bool isLoading;
  final int unreadCount;

  const NotificationState({
    this.notificationModel,
    this.isLoading = false,
    this.unreadCount = 0,
  });

  NotificationState copyWith({
    NotificationModel? notificationModel,
    bool? isLoading,
    int? unreadCount,
  }) {
    return NotificationState(
      notificationModel: notificationModel ?? this.notificationModel,
      isLoading: isLoading ?? this.isLoading,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [notificationModel, isLoading, unreadCount];
}

final class NotificationInitial extends NotificationState {}
