import 'package:intl/intl.dart';
import 'package:rnw_institue/utils/app_export.dart';

mixin StudentMixin {
  //
  Color getCourseStatusBorderColor(String status) {
    switch (status) {
      case 'Ongoing':
        return AppColors.ongoing;
      case 'Completed':
        return AppColors.completed;
      case 'Pending':
        return AppColors.pending;
      default:
        return Colors.transparent;
    }
  }

  Color getCourseStatusColor(String status) {
    switch (status) {
      case 'ONGOING':
        return Color(0xff3abaf4);
      case 'PENDING':
        return Colors.red;
      case 'COMPLETED':
        return Color(0xff54ca68);
      case 'CANCELLED':
        return Color(0xfffc544b);
      case 'ON_VACATION':
        return Color(0xffdd0d0d);
      case 'ON_HOLD':
        return Color(0xff9852a5);
      case 'UP_COMING':
        return Color(0xffffa426);
      default:
        return Colors.grey;
    }
  }

  DateTime toDateTime(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
    var outputDate = outputFormat.format(inputDate);
    return DateTime.parse(outputDate);
  }

  List<DateTime> getMonthDays(DateTime date) {
    List<DateTime> days = [];
    int _daysInMonth = DateTimeRange(
      start: date,
      end: DateTime(date.year, date.month + 1),
    ).duration.inDays;

    for (int i = 0; i < _daysInMonth; i++) {
      days.add(DateTime(date.year, date.month, i + 1));
    }
    return days;
  }
}

String useCourseField(dynamic course) {
  if (course is String) {
    return course;
  } else if (course is List<String>) {
    String courseString = course.join(', ');
    return courseString;
  } else {
    return "No valid course data available.";
  }
}

notificationIcon() {
  return ValueListenableBuilder<int>(
    valueListenable: unreadCountNotifier,
    builder: (context, unreadCount, child) {
      if (unreadCount == 0) {
        return CustomImageView(
          imagePath: Assets.image.icon.icNotification.path,
          height: 25.h,
          width: 25.w,
          color: AppColors.whitecolor,
        );
      }
      return Padding(
        padding: EdgeInsets.only(right: unreadCount >= 100 ? 8 : 0),
        child: Badge(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          backgroundColor: AppColors.whitecolor,
          textColor: AppColors.blackcolor,
          textStyle: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
          label: Text(unreadCount >= 100 ? '99+' : unreadCount.toString()),
          child: CustomImageView(
            imagePath: Assets.image.icon.icNotification.path,
            height: 25.h,
            width: 25.w,
            color: AppColors.whitecolor,
          ),
        ),
      );
    },
  );
}
