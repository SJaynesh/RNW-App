import 'dart:io';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RnwFeedbackScreen extends StatefulWidget {
  final String grId;
  final String admissionId;

  const RnwFeedbackScreen({super.key, required this.grId, required this.admissionId});

  static Widget builder(BuildContext context) {
    final List args = ModalRoute.of(context)?.settings.arguments as List;
    final String grId = args[0].toString();
    final String admissionId = args[1].toString();
    return RnwFeedbackScreen(grId: grId, admissionId: admissionId);
  }

  @override
  State<RnwFeedbackScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<RnwFeedbackScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.whitecolor)
      ..loadRequest(Uri.parse(ApiEndPoints.feedback +
          ApiEndPoints.studentatGrId +
          (widget.grId) +
          ApiEndPoints.studentatAdmissionId +
          (widget.admissionId)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RNWAppBar(
            title: Text(Lang.current.lbl_feedbacks,
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
        body: WebViewWidget(controller: controller));
  }
}
