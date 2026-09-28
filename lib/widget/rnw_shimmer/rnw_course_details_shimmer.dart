import 'package:rnw_institue/utils/app_export.dart';

// ignore: must_be_immutable
class RnwCourseDetailsShimmer extends StatelessWidget {
  bool isCourseScreen = true;

  RnwCourseDetailsShimmer({super.key, required this.isCourseScreen});
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      buildSizedBoxH(10),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 14.h),
          child: Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade100,
              direction: ShimmerDirection.ltr,
              child: Container(
                  width: 200.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                  child: Stack(children: [
                    ListTile(
                        title: Container(
                            margin: EdgeInsets.only(right: 32.w),
                            height: 20.h,
                            width: 200.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: AppColors.greyColor)),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildSizedBoxH(5),
                              Container(
                                  height: 15.h,
                                  width: 200.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: AppColors.greyColor)),
                              buildSizedBoxH(5),
                              Container(
                                  height: 15.h,
                                  width: 200.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: AppColors.greyColor)),
                              buildSizedBoxH(5),
                              Container(
                                  height: 15.h,
                                  width: 200.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: AppColors.greyColor)),
                              buildSizedBoxH(5),
                              Container(
                                  height: 15.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: AppColors.greyColor)),
                              buildSizedBoxH(5),
                              Container(
                                  height: 15.h,
                                  width: 70.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: AppColors.greyColor))
                            ]),
                        trailing: Container(width: 50.w)),
                    Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                height: 100.h,
                                width: 100.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.greyColor))))
                  ])))),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade100,
              direction: ShimmerDirection.ltr,
              child: Container(
                  height: 138.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.whitecolor)))),
      buildSizedBoxH(8),
      isCourseScreen == true
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
              ),
              child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade100,
                  direction: ShimmerDirection.ltr,
                  child: Column(children: [
                    Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.whitecolor)),
                    buildSizedBoxH(10),
                    Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.whitecolor)),
                    buildSizedBoxH(10),
                    Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.whitecolor))
                  ])))
          : const SizedBox.shrink()
    ]);
  }
}
