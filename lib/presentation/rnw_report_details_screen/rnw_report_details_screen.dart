import 'package:rnw_institue/apis/repositorise/ptm_report_repository.dart';
import 'package:rnw_institue/presentation/rnw_report_screen/model/student_ptm_report_model.dart';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:flutter_html/flutter_html.dart';

class RnwReportDetailsScreen extends StatefulWidget {
  final String? recuringId;
  final String? studentName;
  const RnwReportDetailsScreen({super.key, this.recuringId, this.studentName});

  static Widget builder(BuildContext context) {
    final List args = ModalRoute.of(context)?.settings.arguments as List;
    return BlocProvider<ReportBloc>(
      create: (context) =>
          ReportBloc(ReportilsitialEvent(), reportRepository: ReportRepository(apiClient: ApiClient())),
      child: RnwReportDetailsScreen(recuringId: args[0].toString(), studentName: args[1].toString()),
    );
  }

  @override
  State<RnwReportDetailsScreen> createState() => _RnwReportDetailsScreenState();
}

class _RnwReportDetailsScreenState extends State<RnwReportDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ReportBloc>().add(FetchStudentReportEvent(widget.recuringId ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whitecolor,
        appBar: RNWAppBar(
            leading: IconButton(
                onPressed: () => NavigatorService.goBack(),
                icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.whitecolor)),
            title: Text(widget.studentName ?? 'Unknown Name',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.whitecolor)),
            centerTitle: true),
        body: BlocBuilder<ReportBloc, ReportState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const AttandanceShimmer();
            } else if (state.ptmReportModel == null) {
              return const Center(child: RnwExceptionScreen());
            }
            return BackgroundImage(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Column(children: [
                        buildSizedBoxH(15),
                        buildStudentInformationContainer(state.ptmReportModel?.data?.first),
                        buildSizedBoxH(14),
                        buildcourseDetails(state.ptmReportModel?.data?.first),
                        buildSizedBoxH(14),
                        buildReportDetails(state.ptmReportModel?.data?.first),
                        buildSizedBoxH(15),
                        buildBehaviurandRegularity(state.ptmReportModel?.data?.first),
                        buildSizedBoxH(15),
                        buildTotalActivity(state.ptmReportModel?.data?.first),
                        buildSizedBoxH(15),
                        buildRemark(state.ptmReportModel?.data?.first),
                        buildSizedBoxH(15),
                        buildparentInfo(state.ptmReportModel?.data?.first),
                        buildSizedBoxH(15)
                      ]))),
            );
          },
        ));
  }

//Student Information Container
  Widget buildStudentInformationContainer(DataListModel? studentData) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration:
            BoxDecoration(color: AppColors.whitecolor, borderRadius: BorderRadius.circular(5.r), boxShadow: const [
          BoxShadow(blurRadius: 1, color: Colors.black26),
        ]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Student Info Column
              Expanded(child: buildStudentInfoColumn(studentData)),
              //Student Profile image
              buildImageContainer()
            ]));
  }

// Student informatrion Column --[ Name , GR.ID. , Course , Contact , Status , Fees ]
  Widget buildStudentInfoColumn(DataListModel? studentData) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildUserProfileDetails("${Lang.current.lbl_studentname} : ", " ${studentData?.studentInfo?.name.toString()}"),
      _buildUserProfileDetails("${Lang.current.lbl_grid} : ", " ${studentData?.studentInfo?.grId.toString()}"),
      _buildUserProfileDetails(Lang.current.lbl_facultyname, " ${studentData?.studentInfo?.faculty.toString()}"),
      _buildUserProfileDetails(
          "${Lang.current.lbl_batchtime} : ", " ${studentData?.studentInfo?.batchTime.toString()}"),
      _buildUserProfileDetails("${Lang.current.lbl_course} : ", " ${studentData?.studentInfo?.course.toString()}"),
      _buildUserProfileDetails(
          "${Lang.current.lbl_parents} No. :", " ${studentData?.parentInfo?.contactNumber.toString()}"),
      _buildUserProfileDetails(
        "${Lang.current.lbl_uniform} : ",
        " ${studentData?.studentInfo?.uniform.toString()}",
      ),
      _buildUserProfileDetails(
        "${Lang.current.lbl_discipline} : ",
        " ${studentData?.studentInfo?.discipline.toString()}",
      ),
    ]);
  }

//Student Profile image Container
  Widget buildImageContainer() {
    return Container(
        height: 60.h,
        width: 60.w,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(4.r),
            boxShadow: [BoxShadow(blurRadius: 3, color: AppColors.primaryColor.withOpacity(0.2))],
            image: DecorationImage(image: AssetImage(Assets.image.png.pngProfilePlaceholder.path), fit: BoxFit.cover)));
  }

  Widget _buildUserProfileDetails(String title, String details) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.textboldColor)),
          Expanded(
              child: Text(
                  overflow: TextOverflow.ellipsis,
                  details,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 13.sp, fontWeight: FontWeight.normal, color: AppColors.grayColors)))
        ]));
  }

  Widget buildReportDate() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [buildreportDates(), buildSizedBoxH(10), buildReportTime()]);
  }

//report start Date Ore End Date
  Widget buildreportDates() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            flex: 1,
            child: CustomImageView(
                imagePath: Assets.image.icon.icCalender.path,
                color: AppColors.textColor,
                fit: BoxFit.contain,
                height: 18.h,
                width: 2.w)),
        buildSizedboxW(10),
        Expanded(
            flex: 4,
            child: Text(Lang.current.lbl_report_start_date,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 12.sp))),
        const Spacer(flex: 3),
        Expanded(
            flex: 4,
            child: Text(Lang.current.lbl_report_end_date,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 12.sp)))
      ]),
      buildSizedBoxH(6),
      Padding(
          padding: EdgeInsets.only(left: 38.w, right: 4.w),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                flex: 3,
                child: Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text('01/10/2024',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp)))),
            Expanded(
                child: Text('To',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp))),
            Expanded(
                flex: 3,
                child: Center(
                    child: Padding(
                        padding: EdgeInsets.only(right: 25.w),
                        child: Text('30/10/2024',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp)))))
          ]))
    ]);
  }

//report start Date Ore End Date
  Widget buildReportTime() {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            flex: 1,
            child: CustomImageView(
                imagePath: Assets.image.icon.icBatchStart.path,
                height: 20.h,
                width: 1.w,
                fit: BoxFit.contain,
                color: AppColors.blackcolor)),
        buildSizedboxW(10),
        Expanded(
            flex: 4,
            child: Text(Lang.current.lbl_batc_start_time,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 12.sp))),
        const Spacer(flex: 3),
        Expanded(
            flex: 4,
            child: Text(Lang.current.lbl_batc_end_time,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 12.sp)))
      ]),
      buildSizedBoxH(6),
      Padding(
          padding: EdgeInsets.only(left: 42.w),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                flex: 3,
                child: Text('4:00 PM',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp))),
            Expanded(
                child: Text('To',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp))),
            Expanded(
                flex: 3,
                child: Padding(
                    padding: EdgeInsets.only(right: 50.w),
                    child: Text(
                        textAlign: TextAlign.center,
                        '6:00 PM',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp))))
          ]))
    ]);
  }

  Widget buildcourseDetails(DataListModel? studentData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: AppColors.whitecolor,
        boxShadow: const [BoxShadow(blurRadius: 1, color: Colors.black26)],
      ),
      child: Column(
        children: [
          buildSizedBoxH(4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: Row(
              children: [
                _buildtitleText("Course Details"),
              ],
            ),
          ),
          buildSizedBoxH(4),
          const Divider(thickness: 1, color: AppColors.boxShadow, height: 1),
          buildSizedBoxH(4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildtitleText("Running Software"),
                _buildtitleText("Completed Course"),
              ],
            ),
          ),
          buildSizedBoxH(8),
          Column(
            children: List.generate(
              1,
              (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: studentData?.courseDetails?.runningSoftware?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration:
                                  BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: _buildDetailsText(studentData?.courseDetails?.runningSoftware![index] ?? '',
                                    maxLines: 1, textAlign: TextAlign.center, color: AppColors.DARK_BLUE),
                              ),
                            );
                          },
                        ),
                      ),
                      buildSizedboxW(8),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: studentData?.courseDetails?.completedCourses?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration:
                                  BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: _buildDetailsText(studentData?.courseDetails?.completedCourses?[index] ?? '',
                                    maxLines: 1, textAlign: TextAlign.center, color: AppColors.completed),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

//Subject, Attendence,Persentage Container
  Widget buildReportDetails(DataListModel? studentData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: AppColors.whitecolor,
        boxShadow: const [BoxShadow(blurRadius: 1, color: Colors.black26)],
      ),
      child: Column(
        children: [
          buildSizedBoxH(4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: Row(
              children: [
                Expanded(flex: 1, child: _buildtitleText("#")),
                Expanded(flex: 3, child: _buildtitleText("Subject")),
                Expanded(
                  flex: 4,
                  child: _buildtitleText("Attendance", textAlign: TextAlign.center),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: _buildtitleText("Performance", textAlign: TextAlign.right),
                  ),
                ),
              ],
            ),
          ),
          buildSizedBoxH(4),
          const Divider(thickness: 1, color: AppColors.boxShadow, height: 1),
          buildSizedBoxH(4),
          Column(
            children: List.generate(
              studentData?.performance?.length ?? 0,
              (index) {
                final performance = studentData?.performance?[index];
                final subject = performance?.subjects?.isNotEmpty == true ? performance!.subjects : 'N/A';
                final presentday = performance?.presentDays?.toString() ?? '0';
                final workingday = performance?.workingDays?.toString() ?? '0';
                final percentageStr = performance?.performance?.toString().replaceAll('%', '') ?? '0';

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _buildDetailsText("${index + 1}"),
                      ),
                      Expanded(
                        flex: 3,
                        child: _buildDetailsText(subject!, maxLines: 2),
                      ),
                      Expanded(
                        flex: 4,
                        child: _buildDetailsText("$presentday/$workingday", maxLines: 1, textAlign: TextAlign.center),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Stack(
                            children: [
                              CircularProgressIndicator(
                                strokeAlign: 1,
                                value: (_parsePerformance(percentageStr)),
                                strokeCap: StrokeCap.round,
                                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                                backgroundColor: Colors.grey[300],
                              ),
                              Positioned(
                                child: CircleAvatar(
                                  backgroundColor: AppColors.whitecolor,
                                  maxRadius: 18,
                                  child: Text(
                                    "${double.tryParse(percentageStr)?.toStringAsFixed(0)}%",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          buildSizedBoxH(6),
        ],
      ),
    );
  }

//BEHAVIOUR AND REGULARITY
  Widget buildBehaviurandRegularity(DataListModel? studentData) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.whitecolor,
            boxShadow: const [BoxShadow(blurRadius: 1, color: Colors.black26)],
            borderRadius: BorderRadius.circular(4.r)),
        child: Column(children: [
          buildSizedBoxH(4),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    flex: 1,
                    child: _buildtitleText(
                      "#",
                    )),
                Expanded(
                    flex: 7,
                    child: _buildtitleText(
                      "Behaviour & Regularity",
                      textAlign: TextAlign.start,
                    )),
                Expanded(flex: 3, child: _buildtitleText("Performance", textAlign: TextAlign.center))
              ])),
          buildSizedBoxH(4),
          const Divider(thickness: 1, color: Colors.black26, height: 1),
          buildSizedBoxH(4),
          Column(
              children: List.generate(3, (index) {
            List progress = [
              (studentData?.behaviorRatings?.behaviorWithFaculty?.toString() ?? 'N/A'),
              (studentData?.behaviorRatings?.behaviorWithOtherTeam?.toString() ?? 'N/A'),
              (studentData?.behaviorRatings?.behaviorWithOtherStudent?.toString() ?? 'N/A'),
            ];
            List behaviourList = ['Behaviour with faculty', 'Behavior with other team', 'Behavior with other student'];

            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Expanded(
                      flex: 1,
                      child: _buildDetailsText(
                        "${index + 1}",
                        maxLines: 1,
                      )),
                  Expanded(
                      flex: 7,
                      child: _buildDetailsText(
                        behaviourList[index],
                        maxLines: 1,
                      )),
                  Expanded(
                      flex: 3,
                      child: _buildDetailsText(
                        progress[index],
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ))
                ]));
          })),
          buildSizedBoxH(5)
        ]));
  }

//Project , Submit
  Widget buildProjectActivity() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.sp),
            color: Colors.white,
            boxShadow: const [BoxShadow(blurRadius: 1, color: Colors.black26)]),
        child: Column(children: [
          buildSizedBoxH(4),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5),
              child: Row(children: [
                Expanded(flex: 1, child: _buildtitleText("#")),
                Expanded(
                  flex: 3,
                  child: _buildtitleText(Lang.current.lbl_project),
                ),
                Expanded(
                  flex: 3,
                  child: _buildtitleText(Lang.current.lbl_submit),
                ),
                Expanded(
                  flex: 3,
                  child: _buildtitleText(Lang.current.lbl_on_time),
                ),
                Expanded(flex: 2, child: _buildtitleText(Lang.current.lbl_Quality))
              ])),
          buildSizedBoxH(4),
          const Divider(thickness: 1, color: Colors.black26, height: 1),
          Column(
              children: List.generate(2, (index) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: _buildDetailsText(
                      "${index + 1}",
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(left: 18.w),
                        child: _buildDetailsText(
                          "3",
                        ),
                      )),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(right: 14.w),
                        child: _buildDetailsText(
                          "4",
                          textAlign: TextAlign.center,
                        ),
                      )),
                  Expanded(
                    flex: 3,
                    child: _buildDetailsText(
                      "5",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _buildDetailsText(
                      "High",
                      textAlign: TextAlign.center,
                    ),
                  )
                ]));
          }))
        ]));
  }

  // Total Activity
  Widget buildTotalActivity(DataListModel? studentData) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: Colors.white,
          boxShadow: const [BoxShadow(blurRadius: 1, color: Colors.black26)]),
      child: Column(
        children: [
          buildSizedBoxH(4),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(flex: 1, child: _buildtitleText("#")),
                Expanded(flex: 7, child: _buildtitleText("Total Attendance", textAlign: TextAlign.start)),
                Expanded(flex: 3, child: _buildtitleText("Total Performance", textAlign: TextAlign.center)),
                buildSizedboxW(0)
              ])),
          buildSizedBoxH(4),
          const Divider(thickness: 1, color: Colors.black26, height: 1),
          buildSizedBoxH(5),
          Column(
            children: List.generate(
              1,
              (index) {
                final statsData = studentData?.attendance;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: _buildDetailsText(
                          "${index + 1}",
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: _buildDetailsText(
                          " ${statsData?.presentDays ?? 0}/${statsData?.totalDays ?? 0}",
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          // Removed nested Expanded
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                strokeAlign: 1,
                                value: (_parsePerformance(statsData?.performance)),
                                strokeCap: StrokeCap.round,
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                                backgroundColor: Colors.grey[300],
                              ),
                              Positioned(
                                child: CircleAvatar(
                                  backgroundColor: AppColors.whitecolor,
                                  maxRadius: 18,
                                  child: Text(
                                      textAlign: TextAlign.center,
                                      "${double.tryParse(statsData?.performance?.toString() ?? '0')?.toStringAsFixed(0)}%",
                                      style: Theme.of(context).textTheme.bodySmall),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          buildSizedBoxH(8)
        ],
      ),
    );
  }

  double _parsePerformance(dynamic performance) {
    if (performance == null) return 0.0;
    double? parsedValue = double.tryParse(performance.toString());
    if (parsedValue != null) {
      double percentageValue = parsedValue / 100;
      return percentageValue.clamp(0.0, 1.0);
    }
    return 0.0;
  }

  // REMARK
  Widget buildRemark(DataListModel? studentData) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: AppColors.whitecolor,
            boxShadow: const [BoxShadow(blurRadius: 1, color: Colors.black26)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          buildSizedBoxH(5),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                    child: Center(
                        child: Text(Lang.current.lbl_remark,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColors.textColor))))
              ])),
          const Divider(thickness: 1, color: Colors.black26),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Html(
              data: studentData?.remarks ?? "",
              style: {
                "body": Style(
                  fontSize: FontSize(12.sp),
                  letterSpacing: 0.5,
                  lineHeight: const LineHeight(1.5),
                ),
              },
            ),
          ),
          buildSizedBoxH(5),
        ]));
  }

  // PARENTS INFO
  Widget buildparentInfo(DataListModel? studentData) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0.h),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.whitecolor,
              boxShadow: const [BoxShadow(blurRadius: 1, color: Colors.black26)]),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            buildSizedBoxH(5),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  SizedBox(
                      child: Center(
                          child: Text(Lang.current.lbl_parentinfo,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColors.textColor))))
                ])),
            const Divider(thickness: 1, color: Colors.black26),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Column(
                  children: [
                    _buildUserProfileDetails(
                        Lang.current.lbl_visitingperson, " ${studentData?.parentInfo?.name?.toString() ?? 'N/A'}"),
                    buildSizedBoxH(2),
                    _buildUserProfileDetails(Lang.current.lbl_relationwithstudent,
                        " ${studentData?.parentInfo?.relation?.toString() ?? 'N/A'}"),
                    buildSizedBoxH(2),
                    _buildUserProfileDetails("${Lang.current.lbl_number} :",
                        " ${studentData?.parentInfo?.contactNumber?.toString() ?? 'N/A'}"),
                  ],
                )),
            buildSizedBoxH(5),
          ])),
    );
  }

  Widget _buildtitleText(String title, {TextAlign? textAlign, int? maxLines}) {
    return Text(
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColors.textColor));
  }

  Widget _buildDetailsText(String details, {TextAlign? textAlign, int? maxLines, Color? color}) {
    return Text(
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        details,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12.sp, color: color));
  }
}
