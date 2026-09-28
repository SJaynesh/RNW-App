import 'package:rnw_institue/apis/repositorise/ptm_report_repository.dart';
import 'package:rnw_institue/presentation/rnw_report_screen/model/student_ptm_report_record.dart';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/utils/mixin.dart';

class RNWReportScreen extends StatefulWidget {
  final String? admissionId;
  const RNWReportScreen({super.key, this.admissionId});

  static Widget builder(BuildContext context) {
    final List args = ModalRoute.of(context)?.settings.arguments as List;
    return BlocProvider<ReportBloc>(
      create: (context) => ReportBloc(ReportilsitialEvent(),
          reportRepository: ReportRepository(apiClient: ApiClient())),
      child: RNWReportScreen(admissionId: args[1].toString()),
    );
  }

  @override
  State<RNWReportScreen> createState() => _RNWReportScreenState();
}

class _RNWReportScreenState extends State<RNWReportScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ReportBloc>()
        .add(FetchStudentReportRecordEvent(widget.admissionId ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: RNWAppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.whitecolor)),
            title: Text(Lang.current.lbl_redwhitemultimedia,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColors.whitecolor)),
            action: [
              Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: GestureDetector(
                    onTap: () {
                      NavigatorService.pushNamed(
                          AppRoutes.rnwnotificationslist);
                    },
                    child: notificationIcon(),
                  ))
            ]),
        body: BackgroundImage(
          child:
              BlocBuilder<ReportBloc, ReportState>(builder: (context, state) {
            if (state.isLoading) {
              return const AttandanceShimmer();
            } else if (state.ptmReportRecordModel == null) {
              return const Center(child: RnwExceptionScreen());
            }
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: ListView(children: [
                  buildSizedBoxH(15),
                  // Search text feald
                  buildSearchFeild(state.ptmReportRecordModel!),
                  buildSizedBoxH(25),
                  //No. of batch Or short Data
                  buildBatchOrFealter(state.ptmReportRecordModel?.data?.length),
                  // batch Data ListView Builder
                  buildTotalBatchListView(
                      height, state.ptmReportRecordModel?.data)
                ]));
          }),
        ));
  }

  //Search TextFormFeald
  Widget buildSearchFeild(StudentPtmReportRecordModel state) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.sp)),
        child: TextFormField(
            cursorColor: AppColors.blackcolor,
            maxLength: 10,
            onTap: () {},
            onChanged: (value) {
              context.read<ReportBloc>().add(SearchStudentReportEvent(value));
              print('=========${state.data!.length}');
            },
            textInputAction: TextInputAction.done,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.blackcolor, fontSize: 15.sp),
            decoration: InputDecoration(
                prefixIcon: Container(
                    padding: const EdgeInsets.all(14),
                    child: CustomImageView(
                        imagePath: Assets.image.icon.icSearch.path,
                        height: 1.h,
                        width: 1.w,
                        fit: BoxFit.contain,
                        color: AppColors.textHient)),
                counterText: "",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(0.2))),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(0.2))),
                filled: true,
                fillColor: AppColors.whitecolor,
                hintText: Lang.current.entercountryname,
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textHient, fontWeight: FontWeight.w500),
                contentPadding: EdgeInsets.only(left: 20.w))));
  }

// batch or Fealter Row
  Widget buildBatchOrFealter(int? length) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("$length BATCHS",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppColors.blackcolor, fontSize: 16.sp)),
    ]);
  }

  Widget buildTotalBatchListView(double height, List<RecordData>? data) {
    final filteredData = context.watch<ReportBloc>().state.filteredData ?? data;

    if (filteredData == null || filteredData.isEmpty) {
      return Center(
        child: Text("No data available",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.blackcolor, fontSize: 16.sp)),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        return batchContainer(height, filteredData[index], index);
      },
    );
  }

  Widget batchContainer(double height, RecordData dataList, int index) {
    return GestureDetector(
      onTap: () {
        NavigatorService.pushNamed(
          AppRoutes.rnwreportdetailsscreen,
          arguments: [
            dataList.recuringId,
            dataList.studentName,
          ],
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        padding: EdgeInsets.only(left: 10.w, top: 5.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.whitecolor,
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: const [BoxShadow(blurRadius: 1, color: Colors.black26)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dataList.studentName ?? "No Name",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp)),
            buildSizedBoxH(5),
            Text(dataList.courseName.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500, fontSize: 13.sp)),
            buildSizedBoxH(12),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        blurStyle: BlurStyle.normal,
                        color: AppColors.primaryColor.withOpacity(0.2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: CustomImageView(
                    imagePath: dataList.studentImage ??
                        Assets.image.png.pngProfilePlaceholder.path,
                    fit: BoxFit.contain,
                    height: 42.h,
                    width: 38.w,
                    radius: BorderRadius.circular(4.r),
                  ),
                ),
                buildSizedboxW(10),
                Text(dataList.facultyName ?? "No Faculty",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 13.sp))
              ],
            ),
            buildSizedBoxH(5),
          ],
        ),
      ),
    );
  }
}
