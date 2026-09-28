import 'package:rnw_institue/presentation/student_info_screen/model/course_details_model.dart';
import 'package:rnw_institue/presentation/student_info_screen/model/student_details_model.dart';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/utils/mixin.dart';

class RNWCourseDetailsScreen extends StatefulWidget {
  final List<StudentData>? studentData;
  const RNWCourseDetailsScreen({super.key, this.studentData});
  static Widget builder(BuildContext context) {
    final List args = ModalRoute.of(context)?.settings.arguments as List;
    return BlocProvider<CourseBloc>(create: (context) => CourseBloc(const CourseState(), CourseRepository(apiClient: ApiClient())), child: RNWCourseDetailsScreen(studentData: args[2]));
  }

  @override
  State<RNWCourseDetailsScreen> createState() => _RNWCourseDetailsScreenState();
}

class _RNWCourseDetailsScreenState extends State<RNWCourseDetailsScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;
  bool listVisible = false;
  bool isStartScreen = false;
  @override
  void initState() {
    context.read<CourseBloc>().add(GetCourseAPIEvent(addmissionID: widget.studentData?.first.admissionId.toString() ?? ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: RNWAppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.whitecolor)),
            title: Text(Lang.current.lbl_courses),
            centerTitle: true,
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
          child: BlocBuilder<CourseBloc, CourseState>(builder: (context, state) {
            if (state.isLoading) {
              return RnwCourseDetailsShimmer(isCourseScreen: true);
            } else if (state.courseModel?.data == null) {
              return const Center(child: RnwExceptionScreen());
            }
            return SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Column(children: [
                      buildSizedBoxH(20),
                      _buildStudentInformationContainer(width, widget.studentData),
                      buildSizedBoxH(15),
                      // aDSImages(),
                      // _buildCourseContainer(height, state),
                      // buildSizedBoxH(15),
                      buileBatchName(height, width),
                      _buildCorseListView(width, height, state.courseModel),
                      buildSizedBoxH(15),
                      buildSizedBoxH(20)
                    ])));
          }),
        ));
  }

//Student Information Container
  Widget _buildStudentInformationContainer(double width, List<StudentData>? studentData) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(color: AppColors.whitecolor, borderRadius: BorderRadius.circular(5.sp), boxShadow: const [BoxShadow(blurRadius: 2, color: AppColors.boxShadow)]),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
          //Student Info Column
          Expanded(child: buildStudentInfoColumn(studentData)),
          //Student Profile image
          _buildImageContainer(studentData)
        ]));
  }

// Student informatrion Column --[ Name , GR.ID. , Course , Contact , Status , Fees ]
  Widget buildStudentInfoColumn(List<StudentData>? studentData) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //Student name Row
      _buildUserProfileDetails(Lang.current.lbl_name,
          "${studentData?.first.firstName ?? Lang.current.lbl_n_a} ${studentData?.first.middleName ?? Lang.current.lbl_n_a} ${studentData?.first.lastName ?? Lang.current.lbl_n_a}"),
      //Student GR.ID Number
      _buildUserProfileDetails(Lang.current.lbl_grid, "${studentData?.first.grId ?? Lang.current.lbl_n_a}"),

      //Course Name Row
      _buildUserProfileDetails(Lang.current.lbl_course, useCourseField(studentData?.first.course)),

      //Student Contect Number
      _buildUserProfileDetails(
          Lang.current.lbl_contact, studentData?.first.contact ?? studentData?.first.parentMobileNo?.fatherMobileNo ?? studentData?.first.parentMobileNo?.motherMobileNo ?? "Add Mobile Number"),

      //Curently Student Status
      _buildUserProfileDetails(Lang.current.lbl_status, studentData?[0].status == 'ONGOING' ? "Ongoing" : Lang.current.lbl_n_a),

      _buildUserProfileDetails(
        Lang.current.lbl_branch_code,
        studentData?[0].branchCode ?? Lang.current.lbl_n_a,
      ),

      //Student Fees
      // _buildUserProfileDetails(Lang.current.lbl_fees,
      //     "₹ ${studentData?.first.admissionAmount ?? 'N/A'}")
    ]);
  }

  Widget _buildCourseContainer(double height, CourseState state) {
    return Container(
        height: height * 0.28,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.whitecolor, borderRadius: BorderRadius.circular(4.r), boxShadow: const [BoxShadow(blurRadius: 2, color: AppColors.boxShadow)]),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          buildSizedBoxH(0),
          Image.asset(Assets.image.png.pngGim.path, height: height * 0.18),
          const Divider(thickness: 1, color: Colors.black12),
          Center(
              child: state.isLoading
                  ? const RnwLoader(color: AppColors.primaryColor)
                  : Text(state.courseModel?.data?.first.course?.name ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 12.sp, color: AppColors.textboldColor))),
          buildSizedBoxH(0)
        ]));
  }

//Student Profile image Container
  Widget _buildImageContainer(List<StudentData>? studentData) {
    return Container(
        height: 60.h,
        width: 60.w,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [BoxShadow(blurRadius: 3, color: AppColors.primaryColor.withOpacity(0.2))],
            image: DecorationImage(
                image: studentData?.first.image != null ? NetworkImage("${ApiEndPoints.studentimagebaseurl}${studentData?.first.image}") : AssetImage(Assets.image.png.pngProfilePlaceholder.path),
                fit: BoxFit.cover)));
  }

//Batch name or Status Container
  Widget buileBatchName(double height, double width) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        height: 45.h,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.sp), boxShadow: const [BoxShadow(blurRadius: 1, color: AppColors.boxShadow)]),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(flex: 1, child: _buildtitleText("#")),
          Expanded(flex: 7, child: _buildtitleText(Lang.current.lbl_course_title, textAlign: TextAlign.start)),
          Expanded(flex: 3, child: _buildtitleText(Lang.current.lbl_status, textAlign: TextAlign.center))
        ]));
  }

// Batch details Listview Builder
  // Widget _buildCorseListView(
  //     double width, double height, CourseModel? courseModel) {
  //   return ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: courseModel?.data?.length ?? 0,
  //       itemBuilder: (context, i) {
  //         return courseModel?.data?[i].admissionSubcourses?.length != null
  //             ? ListView.builder(
  //                 shrinkWrap: true,
  //                 itemCount:
  //                     courseModel!.data!.first.admissionSubcourses!.length,
  //                 itemBuilder: (context, index) {
  //                   return _buildAdmitionCourses(
  //                       height, width, index, courseModel, i);
  //                 },
  //               )
  //             : Text(Lang.current.lbl_no_data_found);
  //       });
  // }
  Widget _buildCorseListView(double width, double height, CourseDetailsModel? courseModel) {
    return courseModel?.data != null
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: courseModel?.data?.length ?? 0,
            itemBuilder: (context, index) {
              return _buildAdmitionCourses(
                height,
                width,
                index,
                courseModel,
              );
            },
          )
        : Text(Lang.current.lbl_no_data_found);
  }

// Batch Details -Photoshop Web,Corel Draw,3DS Max
//Contaire or ListView Builder Both Used
  Widget _buildAdmitionCourses(double height, double width, int index, CourseDetailsModel? courseModel) {
    return Column(children: [
      GestureDetector(
          onTap: () {
            setState(() {
              if (listVisible && (index == currentIndex)) {
                listVisible = false;
              } else {
                listVisible = true;
                currentIndex = index;
              }
            });
          },
          child: Container(
              margin: EdgeInsets.only(top: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              height: 48.h,
              decoration: BoxDecoration(
                  color: courseModel?.data?[index].subcourseStatus == "ONGOING"
                      ? Colors.amber
                      : courseModel?.data?[index].subcourseStatus == "UP_COMING"
                          ? Colors.red
                          : Colors.green,
                  borderRadius: BorderRadius.circular(4.r)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(
                  child: Row(
                    children: [
                      buildSizedboxW(8.w),
                      SizedBox(
                          width: 16.w, child: Text("${index + 1}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 12.sp, color: AppColors.whitecolor))),
                      buildSizedboxW(16.w),
                      Flexible(
                        child: Text(
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            courseModel?.data?[index].subcourse?.name ?? Lang.current.lbl_n_a,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 12.sp, color: AppColors.whitecolor)),
                      ),
                    ],
                  ),
                ),
                buildSizedboxW(26.w),
                // const Spacer(),
                Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Text(
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        courseModel?.data?[index].subcourseStatus == "ONGOING"
                            ? "Ongoing"
                            : courseModel?.data?[index].subcourseStatus == "UP_COMING"
                                ? 'Up Coming'
                                : courseModel?.data?[index].subcourseStatus == 'COMPLETED'
                                    ? 'Completed'
                                    : Lang.current.lbl_n_a,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 12.sp, color: AppColors.whitecolor))),
                Icon(listVisible && (index == currentIndex) ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, color: AppColors.whitecolor)
              ]))),
      AnimatedSize(
          duration: const Duration(milliseconds: 350),
          curve: Easing.linear,
          child: listVisible && (index == currentIndex) && courseModel?.data?[index].batch != null
              ? Container(
                  margin: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.sp), boxShadow: const [BoxShadow(blurRadius: 1, color: AppColors.boxShadow)]),
                  child: Column(children: [
                    buildSizedBoxH(8),
                    // Topics, Date ro Feedback Row
                    Row(children: [
                      buildSizedboxW(8.w),
                      SizedBox(width: 16.w, child: Text("#", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600))),
                      buildSizedboxW(13.w),
                      SizedBox(width: width * 0.26, child: Text(Lang.current.lbl_batchname, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.sp, color: AppColors.textboldColor))),
                      buildSizedboxW(13.w),
                      SizedBox(
                        width: width * 0.24,
                        child: Center(
                            child: Text(
                          Lang.current.lbl_performance,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.sp, color: AppColors.textboldColor),
                        )),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: width * 0.26,
                        child: Center(
                            child: Text(
                          Lang.current.lbl_attendances,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.sp, color: AppColors.textboldColor),
                        )),
                      ),
                      // const Spacer(),
                      // SizedBox(
                      //     width: width * 0.26,
                      //     child: Center(
                      //         child: Text(
                      //       Lang.current.lbl_feedback,
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .bodyLarge
                      //           ?.copyWith(
                      //               fontSize: 12.sp,
                      //               color: AppColors.textboldColor),
                      //     )))
                    ]),
                    buildSizedBoxH(0),
                    const Divider(thickness: 1, color: Colors.black26),

                    buildTopicsDateOrfeedback(width, courseModel, index),

                    buildSizedBoxH(8)
                  ]))
              : const SizedBox())
    ]);
  }

// date
  Widget buildTopicsDateOrfeedback(double width, CourseDetailsModel? courseModel, int index) {
    // DateTime dateTime = DateTime.parse(
    //     courseModel?.data?[index].subcourse?.createdDate.toString() ??
    //         DateTime.now().toString());
    // String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return Row(children: [
      buildSizedboxW(8.w),
      SizedBox(width: 16.w, child: Text("${1}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 10.sp, fontWeight: FontWeight.normal))),
      buildSizedboxW(13.w),
      SizedBox(
          width: width * 0.26,
          child: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              // courseModel!.data![index].courseCategory == "PACKAGE"
              //     ? courseModel.data![index].coursePackage?.name ??
              //         Lang.current.lbl_n_a
              //     : courseModel.data![index].subcourse?.name ??
              courseModel?.data?[index].batch?.name ?? Lang.current.lbl_n_a,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 10.sp, fontWeight: FontWeight.normal))),
      buildSizedboxW(13.w),
      SizedBox(
        width: width * 0.26,
        child: Center(
            child: courseModel?.data?[index].subcoursePerformance == null
                ? Text(
                    "---",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 10.sp, fontWeight: FontWeight.normal),
                  )
                : Text(courseModel?.data?[index].subcoursePerformance ?? '---', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 10.sp, fontWeight: FontWeight.normal))),
      ),
      const Spacer(),
      SizedBox(
        width: width * 0.26,
        child: Center(
            child: courseModel?.data?[index].subcourseStudentAttendance == null
                ? Text(
                    "---",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 10.sp, fontWeight: FontWeight.normal),
                  )
                : Text('${courseModel?.data?[index].subcourseStudentAttendance}%' ?? '---', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 10.sp, fontWeight: FontWeight.normal))),
      ),
      // const Spacer(),
      // SizedBox(
      //     width: width * 0.26,
      //     child: Center(
      //         child: courseModel
      //                     .data?.first.admissionSubcourses?[index].grade ==
      //                 ''
      //             ? ElevatedButton(
      //                 style: const ButtonStyle(
      //                     backgroundColor:
      //                         WidgetStatePropertyAll(AppColors.primaryColor)),
      //                 onPressed: () {},
      //                 child: Text(Lang.current.btn_submit,
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .bodyMedium
      //                         ?.copyWith(
      //                             fontSize: 12.sp,
      //                             fontWeight: FontWeight.w500,
      //                             color: AppColors.whitecolor)))
      //             : Text(
      //                 courseModel
      //                         .data!.first.admissionSubcourses![index].grade ??
      //                     "-",
      //                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      //                     fontSize: 14.sp, fontWeight: FontWeight.w500))))
    ]);
  }

//Greed View Builder
  Widget moreInformation() {
    List moreInfoScreen = [AppRoutes.rnwattendancescreen, AppRoutes.rnwsigningsheetscreen, AppRoutes.rnwfeesdetailsscreen, AppRoutes.rnwcertificatescreen, AppRoutes.rnwfeedbackscreen];

    List images = [Assets.image.icon.icAttendance.path, Assets.image.icon.icSigning.path, Assets.image.icon.icFeeDetails.path, Assets.image.icon.icCertificate.path, Assets.image.icon.icFeedback.path];
    List<String> title = [Lang.current.lbl_attendances, Lang.current.lbl_signing_sheet, Lang.current.lbl_feedetails, Lang.current.lbl_certificate, Lang.current.lbl_feedback];
    return GridView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                NavigatorService.pushNamed(moreInfoScreen[index]);
              },
              child: Container(
                  height: 50.h,
                  width: 100.w,
                  decoration: BoxDecoration(color: AppColors.whitecolor, boxShadow: const [BoxShadow(blurRadius: 1, color: AppColors.boxShadow)], borderRadius: BorderRadius.circular(4)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [
                    CustomImageView(imagePath: images[index], height: index == 1 ? 26.h : 30.h, width: index == 1 ? 26.w : 30.w, fit: BoxFit.contain),
                    Text(title[index], style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11.sp, color: AppColors.blackcolors))
                  ])));
        });
  }

  Widget _buildUserProfileDetails(String title, String details) {
    return Row(children: [
      Text("$title : ", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColors.blackcolors)),
      Expanded(
          child: Text(overflow: TextOverflow.ellipsis, details, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColors.grayColors)))
    ]);
  }

  Widget _buildtitleText(String title, {TextAlign? textAlign, int? maxLines}) {
    return Text(
        textAlign: textAlign, maxLines: maxLines, overflow: TextOverflow.ellipsis, title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13.sp, color: AppColors.textboldColor));
  }
}
