import 'package:rnw_institue/utils/app_export.dart';

class RnwHelpandFeedbackScreen extends StatefulWidget {
  const RnwHelpandFeedbackScreen({super.key});
  static Widget builder(BuildContext context) {
    return const RnwHelpandFeedbackScreen();
  }

  @override
  State<RnwHelpandFeedbackScreen> createState() =>
      _RnwHelpandFeedbackScreenState();
}

class _RnwHelpandFeedbackScreenState extends State<RnwHelpandFeedbackScreen> {
  bool listVisible = false;
  int currentIndex = 0;
  List branchImage = [
    Assets.image.png.pngRW1.path,
    Assets.image.png.pngRW2.path,
    Assets.image.png.pngRW3.path,
    Assets.image.png.pngRW4.path
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RNWAppBar(
            title: Text(Lang.current.lbl_helpoandfeedback,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.whitecolor)),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  NavigatorService.goBack();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.whitecolor))),
        body: BackgroundImage(
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(children: [
                    buildSizedBoxH(15),
                    buildBranchNameContainer(),
                    corseListView(),
                    buildSizedBoxH(15)
                  ]))),
        ));
  }

  // brantch Name
  Widget buildBranchNameContainer() {
    return Container(
      height: 40.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.sp),
          boxShadow: const [BoxShadow(blurRadius: 1, color: Colors.black26)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildSizedboxW(10),
          Text("# ",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 15.sp)),
          const Spacer(),
          Text(Lang.current.lbl_branch,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 15.sp)),
          const Spacer(),
          buildSizedboxW(20),
        ],
      ),
    );
  }

// Batch details Listview Builder
  Widget corseListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return test(index);
      },
    );
  }

  Widget test(
    int index,
  ) {
    List<String> branchName = [
      Lang.current.lbl_rnw_a_k_road,
      Lang.current.lbl_rnw_yogichowk,
      Lang.current.lbl_rnw_sarthana,
      Lang.current.lbl_rnw_mota_varachha,
    ];

    return Column(
      children: [
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
            height: 40.h,
            margin: EdgeInsets.only(top: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: AppColors.whitecolor,
              borderRadius: BorderRadius.circular(4.sp),
              border: Border.all(color: AppColors.primaryColor),
            ),
            child: Row(
              children: [
                buildSizedboxW(8.w),
                SizedBox(
                    width: 16.w,
                    child: Text("${index + 1}",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 15.sp, fontWeight: FontWeight.w500))),
                buildSizedboxW(16.w),
                const Spacer(),
                SizedBox(
                    child: Text(
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  branchName[index],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                      ),
                )),
                const Spacer(),
                if (listVisible && (index == currentIndex))
                  const Icon(Icons.keyboard_arrow_up_rounded,
                      color: AppColors.primaryColor)
                else
                  const Icon(Icons.keyboard_arrow_down_rounded,
                      color: AppColors.primaryColor)
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 500),
          curve: Easing.linear,
          child: listVisible && (index == currentIndex)
              ? Container(
                  margin: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(
                    color: AppColors.whitecolor,
                    borderRadius: BorderRadius.circular(4.sp),
                    boxShadow: const [
                      BoxShadow(blurRadius: 1, color: Colors.black38)
                    ],
                  ),
                  child: Column(
                    children: [Image.asset(branchImage[index])],
                  ),
                )
              : const SizedBox.shrink(),
        )
      ],
    );
  }
}
