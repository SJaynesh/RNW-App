import 'package:rnw_institue/utils/app_export.dart';

class RNWAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool? centerTitle;
  final bool? automaticallyImplyLeading;
  final Widget? leading;
  final List<Widget>? action;
  final Widget? flexibleSpace;
  final double? leadingWidth;
  final double? titleSpacing;

  const RNWAppBar(
      {super.key,
      this.title,
      this.centerTitle,
      this.automaticallyImplyLeading,
      this.leading,
      this.action,
      this.flexibleSpace,
      this.leadingWidth,
      this.titleSpacing});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.primaryColor,
        surfaceTintColor: Colors.transparent,
        leading: leading,
        titleSpacing: titleSpacing,
        title: title,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.whitecolor),
        flexibleSpace: flexibleSpace,
        centerTitle: centerTitle,
        actions: action,
        leadingWidth: leadingWidth,
        automaticallyImplyLeading: automaticallyImplyLeading ?? false);
  }
}
