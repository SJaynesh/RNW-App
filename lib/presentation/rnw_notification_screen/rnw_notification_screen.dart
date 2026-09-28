import 'package:intl/intl.dart';
import 'package:rnw_institue/apis/repositorise/notification_repository.dart';
import 'package:rnw_institue/presentation/rnw_notification_screen/bloc/notification_bloc.dart';
import 'package:rnw_institue/presentation/rnw_notification_screen/widget/empty_notification_list.dart';
import 'package:rnw_institue/presentation/student_info_screen/model/student_details_model.dart';
import 'package:rnw_institue/utils/app_export.dart';

class RNWNotificationsList extends StatefulWidget {
  const RNWNotificationsList({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
        create: (context) => NotificationBloc(const NotificationState(), NotificationModuleRepository(apiClient: ApiClient()))..add(GetNotificationListAPIEvent()),
        child: const RNWNotificationsList());
  }

  @override
  State<RNWNotificationsList> createState() => _RNWNotificationsListState();
}

class _RNWNotificationsListState extends State<RNWNotificationsList> {
  int? expandedId;

  String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RNWAppBar(
            title: Text(Lang.current.lbl_notifications),
            leadingWidth: 35.w,
            centerTitle: true,
            leading: IconButton(
                style: const ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.transparent)),
                onPressed: () => NavigatorService.goBack(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.whitecolor))),
        body: BlocBuilder<NotificationBloc, NotificationState>(builder: (context, state) {
          if (state.isLoading) {
            return const AttandanceShimmer();
          } else if (state.notificationModel == null) {
            return const Center(child: RnwExceptionScreen());
          }

          return state.notificationModel?.data?.isEmpty ?? true
              ? const EmptyNotificationState()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.notificationModel?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final notification = state.notificationModel?.data?[index];
                    final isExpanded = expandedId == notification?.id;

                    return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                expandedId = isExpanded ? null : notification.id;
                              });

                              // Mark as read ONLY if it's currently unread
                              if (notification.isRead == false) {
                                context.read<NotificationBloc>().add(GetNotificationMarkAsReadEvent(notificationID: notification.id ?? 0));
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26.withOpacity(0.2)),
                                color: AppColors.whitecolor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: notification!.isRead! ? AppColors.DARK_GREY : Colors.blue.shade100,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: _getNotificationIcon(notification.category),
                                              ),
                                              buildSizedboxW(12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      notification.title ?? '',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    buildSizedBoxH(4),
                                                    Text(
                                                      getTimeAgo(notification.createdDate ?? DateTime.now()),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey.shade600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              AnimatedRotation(
                                                duration: const Duration(milliseconds: 300),
                                                turns: isExpanded ? 0.5 : 0,
                                                child: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          AnimatedCrossFade(
                                            duration: const Duration(milliseconds: 300),
                                            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                            firstChild: Padding(
                                              padding: const EdgeInsets.only(top: 8),
                                              child: Text(
                                                notification.message ?? '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                            ),
                                            secondChild: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                buildSizedBoxH(16),
                                                Text(
                                                  notification.message ?? '',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                ),
                                                buildSizedBoxH(16),
                                                Row(
                                                  children: [
                                                    // _buildInfoChip(
                                                    //   context,
                                                    //   Icons.phone,
                                                    //   notification.mobileNo ?? '',
                                                    // ),
                                                    // buildSizedboxW(12),
                                                    _buildInfoChip(
                                                      context,
                                                      notification.isRead! ? Icons.mark_email_read : Icons.mark_email_unread,
                                                      notification.isRead! ? 'Read' : 'Unread',
                                                    ),
                                                    buildSizedboxW(12),
                                                    Visibility(
                                                      visible: notification.batchID != null ? true : false,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          if (notification.batchID != null) {
                                                            // Navigate to the specific screen with relevant data
                                                            NavigatorService.pushNamed(AppRoutes.rnwviewcoursescreen, arguments: [
                                                              notification.batchID != null ? notification.batchID.toString() : '',
                                                              [StudentData(contact: notification.mobileNo)]
                                                            ]);
                                                          }
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey.shade100,
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                          child: Text(
                                                            'View',
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              color: Colors.grey.shade600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )));
                  },
                );
        }));
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade600),
          buildSizedboxW(6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getNotificationIcon(String? category) {
    switch (category) {
      case 'ADMISSION':
        return CustomImageView(imagePath: Assets.image.png.notification.lecture.path, width: 20, height: 20);
      case 'ANNOUNCEMENT':
        return CustomImageView(imagePath: Assets.image.png.notification.announcement.path, width: 20, height: 20);
      case 'ATTENDANCE':
        return CustomImageView(imagePath: Assets.image.png.notification.lecture.path, width: 20, height: 20);
      case 'BATCH':
        return CustomImageView(imagePath: Assets.image.png.notification.lecture.path, width: 20, height: 20);
      case 'EVENT':
        return CustomImageView(imagePath: Assets.image.png.notification.event.path, width: 20, height: 20);
      case 'FEES':
        return CustomImageView(imagePath: Assets.image.png.notification.payroll.path, width: 20, height: 20);
      default:
        return Icon(Icons.notifications, color: Colors.grey.shade600, size: 20);
    }
  }

  String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}
