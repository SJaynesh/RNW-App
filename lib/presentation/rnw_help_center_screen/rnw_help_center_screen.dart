import 'package:rnw_institue/presentation/rnw_help_center_screen/model/help_center_item.dart';
import 'package:rnw_institue/utils/app_export.dart';

class RNWHelpCenterScreen extends StatefulWidget {
  final String branchid;
  const RNWHelpCenterScreen({super.key, required this.branchid});

  static Widget builder(BuildContext context) {
    final List args = ModalRoute.of(context)?.settings.arguments as List;
    return BlocProvider<StudentInfoBloc>(
        create: (context) => StudentInfoBloc(const StudentInfoState(), HomeModuleRepository(apiClient: ApiClient())),
        child: RNWHelpCenterScreen(branchid: args[3].toString()));
  }

  @override
  State<RNWHelpCenterScreen> createState() => _RNWHelpCenterScreenState();
}

class _RNWHelpCenterScreenState extends State<RNWHelpCenterScreen> {
  @override
  void initState() {
    context.read<StudentInfoBloc>().add(HelpcenterAPIEvent(branchid: widget.branchid));
    Logger.lOG(widget.branchid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> helpcenterimages = [
      Assets.image.svg.svgInfo.path,
      Assets.image.svg.svgAdmissionFee.path,
      Assets.image.svg.svgStudyAttendence.path,
      Assets.image.svg.svgClgRelated.path,
      Assets.image.svg.svgStudyAbroad.path,
      Assets.image.svg.svgCertificated.path,
      Assets.image.svg.svgJobRelated.path,
    ];

    return Scaffold(
      appBar: RNWAppBar(
          title: Text(Lang.current.lbl_help_center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600, color: AppColors.whitecolor)),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                NavigatorService.goBack();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.whitecolor))),
      body: BlocBuilder<StudentInfoBloc, StudentInfoState>(
        builder: (context, state) {
          final List<HelpCenterItem> helpItems = (state.helpcenterModel?.data ?? [])
              .map<HelpCenterItem>((item) => HelpCenterItem(
                    title: item.title ?? "NA",
                    phoneNumber: item.phoneNumber ?? "NA",
                    icon: helpcenterimages[item.id! - 1],
                  ))
              .toList();
          return state.helpcenterModel?.data != null
              ? ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: helpItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0.h),
                      child: Container(
                          padding: EdgeInsets.all(8.0.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26.withOpacity(0.2)),
                            color: AppColors.whitecolor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: InkWell(
                            onTap: () async {
                              var phoneUri = Uri.parse("tel:${helpItems[index].phoneNumber}");
                              await launchUrl(phoneUri);
                            },
                            child: Row(children: [
                              _buildhelpcentericon(helpItems[index].icon),
                              buildSizedboxW(8),
                              _buildcontactusText(helpItems[index].title, helpItems[index].phoneNumber)
                            ]),
                          )),
                    );
                  },
                )
              : Center(
                  child: Text(Lang.current.lbl_no_data_found,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp,
                          )),
                );
        },
      ),
    );
  }

  Widget _buildhelpcentericon(String imagepath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: AppColors.grayBoxColor, borderRadius: BorderRadius.circular(8.0.r)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: CustomImageView(
            imagePath: imagepath,
            height: 30.h,
          ),
        ),
      ),
    );
  }

  Widget _buildcontactusText(String title, String phoneNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                )),
        buildSizedBoxH(5),
        Text(phoneNumber,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14.sp, color: AppColors.graytextColor)),
      ],
    );
  }
}
