import 'package:rnw_institue/utils/app_export.dart';

class NotificationPermissionPage extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onEnable;

  const NotificationPermissionPage({
    super.key,
    required this.onSkip,
    required this.onEnable,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // Top Skip Button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: onSkip,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              // Spacer for top part
              buildSizedBoxH(40),

              // Notification Icon
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_outlined,
                  size: 64,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),

              buildSizedBoxH(40),

              // Title
              Text(
                'Enable Notifications',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),

              buildSizedBoxH(16),

              // Description
              Text(
                'Stay updated with important messages and updates from our app',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              buildSizedBoxH(32),

              // Benefits List
              _buildBenefitItem(
                context,
                Icons.update,
                'Get instant updates',
              ),
              buildSizedBoxH(16),
              _buildBenefitItem(
                context,
                Icons.message_outlined,
                'Important messages',
              ),

              // Spacer to push buttons to bottom
              const Spacer(),

              RnWCustomButton(
                width: double.infinity,
                isDisabled: false,
                onPressed: () async {
                  await openAppSettings();
                  onEnable();
                  // _checkPermissionAfterReturning();
                },
                // text: 'Lang.of(context).lbl_enable',
                text: 'Enable',
              ),

              buildSizedBoxH(24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 24,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
