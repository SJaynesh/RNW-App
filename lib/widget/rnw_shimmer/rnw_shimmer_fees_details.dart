import 'package:rnw_institue/utils/app_export.dart';

class RnwFeesDetailsShimmer extends StatelessWidget {
  const RnwFeesDetailsShimmer({super.key});

  Widget _buildShimmerContainer({
    required double height,
    double? width,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: AppColors.greyColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade100,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: _buildShimmerContainer(
                      height: 35.0,
                      borderRadius: BorderRadius.circular(4.sp),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: _buildShimmerContainer(
                                height: 20.0,
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                            ),
                            buildSizedboxW(8),
                            Expanded(
                              flex: 1,
                              child: _buildShimmerContainer(
                                height: 20.0,
                                borderRadius: BorderRadius.circular(4.sp),
                              ),
                            ),
                          ],
                        ),
                        buildSizedBoxH(8),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: _buildShimmerContainer(
                                height: 20.0,
                                borderRadius: BorderRadius.circular(4.sp),
                              ),
                            ),
                            buildSizedboxW(8),
                            Expanded(
                              flex: 1,
                              child: _buildShimmerContainer(
                                height: 20.0,
                                borderRadius: BorderRadius.circular(4.sp),
                              ),
                            ),
                            buildSizedboxW(8),
                            Expanded(
                              flex: 1,
                              child: _buildShimmerContainer(
                                height: 20.0,
                                borderRadius: BorderRadius.circular(4.sp),
                              ),
                            ),
                          ],
                        ),
                        buildSizedBoxH(8),
                        _buildShimmerContainer(
                          height: 20.0,
                          width: 150.0,
                        ),
                        buildSizedBoxH(8),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: _buildShimmerContainer(
                                height: 30.0,
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                            ),
                            buildSizedboxW(8),
                            Expanded(
                              flex: 1,
                              child: _buildShimmerContainer(
                                height: 30.0,
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                            ),
                          ],
                        ),
                        buildSizedBoxH(10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
