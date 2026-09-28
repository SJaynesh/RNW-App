import 'package:rnw_institue/presentation/student_info_screen/model/student_details_model.dart';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/utils/mixin.dart';

class StudentInfoScreen extends StatefulWidget {
  final String admissionId;
  const StudentInfoScreen({super.key, required this.admissionId});

  static Widget builder(BuildContext context) {
    final List args = ModalRoute.of(context)?.settings.arguments as List;
    final int index = args[0];
    return BlocProvider<StudentInfoBloc>(
        create: (context) => StudentInfoBloc(const StudentInfoState(),
            HomeModuleRepository(apiClient: ApiClient())),
        child: StudentInfoScreen(admissionId: index.toString()));
  }

  @override
  State<StudentInfoScreen> createState() => _StudentInfoScreenState();
}

class _StudentInfoScreenState extends State<StudentInfoScreen> {
  bool isparentsNumberMatched = false;

  @override
  void initState() {
    context
        .read<StudentInfoBloc>()
        .add(GetStudentDetailsAPIEvent(admissionId: widget.admissionId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RNWAppBar(
            title: Text(Lang.current.lbl_redwhitemultimedia),
            leadingWidth: 35.w,
            leading: IconButton(
                style: const ButtonStyle(
                    overlayColor: WidgetStatePropertyAll(Colors.transparent)),
                onPressed: () => NavigatorService.goBack(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.whitecolor)),
            action: [
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: GestureDetector(
                  onTap: () {
                    NavigatorService.pushNamed(AppRoutes.rnwnotificationslist);
                  },
                  child: notificationIcon(),
                ),
              ),
            ]),
        body: BackgroundImage(
          child: BlocBuilder<StudentInfoBloc, StudentInfoState>(
              builder: (context, state) {
            if (state.isLoading) {
              return const HomeLoadingShimmer();
            } else if (state.studentdetailsModel?.data == null) {
              return const Center(child: RnwExceptionScreen());
            } else {
              return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  children: [
                    buildSizedBoxH(25),
                    buildStudentInformationContainer(state.studentdetailsModel),
                    buildSizedBoxH(20),
                    rnWBannerImage(),
                    buildSizedBoxH(20),
                    buildMoreInformation(
                        state.studentdetailsModel, isparentsNumberMatched),
                    buildSizedBoxH(20)
                  ]);
            }
          }),
        ));
  }

//Student Information Container
  Widget buildStudentInformationContainer(
      StudentDetailsModel? studentdetailsModel) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
            color: AppColors.whitecolor,
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: const [
              BoxShadow(blurRadius: 1, color: AppColors.boxShadow)
            ]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildStudentInfoColumn(studentdetailsModel)),
              buildImageContainer(studentdetailsModel)
            ]));
  }

  Widget buildStudentInfoColumn(StudentDetailsModel? studentdetailsModel) {
    var studentData = studentdetailsModel?.data?.first;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildUserProfileDetails(Lang.current.lbl_name,
          "${studentData?.firstName ?? Lang.current.lbl_n_a} ${studentData?.middleName ?? Lang.current.lbl_n_a} ${studentData?.lastName ?? Lang.current.lbl_n_a}"),
      _buildUserProfileDetails(Lang.current.lbl_grid,
          "${studentData?.grId ?? Lang.current.lbl_n_a}"),
      _buildUserProfileDetails(
          Lang.current.lbl_course, useCourseField(studentData?.course)),
      _buildUserProfileDetails(
          Lang.current.lbl_contact,
          studentData?.contact ??
              studentData?.parentMobileNo?.fatherMobileNo ??
              studentData?.parentMobileNo?.motherMobileNo ??
              Lang.current.lbl_n_a),
      //Curently Student Status
      _buildUserProfileDetails(
          Lang.current.lbl_status,
          studentData?.status != null
              ? studentData?.status?.toLowerCase() ?? 'N/A'
              : Lang.current.lbl_n_a),
      _buildUserProfileDetails(
        Lang.current.lbl_branch_code,
        studentData?.branchCode ?? Lang.current.lbl_n_a,
      ),
      //Student Fees
      // _buildUserProfileDetails(Lang.current.lbl_fees,
      //     "₹ ${studentData?.admissionAmount ?? Lang.current.lbl_n_a}")
    ]);
  }

  Widget buildImageContainer(StudentDetailsModel? studentdetailsModel) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 3, color: AppColors.primaryColor.withOpacity(0.2))
        ]),
        child: CustomImageView(
            height: 60.h,
            width: 60.w,
            imagePath: studentdetailsModel?.data?[0].image != null
                ? "${ApiEndPoints.studentimagebaseurl}${studentdetailsModel?.data?[0].image}"
                : Assets.image.png.pngProfilePlaceholder.path,
            fit: BoxFit.cover,
            radius: BorderRadius.circular(5.r)));
  }

  Widget buildMoreInformation(
      StudentDetailsModel? studentdetailsModel, bool isMatched) {
    String? contactNumber = studentdetailsModel?.data?.first.contact;
    String? loginMobileNo = PrefObj.preferences?.get(PrefKeys.PHONENUMBER);
    String? fatherMobileNo =
        studentdetailsModel?.data?.first.parentMobileNo?.fatherMobileNo;
    String? motherMobileNo =
        studentdetailsModel?.data?.first.parentMobileNo?.motherMobileNo;
    isparentsNumberMatched = checkMobileNumberMatch(
        contactNumber, loginMobileNo, fatherMobileNo, motherMobileNo);

    //Here

    // Dynamic lists based on match
    List<String> images = [
      Assets.image.icon.icAttendance.path,
      Assets.image.icon.icCourses.path,
      Assets.image.icon.icSigning.path,
      Assets.image.icon.icFeeDetails.path,
      Assets.image.icon.icHelp.path,
      Assets.image.icon.icFeedback.path,
      Assets.image.icon.icSpeaker.path,
    ];

    List<String> titles = [
      Lang.current.lbl_attendances,
      Lang.current.lbl_courses,
      Lang.current.lbl_signing_sheet,
      Lang.current.lbl_feedetails,
      Lang.current.lbl_help_center,
      Lang.current.lbl_feedbacks,
      Lang.current.lbl_announcement,
    ];

    List<String> routes = [
      AppRoutes.rnwattendancescreen,
      AppRoutes.rnwCourseDetailsscreen,
      AppRoutes.rnwsigningsheetscreen,
      AppRoutes.rnwfeesdetailsscreen,
      AppRoutes.rnwhelpcenter,
      AppRoutes.rNWfeedbackwebviewScreen,
      AppRoutes.rnwAnnouncementlist,
    ];

    if (!isparentsNumberMatched) {
      images.add(Assets.image.icon.icReport.path);
      titles.add(Lang.current.lbl_ptm_report);
      routes.add(AppRoutes.rNWReportScreen);
    }
    if (isparentsNumberMatched &&
        studentdetailsModel?.data?.first.placementurl != null &&
        studentdetailsModel?.data?.first.placementurl != "" &&
        studentdetailsModel?.data?.first.status == 'COMPLETED' &&
        (studentdetailsModel?.data?.first.upskillCourse?.contains(false) ??
            false)) {
      images.add(Assets.image.icon.icReport.path);
      titles.add(Lang.current.lbl_apply_job);
    }

    return GridView.builder(
        shrinkWrap: true,
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.3,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15),
        itemBuilder: (context, index) {
          final isAnnouncement = titles[index] == Lang.current.lbl_announcement;
          final announcementCount =
              studentdetailsModel?.data?.first.announcementNo ?? 0;

          final bool isAnnouncementClickable =
              isAnnouncement && announcementCount > 0;
          return GestureDetector(
              onTap: () async {
                if (titles[index] == Lang.current.lbl_apply_job) {
                  final String? placementUrl =
                      studentdetailsModel?.data?.first.placementurl;
                  if (placementUrl != null && placementUrl.isNotEmpty) {
                    final Uri jobUrl = Uri.parse(placementUrl);
                    await launchUrl(jobUrl,
                        mode: LaunchMode.externalApplication);
                  }
                } else {
                  NavigatorService.pushNamed(routes[index], arguments: [
                    studentdetailsModel?.data?.first.grId ?? 0,
                    studentdetailsModel?.data?.first.admissionId ?? 0,
                    studentdetailsModel?.data,
                    studentdetailsModel?.data?.first.branchid ?? '',
                  ]).then((_) {
                    if (titles[index] == Lang.current.lbl_announcement) {
                      context.read<StudentInfoBloc>().add(
                            GetStudentDetailsAPIEvent(
                              admissionId: widget.admissionId,
                            ),
                          );
                    }
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.whitecolor,
                    boxShadow: const [
                      BoxShadow(blurRadius: 1.5, color: AppColors.boxShadow)
                    ],
                    borderRadius: BorderRadius.circular(4.r)),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImageView(
                              color: AppColors.PRIMERY_COLOR,
                              imagePath: images[index],
                              height: 30.h,
                              width: 30.w,
                              fit: BoxFit.contain),
                          buildSizedBoxH(8.h),
                          Text(
                            titles[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColors.blackcolors,
                                ),
                          ),
                        ],
                      ),
                    ),
                    if (isAnnouncementClickable)
                      Positioned(
                        right: 5,
                        top: 5,
                        child: Container(
                          padding: EdgeInsets.all(5.r),
                          decoration: const BoxDecoration(
                            color: AppColors.PRIMERY_COLOR,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            announcementCount.toString(),
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ));
        });
  }

  Widget _buildUserProfileDetails(String title, String details) {
    return Row(children: [
      Text("$title : ",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.blackcolors)),
      Expanded(
          child: Text(
              overflow: TextOverflow.ellipsis,
              details,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.grayColors)))
    ]);
  }

  bool checkMobileNumberMatch(String? contactNumber, String? loginMobileNo,
      String? fatherMobileNo, String? motherMobileNo) {
    if (contactNumber == null) {
      return false;
    }

    if (loginMobileNo == contactNumber) {
      if (loginMobileNo == fatherMobileNo || loginMobileNo == motherMobileNo) {
        return false;
      }
      return true;
    }

    if (loginMobileNo == fatherMobileNo && loginMobileNo == motherMobileNo) {
      return false;
    }

    return false;
  }
}
