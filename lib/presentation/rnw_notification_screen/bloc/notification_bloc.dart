import 'dart:developer';
import 'package:rnw_institue/apis/repositorise/notification_repository.dart';
import 'package:rnw_institue/presentation/rnw_notification_screen/model/notification_list_model.dart';
import 'package:rnw_institue/utils/app_export.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationModuleRepository notificationModuleRepository;

  NotificationBloc(super.initialState, this.notificationModuleRepository) {
    on<GetNotificationListAPIEvent>(_onGetNotificationListAPICall);
    on<GetNotificationMarkAsReadEvent>(_onNotificationMarkAsReadAPICall);
  }

  _onGetNotificationListAPICall(GetNotificationListAPIEvent event, Emitter<NotificationState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      NotificationModel notificationModel = await notificationModuleRepository.getNotificationListAPI();
      if (notificationModel.data != null) {
        emit(state.copyWith(isLoading: false, notificationModel: notificationModel));
        final unreadCount = notificationModel.data?.where((notification) => notification.isRead == false).length ?? 0;

        // Update ValueNotifier
        unreadCountNotifier.value = unreadCount;
      } else {
        emit(state.copyWith(isLoading: false));
        log("Error ${notificationModel.message}");
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Logger.lOG('====$e');
    }
  }

  _onNotificationMarkAsReadAPICall(GetNotificationMarkAsReadEvent event, Emitter<NotificationState> emit) async {
    try {
      NotificationModel notificationModel = await notificationModuleRepository.getMarkISReadAPI(notificationID: event.notificationID);

      if (notificationModel.message == 'Read notifications successfully') {
        // Optimistically update the local state
        final updatedNotifications = state.notificationModel?.data?.map((notification) {
          if (notification.id == event.notificationID) {
            return notification.copyWith(isRead: true);
          }
          return notification;
        }).toList();

        // Calculate new unread count
        final newUnreadCount = updatedNotifications?.where((notification) => notification.isRead == false).length ?? 0;

        // Update ValueNotifier
        unreadCountNotifier.value = newUnreadCount;

        emit(state.copyWith(notificationModel: state.notificationModel?.copyWith(data: updatedNotifications)));
      } else {
        log("Error ${notificationModel.message}");
      }
    } catch (e) {
      Logger.lOG('====$e');
    }
  }
}
