import 'package:rnw_institue/presentation/rnw_notification_screen/bloc/notification_bloc.dart';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/utils/mixin.dart';

ValueNotifier<int> unreadCountNotifier = ValueNotifier<int>(0);

class RNWHomeScreen extends StatefulWidget {
  const RNWHomeScreen({super.key});

  static Widget builder(BuildContext context) {
    return const RNWHomeScreen();
  }

  @override
  State<RNWHomeScreen> createState() => _RNWHomeScreenState();
}

class _RNWHomeScreenState extends State<RNWHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(GetNotificationListAPIEvent());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: RNWAppBar(
          title: Text(Lang.current.lbl_redwhitemultimedia,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.whitecolor)),
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
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const AttandanceShimmer();
            } else if (state.studentListModel == null) {
              return const Center(child: RnwExceptionScreen());
            }
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.0),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        studentInfoContainer(width, state.studentListModel)
                      ],
                    ),
                  ],
                ));
          },
        ),
      ),
    );
  }

  Widget studentInfoContainer(
      double width, StudentListModel? studentListModel) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: studentListModel?.data?.length,
        itemBuilder: (context, index) {
          var studentData = studentListModel?.data?[index];
          return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                NavigatorService.pushNamed(AppRoutes.studentinfoscreen,
                    arguments: [studentData.id ?? 0]);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Container(
                    padding: EdgeInsets.all(8.0.w),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.black26.withOpacity(0.2)),
                      color: AppColors.whitecolor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildstudentInfoColumn(studentData, index),
                          buildstudentProfileImage(studentData!)
                        ])),
              ));
        });
  }

// Student Information Column  -[Name, GR. IG. ,Course Name]
  Widget buildstudentInfoColumn(Data? studentData, int index) {
    PrefObj.preferences?.put(PrefKeys.STDNAME,
        "${studentData?.firstName ?? Lang.current.lbl_n_a} ${studentData?.middleName ?? Lang.current.lbl_n_a} ${studentData?.lastName ?? Lang.current.lbl_n_a}");
    PrefObj.preferences?.put(PrefKeys.GRID, studentData?.grId);
    // PrefObj.preferences
    //     ?.put(PrefKeys.ORGANIZATIONCOAE, "${studentData?.package?.code}");
    return Flexible(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildText(
              Lang.current.lbl_name,
              "${studentData?.firstName ?? Lang.current.lbl_n_a} ${studentData?.middleName ?? Lang.current.lbl_n_a} ${studentData?.lastName ?? Lang.current.lbl_n_a}",
            ),
            _buildText(
              Lang.current.lbl_grid,
              "${studentData?.grId ?? Lang.current.lbl_n_a}",
            ),
            _buildText(
              Lang.current.lbl_course,
              studentData?.courseCategory == "PACKAGE"
                  ? studentData?.package?.name ?? Lang.current.lbl_n_a
                  : studentData?.subcourse
                          ?.map((subcourse) => subcourse.subcourse?.name)
                          .join(", ") ??
                      Lang.current.lbl_n_a,
            ),
            _buildText(
              Lang.current.lbl_branch_code,
              studentData?.branchCode ?? Lang.current.lbl_n_a,
            ),
          ]),
    );
  }

// Student Profile Image Container
  Widget buildstudentProfileImage(Data? admissionDocuments) {
    PrefObj.preferences?.put(PrefKeys.PHOTO, "${admissionDocuments?.image}");
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 3, color: AppColors.primaryColor.withOpacity(0.2))
        ]),
        child: CustomImageView(
            height: 65.h,
            width: 65.w,
            imagePath: admissionDocuments?.image != null
                ? "${ApiEndPoints.studentimagebaseurl}${admissionDocuments?.image}"
                : Assets.image.png.pngProfilePlaceholder.path,
            fit: BoxFit.cover,
            radius: BorderRadius.circular(4.r)));
  }

  Widget _buildText(String title, String subTitle) {
    return Row(children: [
      Text("$title : ",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.blackcolors)),
      Flexible(
        child: Text(subTitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 13.sp, color: AppColors.grayColors)),
      )
    ]);
  }
}
