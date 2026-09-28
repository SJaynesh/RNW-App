// import 'package:rnw_institue/presentation/student_info_screen/model/student_details_model.dart';
// import 'package:rnw_institue/utils/app_export.dart';

// class RnwCourseScreen extends StatefulWidget {
//   final List<StudentData>? studentData;
//   final String addmissionID;

//   const RnwCourseScreen(
//       {super.key, required this.addmissionID, this.studentData});

//   static Widget builder(BuildContext context) {
//     final List args = ModalRoute.of(context)?.settings.arguments as List;
//     final int index = args[1];
//     return BlocProvider<CourseBloc>(
//         create: (context) => CourseBloc(
//             const CourseState(), CourseRepository(apiClient: ApiClient())),
//         child: RnwCourseScreen(
//           addmissionID: index.toString(),
//           studentData: args[2],
//         ));
//   }

//   @override
//   State<RnwCourseScreen> createState() => _RnwCourseScreenState();
// }

// class _RnwCourseScreenState extends State<RnwCourseScreen> {
//   PageController pageController = PageController();
//   int currentIndex = 0;
//   bool isStartScreen = true;
//   @override
//   void initState() {
//     context
//         .read<CourseBloc>()
//         .add(GetCourseAPIEvent(addmissionID: widget.addmissionID));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;

//     return Scaffold(
//         appBar: RNWAppBar(
//             leading: IconButton(
//                 onPressed: () => NavigatorService.goBack(),
//                 icon:
//                     const Icon(Icons.arrow_back_ios_new, color: Colors.white)),
//             title: Text(Lang.current.lbl_courses),
//             centerTitle: true),
//         body: BackgroundImage(
//           child:
//               BlocBuilder<CourseBloc, CourseState>(builder: (context, state) {
//             return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 14.w),
//                 child: Column(children: [
//                   buildSizedBoxH(15),
//                   rnWBannerImage(),
//                   buildSizedBoxH(40),
//                   _buildCourseContainer(height, state)
//                 ]));
//           }),
//         ));
//   }

//   //Course Container
//   Widget _buildCourseContainer(double height, CourseState state) {
//     return GestureDetector(
//         onTap: () {
//           NavigatorService.pushNamed(AppRoutes.rnwCourseDetailsscreen,
//               arguments: [state.courseModel?.data?.first, widget.studentData]);
//         },
//         child: Container(
//             height: height * 0.28,
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 color: AppColors.whitecolor,
//                 borderRadius: BorderRadius.circular(4.r),
//                 boxShadow: const [
//                   BoxShadow(blurRadius: 1, color: AppColors.borderColor)
//                 ]),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   buildSizedBoxH(0),
//                   Image.asset(Assets.image.png.pngGim.path,
//                       height: height * 0.18),
//                   const Divider(thickness: 1, color: Colors.black12),
//                   Center(
//                       child: state.isLoading
//                           ? const RnwLoader(color: AppColors.primaryColor)
//                           : Text('${state.courseModel?.data?.first.name}',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyMedium
//                                   ?.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 12.sp,
//                                       color: AppColors.textboldColor))),
//                   buildSizedBoxH(0)
//                 ])));
//   }
// }
