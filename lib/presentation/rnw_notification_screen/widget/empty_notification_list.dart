import 'package:rnw_institue/utils/app_export.dart';

class EmptyNotificationState extends StatelessWidget {
  const EmptyNotificationState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bell Animation Container
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: AppColors.PRIMERY_COLOR.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer Ring Animation
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.8, end: 1.2),
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.PRIMERY_COLOR.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    },
                    // Repeat animation
                    onEnd: () => (context as Element).markNeedsBuild(),
                  ),
                  // Bell Icon with bounce animation
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: -0.1, end: 0.1),
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: value,
                        child: const Icon(
                          Icons.notifications_outlined,
                          size: 55,
                          color: AppColors.PRIMERY_COLOR,
                        ),
                      );
                    },
                    // Repeat animation
                    onEnd: () => (context as Element).markNeedsBuild(),
                  ),
                ],
              ),
            ),
            buildSizedBoxH(40),
            Text(
              'No Notifications Yet!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackcolor,
                  ),
            ),
            buildSizedBoxH(16),
            Text(
              'Notifications about your activities',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.grayColors,
                    fontSize: 18.sp,
                    height: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
