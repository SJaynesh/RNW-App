import 'package:flutter_html/flutter_html.dart';
import 'package:rnw_institue/presentation/rnw_announcement_screen/model/announcement_list_model.dart';
import 'package:rnw_institue/utils/app_export.dart';

class RNWAnnouncementPreviewScreen extends StatefulWidget {
  final AnnouncementRow announcement;

  const RNWAnnouncementPreviewScreen({super.key, required this.announcement});

  static Widget builder(BuildContext context) {
    final AnnouncementRow args =
        ModalRoute.of(context)?.settings.arguments as AnnouncementRow;
    return RNWAnnouncementPreviewScreen(announcement: args);
  }

  @override
  State<RNWAnnouncementPreviewScreen> createState() =>
      _RNWAnnouncementPreviewScreenState();
}

class _RNWAnnouncementPreviewScreenState
    extends State<RNWAnnouncementPreviewScreen> {
  late String fileType;
  final GlobalKey _contentKey = GlobalKey();
  double _contentHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureContentHeight();
    });
  }

  void _measureContentHeight() {
    final RenderBox? renderBox =
        _contentKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _contentHeight = renderBox.size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RNWAppBar(
          title: Text(Lang.current.lbl_announcement),
          centerTitle: true,
          leadingWidth: 35.w,
          leading: IconButton(
              style: const ButtonStyle(
                  overlayColor: WidgetStatePropertyAll(Colors.transparent)),
              onPressed: () => NavigatorService.goBack(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.whitecolor))),
      body: BackgroundImage(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: _buildAnnouncementCard(),
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard() {
    final announcement = widget.announcement;
    final attachmentUrl = announcement.announcement?.attachment ?? '';
    final isPdf = attachmentUrl.toLowerCase().endsWith('.pdf');

    return GestureDetector(
      onTap: () {},
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26.withOpacity(0.2)),
            color: AppColors.whitecolor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 2.w,
                height: _contentHeight > 0 ? _contentHeight : 100.h,
                decoration: BoxDecoration(
                  color: AppColors.PRIMERY_COLOR,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              buildSizedboxW(10.w),
              Expanded(
                child: Container(
                  key: _contentKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        announcement.announcement?.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.BLACK,
                        ),
                      ),
                      buildSizedBoxH(10.h),
                      if (attachmentUrl.isNotEmpty) ...[
                        Center(
                          child: isPdf
                              ? _buildPdfAttachment(attachmentUrl)
                              : _buildImageAttachment(attachmentUrl),
                        ),
                        buildSizedBoxH(10.h),
                      ],
                      _buildDescription(
                          announcement.announcement?.description ?? ''),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isHtml(String text) {
    return text.contains(RegExp(r'<[a-z][\s\S]*>'));
  }

  Widget _buildDescription(String description) {
    if (description.isEmpty) return const SizedBox.shrink();

    return _isHtml(description)
        ? SizedBox(
            width: double.infinity,
            child: Html(
              data: description,
              style: {
                "body": Style(
                  fontSize: FontSize(14.0),
                  fontWeight: FontWeight.w400,
                  color: AppColors.BLACK,
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                ),
              },
            ),
          )
        : Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.BLACK,
            ),
          );
  }

  Widget _buildPdfAttachment(String url) {
    String filename = url.split('/').last;
    String displayName =
        filename.length > 20 ? '${filename.substring(0, 20)}...' : filename;

    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(url));
      },
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.picture_as_pdf, color: Colors.red, size: 24.w),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Lang.current.lbl_pdf_attachment,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  displayName,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.PRIMERY_COLOR,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageAttachment(String url) {
    return CustomImageView(
      height: 180.h,
      width: double.infinity,
      imagePath: url,
      radius: BorderRadius.circular(12.r),
      fit: BoxFit.cover,
    );
  }
}