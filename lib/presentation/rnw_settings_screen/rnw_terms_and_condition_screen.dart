import 'dart:io';

import 'package:rnw_institue/utils/app_export.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RnwTermAndConditionScreen extends StatefulWidget {
  const RnwTermAndConditionScreen({super.key});
  static Widget builder(BuildContext context) {
    return const RnwTermAndConditionScreen();
  }

  @override
  State<RnwTermAndConditionScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<RnwTermAndConditionScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.whitecolor)
      ..loadRequest(Uri.parse(ApiEndPoints.termsAndCondition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RNWAppBar(
            title: Text(Lang.current.lbl_terms_and_condition,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.whitecolor)),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  NavigatorService.goBack();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.whitecolor))),
        body: WebViewWidget(controller: controller));
  }
}
