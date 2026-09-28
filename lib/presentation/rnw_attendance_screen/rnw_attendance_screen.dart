// ignore_for_file: unused_element
import 'package:intl/intl.dart';
import 'package:rnw_institue/presentation/rnw_attendance_screen/model/student_attendance_model.dart';
import 'package:rnw_institue/presentation/rnw_attendance_screen/model/student_wise_attendence_model.dart';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/utils/mixin.dart';

class RNWAttendanceScreen extends StatefulWidget {
  final String admissionId;
  const RNWAttendanceScreen({
    super.key,
    required this.admissionId,
  });

  static Widget builder(BuildContext context) {
    final List args = ModalRoute.of(context)?.settings.arguments as List;
    final dynamic admissionID = args[1];

    return BlocProvider<AttendanceBloc>(
      create: (context) => AttendanceBloc(
        const AttendanceState(),
        HomeModuleRepository(apiClient: ApiClient()),
      )..add(AttendanceilsitialEvent()),
      child: RNWAttendanceScreen(
        admissionId: admissionID.toString(),
      ),
    );
  }

  @override
  State<RNWAttendanceScreen> createState() => _RNWAttendanceScreenState();
}

class _RNWAttendanceScreenState extends State<RNWAttendanceScreen> {
  EventList<Event> _markedDateMap = EventList(events: {});
  int? totalPresnt = 0;
  int? totalAbsent = 0;
  int? totalCount = 0;
  List<String> punches = [];
  bool ispunchvisible = false;
  dynamic isDotdate;

  late final ValueNotifier<List<Event>> selectedEvents;
  late DateTime focusedDay;
  late DateTime _selectedDay;
  final Map<DateTime, List<Event>> _eventMap =
      {}; // Replace with your migrated data

  @override
  void initState() {
    context.read<AttendanceBloc>().add(GetStudentAttendanceAPIEvent(
        admissionId: widget.admissionId,
        month: DateTime.now().month.toString(),
        year: DateTime.now().year.toString()));
    context.read<AttendanceBloc>().add(StudentwiseAttendanceAPIEvent(
        admissionId: widget.admissionId,
        month: DateTime.now().month.toString(),
        year: DateTime.now().year.toString()));
    super.initState();
    focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  getCalanderData() {}

  List<Event> _getEventsForDay(DateTime day) {
    return _eventMap[day] ?? [];
  }

  List<Color> getAttendanceColors(List<Attendance> attendance) {
    return attendance.map((details) {
      if (details.present == true) {
        return Colors.green;
      } else if (details.absent == false || details.absent == true) {
        return AppColors.primaryColor.withOpacity(0.8);
      } else if (details.leave == true) {
        return AppColors.grayColors.withOpacity(0.8);
      }
      return Colors.transparent;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height.h;

    return Scaffold(
        appBar: _buildAppBar(context),
        body: BackgroundImage(child:
            BlocBuilder<AttendanceBloc, AttendanceState>(
                builder: (context, state) {
          List attandances = state.studentAttendanceModel?.data?.rows ?? [];
          _markedDateMap.clear();
          for (var element in attandances) {
            List<Color> colorList = element.attendance.isNotEmpty
                ? getAttendanceColors(element.attendance)
                : [];

            DateTime dateTime = DateTime.parse(element.date);
            int year = dateTime.year;
            int month = dateTime.month;
            int day = dateTime.day;

            _markedDateMap.add(
              DateTime(year, month, day),
              Event(
                date: DateTime(year, month, day),
                title: element.date.toString(),
                dot: GestureDetector(
                  onTap: () {
                    studentwiseattendenceData? matchedAttendance =
                        state.studentwiseAttendanceModel?.data?.firstWhere(
                      (e) => e.date == element.date,
                      orElse: () => studentwiseattendenceData(
                        date: element.date,
                        punches: [],
                      ),
                    );

                    if (matchedAttendance != null) {
                      punches = matchedAttendance.punches ?? [];
                    }
                    setState(() {
                      ispunchvisible = true;
                      isDotdate = element.date;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      gradient: (colorList.length > 1)
                          ? LinearGradient(colors: colorList)
                          : null,
                      color: (colorList.length == 1) ? colorList.first : null,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Center(
                      child: Text(
                        day.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(children: [
                // buildSizedBoxH(15),
                // rnWBannerImage(),
                buildSizedBoxH(20),
                _buildCalendar(height),
                buildSizedBoxH(15),
                _buildAttendanceSchedule(state.studentAttendanceModel),
                Visibility(visible: ispunchvisible, child: _buildinoutTime()),
              ]),
            ),
          );
        })));
  }

  static Widget _buildEventIcon() {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.whitecolor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: AppColors.blackcolor, width: 2.0),
        ),
        child: const Icon(Icons.person, color: AppColors.ongoing));
  }

  RNWAppBar _buildAppBar(BuildContext context) {
    return RNWAppBar(
        leading: IconButton(
          onPressed: () => NavigatorService.goBack(),
          icon:
              const Icon(Icons.arrow_back_ios_new, color: AppColors.whitecolor),
        ),
        title: Text(Lang.current.lbl_attendances,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.whitecolor)),
        centerTitle: true,
        action: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
                onTap: () {
                  NavigatorService.pushNamed(AppRoutes.rnwnotificationslist);
                },
                child: notificationIcon()),
          ),
        ]);
  }

  Widget _buildCalendar(double height) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
          height: height * 0.45,
          decoration: BoxDecoration(
            color: AppColors.whitecolor,
            boxShadow: [BoxShadow(blurRadius: 5.r, color: Colors.black26)],
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: CalendarCarousel<Event>(
            headerMargin: const EdgeInsets.fromLTRB(0, 5, 0, 15),
            shouldShowTransform: true,
            daysHaveCircularBorder: false,
            selectedDateTime: DateTime.now(),
            minSelectedDate: DateTime(1970),
            maxSelectedDate: DateTime.now(),
            todayBorderColor: Colors.transparent,
            todayButtonColor: AppColors.textColor,
            selectedDayBorderColor: Colors.transparent,
            selectedDayButtonColor: Colors.transparent,
            iconColor: AppColors.textColor,
            headerTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 22.sp,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500),
            weekdayTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 15.sp,
                color: AppColors.textColor,
                fontWeight: FontWeight.w500),
            inactiveWeekendTextStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14.sp, color: AppColors.grayColors),
            prevDaysTextStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14.sp, color: AppColors.grayColors),
            nextDaysTextStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14.sp, color: AppColors.grayColors),
            inactiveDaysTextStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14.sp, color: AppColors.grayColors),
            weekendTextStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14.sp, color: AppColors.textColor),
            todayTextStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14.sp, color: AppColors.textColor),
            selectedDayTextStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14.sp, color: AppColors.textColor),
            daysTextStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14.sp, color: AppColors.textColor),
            markedDatesMap: _markedDateMap,
            onDayPressed: (p0, p1) {
              int day = int.parse(isDotdate.split("-")[2]);
              if (day != p0.day) {
                setState(() {
                  ispunchvisible = false;
                });
              }
            },
            onCalendarChanged: (p0) {
              setState(() {
                _markedDateMap = EventList(events: {});
                context.read<AttendanceBloc>().add(GetStudentAttendanceAPIEvent(
                    admissionId: widget.admissionId,
                    month: p0.month.toString(),
                    year: p0.year.toString()));
                context.read<AttendanceBloc>().add(
                    StudentwiseAttendanceAPIEvent(
                        admissionId: widget.admissionId,
                        month: p0.month.toString(),
                        year: p0.year.toString()));
                totalPresnt = 0;
                totalAbsent = 0;
                totalCount = 0;
              });
            },
          ))
    ]);
  }

  void _resetAttendance() {
    _markedDateMap = EventList(events: {});
  }

  Widget _buildAttendanceSchedule(StudentAttendanceModel? model) {
    return Padding(
        padding: EdgeInsets.only(left: 0.w),
        child: SizedBox(
            height: 100.h,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAttendanceRow(
                          iconColor: AppColors.greenColor,
                          label: model?.data?.present != null
                              ? "${Lang.current.lbl_total_present} : ${model?.data?.present}"
                              : "${Lang.current.lbl_total_present} : 0"),
                      buildSizedBoxH(5),
                      _buildAttendanceRow(
                          iconColor: AppColors.grayColors.withOpacity(0.8),
                          label: model?.data?.leave != null
                              ? "${Lang.current.lbl_total_leave} : ${model?.data?.leave}"
                              : "${Lang.current.lbl_total_leave} : 0"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAttendanceRow(
                          iconColor: AppColors.primaryColor.withOpacity(0.8),
                          label: model?.data?.absent != null
                              ? "${Lang.current.lbl_total_absent} : ${model?.data?.absent}"
                              : "${Lang.current.lbl_total_absent} : 0"),
                      buildSizedBoxH(5),
                      _buildAttendanceRow(
                          iconColor: AppColors.grayColors.withOpacity(0.3),
                          label: model?.data?.totalCount != null
                              ? "${Lang.current.lbl_total_count} : ${model?.data?.totalCount}"
                              : "${Lang.current.lbl_total_count} : 0"),
                    ],
                  ),
                ])));
  }

  Widget _buildinoutTime() {
    String formatTime(String time) {
      if (time.isEmpty || time == "--:--") return "--:--";

      try {
        final parsedTime = DateFormat("HH:mm").parse(time);
        return DateFormat("hh:mm a").format(parsedTime);
      } catch (e) {
        return "--:--";
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.whitecolor,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: const [
          BoxShadow(blurRadius: 1, color: AppColors.boxShadow),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'In Time',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Out Time',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Column(
              children: List.generate(punches.length ~/ 2, (index) {
                final inTime = formatTime(punches[index * 2]);
                final outTime = (index * 2 + 1) < punches.length
                    ? formatTime(punches[index * 2 + 1])
                    : "--:--";

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        inTime,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          outTime,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceRow(
      {required Color iconColor, required String label}) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.circle_rounded, color: iconColor),
      buildSizedboxW(10.w),
      Text(label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textboldColor))
    ]);
  }
}
