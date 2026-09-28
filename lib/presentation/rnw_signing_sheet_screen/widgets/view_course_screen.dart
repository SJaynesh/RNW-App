// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:rnw_institue/presentation/rnw_signing_sheet_screen/model/singing_model.dart';
import 'package:rnw_institue/presentation/student_info_screen/model/student_details_model.dart';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/utils/mixin.dart';

class RnwViewCoursesScreen extends StatefulWidget {
  String batchId;
  final List<StudentData> studentdetails;
  RnwViewCoursesScreen(
      {super.key, required this.batchId, required this.studentdetails});

  static Widget builder(BuildContext context) {
    final List args = ModalRoute.of(context)?.settings.arguments as List;
    final dynamic batchId = args[0];
    final List<StudentData> studentdetails = args[1];
    return BlocProvider<SigningSheetBloc>(
      create: (context) => SigningSheetBloc(
        const SigningSheetState(),
        HomeModuleRepository(apiClient: ApiClient()),
      ),
      child: RnwViewCoursesScreen(
        batchId: batchId.toString(),
        studentdetails: studentdetails,
      ),
    );
  }

  @override
  State<RnwViewCoursesScreen> createState() => _RnwViewCoursesScreenState();
}

class _RnwViewCoursesScreenState extends State<RnwViewCoursesScreen> {
  FeedbackType feedbacktype = FeedbackType.A;
  String mobileNo = '';
  bool isMatched = false;
  TextEditingController submissionLinkController = TextEditingController();

  @override
  void initState() {
    context
        .read<SigningSheetBloc>()
        .add(BatchDetailsAPIEvent(batchId: widget.batchId));

    super.initState();
    String? contactNumber = widget.studentdetails.first.contact;

    String? loginMobileNo = PrefObj.preferences?.get(PrefKeys.PHONENUMBER);
    String? fatherMobileNo =
        widget.studentdetails.first.parentMobileNo?.fatherMobileNo;
    String? motherMobileNo =
        widget.studentdetails.first.parentMobileNo?.motherMobileNo;
    isMatched = checkMobileNumberMatch(
        contactNumber, loginMobileNo, fatherMobileNo, motherMobileNo);
    log('isMatch $isMatched');
  }

  bool checkMobileNumberMatch(String? contactNumber, String? loginMobileNo,
      String? fatherMobileNo, String? motherMobileNo) {
    if (contactNumber == null) {
      return false;
    }

    if (loginMobileNo == contactNumber) {
      if (loginMobileNo == fatherMobileNo || loginMobileNo == motherMobileNo) {
        return false;
      }
      return true;
    }

    if (loginMobileNo == fatherMobileNo && loginMobileNo == motherMobileNo) {
      return false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigningSheetBloc, SigningSheetState>(
      builder: (context, state) {
        // state.batchDetailsModel?.data
        //     ?.sort((a, b) => a.id!.compareTo(b.id ?? 0));
        return Scaffold(
            appBar: _buildAppBar(),
            body: BackgroundImage(
              child: state.isLoading
                  ? const AttandanceShimmer()
                  : ShowUpTransition(
                      forward: true,
                      delay: const Duration(milliseconds: 300),
                      child: SafeArea(
                          top: false,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        width: 0.3, color: AppColors.BORDER),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildHeaderText(
                                          Lang.of(context).lbl_topics),
                                      const Spacer(flex: 4),
                                      _buildHeaderText(
                                          Lang.of(context).lbl_date),
                                      buildSizedboxW(8),
                                      // const Spacer(),
                                      _buildHeaderText(
                                          Lang.of(context).lbl_feedback),
                                    ],
                                  ),
                                ),
                                buildSizedBoxH(16),
                                Expanded(
                                    child: state.batchDetailsModel?.data != null
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: state.batchDetailsModel
                                                    ?.data?.length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              final item = state
                                                  .batchDetailsModel
                                                  ?.data?[index];
                                              return _buildCourseItem(
                                                  item, index);
                                            },
                                          )
                                        : const RnwExceptionScreen()),
                              ])))),
            ));
      },
    );
  }

  Widget _buildCourseItem(BatchData? item, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0.h),
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 0.3, color: AppColors.BORDER),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCourseHeader(item, index),
          _buildCourseDetails(item, index),
        ],
      ),
    );
  }

  Widget _buildCourseHeader(BatchData? item, int index) {
    String marks = '';
    String markSubmissionLink = '';
    int markListId = 0;

    if (item?.type == 'PROJECT' ||
        item?.type == 'VIVA' ||
        item?.type == 'EXAM_PRACTICAL' ||
        item?.type == 'EXAM_THEORY') {
      // Get marks and ID from the marks list
      final marksResult = getMarksAndId(
        item?.batchStudentMarks,
        item?.id ?? 0,
      );
      marks = marksResult['marks'] ?? '';
      markSubmissionLink = marksResult['submission_link'] != 'null'
          ? marksResult['submission_link']
          : '';
      markListId = marksResult['id'] ?? 0;
    }

    // Check if batchStudentMarks exists and has at least one element before accessing first
    final hasRemarks = item?.batchStudentMarks?.isNotEmpty == true &&
        item?.batchStudentMarks?.first.remarks != "null";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: _courseText('${index + 1}', '${index + 1}',
                    color: AppColors.BLACK),
              ),
              buildSizedboxW(8),
              Flexible(
                child: _courseText(item?.name ?? "---", '',
                    color: AppColors.BLACK),
              ),
              buildSizedboxW(8),
              if (hasRemarks)
                GestureDetector(
                    onTap: () {
                      _showRemarkDialog(
                          item?.batchStudentMarks?.first.remarks, index, item);
                    },
                    child: CustomImageView(
                        imagePath: Assets.image.icon.icRemark.path,
                        fit: BoxFit.contain,
                        height: 20.h,
                        width: 20.w)),
              buildSizedboxW(8),
            ],
          ),
        ),
        if ((item?.type == 'PROJECT') && marks.isEmpty && isMatched)
          GestureDetector(
            onTap: () {
              submissionLinkController.clear();
              if (markSubmissionLink.isNotEmpty) {
                submissionLinkController.text = markSubmissionLink;
              }
              _showSubmissionDialog(context, markListId,
                  item?.batchStudentMarks?.first.admissionId ?? 0);
            },
            child: _buildStatusContainer(
              markSubmissionLink.isEmpty ? "Submission" : "Submitted",
              Colors.red,
              isUnderline: true,
              fontSize: 11,
            ),
          ),
        _courseText(marks, '', color: AppColors.BLACK),
      ],
    );
  }

// Method to get both marks and ID
  Map<String, dynamic> getMarksAndId(
      List<BatchStudentMarks>? marksList, int batchSingingSheetId) {
    String resultMarks = '';
    String totalMarks = '';
    String mergeMark = '';
    int markListId = 0;
    String markListSubmissionLink = '';

    if (marksList != null) {
      for (var studentMark in marksList) {
        if (studentMark.batchSingingSheetId == batchSingingSheetId) {
          // double markDouble = double.parse(studentMark.marks ?? '0');
          // resultMarks = markDouble.toStringAsFixed(0);

          double markDouble = double.parse(studentMark.marks ?? '0');
          resultMarks = markDouble > 0 ? markDouble.toStringAsFixed(2) : '0';

          totalMarks = studentMark.totalMarks?.toString() ?? '';
          markListId = studentMark.id ?? 0; // Get the ID from studentMark
          markListSubmissionLink =
              studentMark.submissionLink ?? ''; // Get the submission link

          if (resultMarks != '0') {
            mergeMark = '$resultMarks/$totalMarks';
          }
          break;
        }
      }
    }

    return {
      'marks': mergeMark,
      'id': markListId,
      'submission_link': markListSubmissionLink
    };
  }

// Method to get marks only
  String getMarks(List<BatchStudentMarks>? marksList, int batchSingingSheetId) {
    String resultMarks = '';
    String totalMarks = '';
    String mergeMark = '';

    if (marksList != null) {
      for (var studentMark in marksList) {
        if (studentMark.batchSingingSheetId == batchSingingSheetId) {
          double markDouble = double.parse(studentMark.marks ?? '0');
          resultMarks = markDouble.toStringAsFixed(0);
          totalMarks = studentMark.totalMarks?.toString() ?? '';

          if (resultMarks != '0') {
            mergeMark = '$resultMarks/$totalMarks';
          }
          break;
        }
      }
    }

    return mergeMark;
  }

  Widget _buildCourseDetails(BatchData? item, int index) {
    return _buildCourseDescription(item, index);
  }

  Widget _buildCourseDescription(BatchData? item, int index) {
    return Column(
      children: List.generate(
        item?.batchSingingSheets?.length ?? 0,
        (indextitle) {
          return Container(
            padding: const EdgeInsets.all(5),
            color: indextitle % 2 == 0
                ? const Color(0xFFfef5f5)
                : const Color(0xFFfbe0e0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildDescriptionIndex(index, indextitle),
                buildSizedboxW(4),
                _buildDescriptionText(item, index, indextitle),
                buildSizedboxW(16),
                Flexible(child: _buildAttendanceItem(item, index, indextitle)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDescriptionIndex(int index, int indextitle) {
    return SizedBox(
      width: 30.w,
      child: Center(
        child: _courseText(
            '${index + 1}.${indextitle + 1}', '${index + 1}.${indextitle + 1}',
            color: Colors.black),
      ),
    );
  }

  Widget _buildDescriptionText(BatchData? item, int index, int indextitle) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.6,
      child: Column(
        children: [
          Row(
            children: [
              buildSizedboxW(6),
              Flexible(child: bulletPoints(item, indextitle, false)),
              buildSizedboxW(4),
              Column(children: [
                if (_hasLongDescription(
                    item?.batchSingingSheets?[indextitle].description ?? ''))
                  InkWell(
                    onTap: () =>
                        _showMoreDialog(context, item, index, indextitle),
                    child: Text(
                      Lang.of(context).lbl_more,
                      style: const TextStyle(
                        color: AppColors.FONT_COLOR,
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                if (item?.batchSingingSheets?[indextitle].notes != 'null')
                  InkWell(
                    onTap: () =>
                        _showNoteDialog(context, item, index, indextitle),
                    child: Text(
                      Lang.of(context).lbl_notes,
                      style: const TextStyle(
                        color: AppColors.FONT_COLOR,
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
              ])
            ],
          )
        ],
      ),
    );
  }

  bool _hasLongDescription(String description) {
    // Create a plain text version of the HTML content (without tags)
    String plainText = description
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    // Create TextPainter to check line count
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: plainText,
        style: TextStyle(fontSize: 12.sp),
      ),
      textDirection: Directionality.of(context),
      maxLines: 2,
    );

    // Set constraints similar to your container width
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width / 2.6 - 40);

    // Return true if text exceeds 2 lines
    return textPainter.didExceedMaxLines;
  }

  // bool _hasLongDescription(String description) {
  //   // Updated regex to match all cases
  //   RegExp liRegex = RegExp(
  //       r'<li>\s*(.*?)\s*</li>|<li>(.*?)\s*</li>|<li>\s*(.*?)</li>',
  //       multiLine: true);

  //   if (!liRegex.hasMatch(description)) {
  //     return false;
  //   }

  //   // Extract text from li tags using the updated regex
  //   Iterable<Match> matches = liRegex.allMatches(description);

  //   // Create TextPainter to check line count for each li item
  //   TextPainter textPainter = TextPainter(
  //     textDirection: Directionality.of(context),
  //     maxLines: 2,
  //   );

  //   for (Match match in matches) {
  //     String bulletText =
  //         match.group(1) ?? match.group(2) ?? match.group(3) ?? '';
  //     // Remove any remaining HTML tags
  //     bulletText = bulletText.replaceAll(RegExp(r'<[^>]*>'), '');

  //     textPainter.text = TextSpan(
  //       text: bulletText,
  //       style: TextStyle(fontSize: 12.sp),
  //     );

  //     // Set constraints similar to your container width
  //     textPainter.layout(
  //         maxWidth: MediaQuery.of(context).size.width / 2.6 - 40);

  //     if (textPainter.didExceedMaxLines) {
  //       return true;
  //     }
  //   }

  //   return false;
  // }

  // bool _hasNoteDescription(String description) {
  //   // Check if the description contains a note within <p> tags
  //   // More flexible regex to catch different note formats
  //   RegExp noteRegex =
  //       RegExp(r'<p>.*?(?:Note|Note:|NOTE:).*?</p>', caseSensitive: false);

  //   return noteRegex.hasMatch(description);
  // }

  void _showNoteDialog(
      BuildContext ctx, BatchData? item, int index, int indextitle) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "${index + 1} ${item?.name} - Notes",
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    color: AppColors.FONT_COLOR,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                buildSizedBoxH(16),
                // Content
                Flexible(
                    child: SingleChildScrollView(
                        child: _extractNoteFromDescription(
                            item?.batchSingingSheets?[indextitle].notes ?? '')))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _extractNoteFromDescription(String notes) {
    // Use regex to extract note from description
    // RegExp noteRegex = RegExp(r'<p>.*?(Note:|NOTE:|Note)(.+?)</p>',
    //     caseSensitive: false, multiLine: true);

    // List<Match> matches = noteRegex.allMatches(description).toList();

    // if (matches.isEmpty) {
    //   return Text('No notes found', style: TextStyle(fontSize: 12.sp));
    // }

    return _buildBulletPoint(notes, true);
  }

  void _showMoreDialog(
      BuildContext ctx, BatchData? item, int index, int indextitle) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "${index + 1} ${item?.name}",
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    color: AppColors.FONT_COLOR,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                buildSizedBoxH(16),
                // Content
                Flexible(
                    child: SingleChildScrollView(
                        child: bulletPoints(item, indextitle, true)))
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRemarkDialog(String? remarks, int index, BatchData? item) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${index + 1} ${item?.name} - ${Lang.current.lbl_remark}",
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    color: AppColors.FONT_COLOR,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                buildSizedBoxH(14),
                _buildBulletPoint(remarks ?? '', true)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bulletPoints(BatchData? item, int indexTitle, bool isdailog) {
    String description =
        item?.batchSingingSheets?[indexTitle].description ?? '';

    return _buildBulletPoint(description, isdailog);
  }

  Widget _buildBulletPoint(String point, bool isdailog) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Html(
        data: point,
        onLinkTap: (url, attributes, element) async {
          if (url != null) {
            Uri uri = Uri.parse(url);
            await launchUrl(uri, mode: LaunchMode.inAppWebView);
          }
        },
        style: {
          "html": Style(
            padding: HtmlPaddings.zero,
            margin: Margins.zero,
          ),
          "body": Style(
            padding: HtmlPaddings.zero,
            margin: Margins.zero,
            fontSize: FontSize(12),
          ),
          "div": isdailog
              ? Style(
                  padding: HtmlPaddings.zero,
                  margin: Margins.zero,
                  fontSize: FontSize(12),
                )
              : Style(
                  padding: HtmlPaddings.zero,
                  margin: Margins.zero,
                  fontSize: FontSize(12),
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
          "ol": Style(
            padding: HtmlPaddings.symmetric(horizontal: 6),
            margin: Margins.zero,
            fontSize: FontSize(12),
          ),
          "p": isdailog
              ? Style(
                  fontSize: FontSize(12),
                  color: AppColors.FONT_COLOR,
                  padding: HtmlPaddings.zero,
                  margin: Margins.zero,
                )
              : Style(
                  fontSize: FontSize(12),
                  color: AppColors.FONT_COLOR,
                  padding: HtmlPaddings.zero,
                  margin: Margins.zero,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
          "ul": Style(
            padding: HtmlPaddings.symmetric(horizontal: 4),
            margin: Margins.zero,
          ),
          "li": isdailog
              ? Style(
                  fontSize: FontSize(12),
                  color: AppColors.FONT_COLOR,
                )
              : Style(
                  fontSize: FontSize(12),
                  color: AppColors.FONT_COLOR,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
        },
      ),
    );
  }

  // Widget _buildCourseAttendance(BatchData? item, int index) {
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width / 2.5,
  //     child: item?.batchSingingSheets != null
  //         ? Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: List.generate(
  //               item?.batchSingingSheets?.length ?? 0,
  //               (indextitle) {
  //                 return _buildAttendanceItem(item, index, indextitle);
  //               },
  //             ),
  //           )
  //         : _courseText('---', '---', color: Colors.black),
  //   );
  // }

  Widget _buildAttendanceItem(BatchData? item, int index, int indextitle) {
    final attendance =
        item?.batchSingingSheets?[indextitle].batchFacultyAttendances;

    if (attendance != null && attendance.isNotEmpty) {
      List<Widget> attendanceWidgets = [];

      for (var att in attendance) {
        // Check if batchStudentAttendances exists and is not empty
        if (att.batchStudentAttendances == null ||
            att.batchStudentAttendances!.isEmpty) {
          continue; // Skip this attendance if no student data
        }

        final date = att.actualDate ?? '';
        final formattedDate = DateFormat('dd-MMM').format(DateTime.parse(date));
        final feedback = att.batchStudentAttendances!.first.feedback;

        attendanceWidgets.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 80,
                child: Center(
                  child: _courseText(formattedDate, formattedDate),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: feedback != null
                        ? Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: getCourseStatusColor(feedback),
                            ),
                            child: Center(
                              child: Text(
                                feedback,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : _isFeedbackGiven(
                            context
                                .read<SigningSheetBloc>()
                                .state
                                .batchDetailsModel,
                            index,
                            indextitle,
                            0),
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return Column(
        children: attendanceWidgets,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  // List<String> _splitDescription(String? description) {
  //   if (description == null || description.isEmpty) return ['', ''];

  //   const int maxLength = 30;
  //   if (description.length > maxLength) {
  //     return [
  //       description.substring(0, maxLength),
  //       description.substring(maxLength)
  //     ];
  //   } else {
  //     return [description, ''];
  //   }
  // }

  Widget _isFeedbackGiven(BatchDetailsModel? batchDetailsModel, int index,
      int singingSheetId, int facultyAttendanceId) {
    if (batchDetailsModel?.data == null ||
        batchDetailsModel!.data!.length <= index ||
        batchDetailsModel.data![index].batchSingingSheets == null ||
        batchDetailsModel.data![index].batchSingingSheets!.length <=
            singingSheetId ||
        batchDetailsModel.data![index].batchSingingSheets![singingSheetId]
                .batchFacultyAttendances ==
            null ||
        batchDetailsModel.data![index].batchSingingSheets![singingSheetId]
                .batchFacultyAttendances!.length <=
            facultyAttendanceId) {
      return _buildStatusContainer("-", Colors.black);
    }

    var studentSignSheet = batchDetailsModel.data?[index];
    var singingSheetData =
        studentSignSheet?.batchSingingSheets?[singingSheetId];
    var attendanceData =
        singingSheetData?.batchFacultyAttendances?[facultyAttendanceId];

    // Check if batchStudentAttendances exists and has at least one element
    if (attendanceData?.batchStudentAttendances == null ||
        attendanceData!.batchStudentAttendances!.isEmpty) {
      return _buildStatusContainer("-", Colors.black);
    }

    if (_isStudentAbsent(attendanceData)) {
      return _buildStatusContainer("Absent", Colors.black);
    } else if (_needsFeedback(studentSignSheet, attendanceData)) {
      return isMatched
          ? _buildSubmitFeedbackButton(context, attendanceData)
          : const SizedBox.shrink();
    } else if (studentSignSheet?.type != 'LECTURE') {
      return _buildStatusContainer("-", Colors.black);
    }

    return _buildStatusContainer("-", Colors.black);
  }

  bool _isStudentAbsent(BatchFacultyAttendances? attendanceData) {
    return attendanceData?.batchStudentAttendances?[0].isPresent == false;
  }

  bool _needsFeedback(
      BatchData? studentSignSheet, BatchFacultyAttendances? attendanceData) {
    return attendanceData?.batchStudentAttendances?.first.isPresent == true &&
        attendanceData?.batchStudentAttendances?.first.feedback == null &&
        studentSignSheet?.type == 'LECTURE';
  }

  Widget _buildSubmitFeedbackButton(
      BuildContext context, BatchFacultyAttendances? attendanceData) {
    return InkWell(
      onTap: () => _showFeedbackDialog(context, attendanceData),
      child: _buildStatusContainer("Submit", Colors.red, isUnderline: true),
    );
  }

  void _showFeedbackDialog(
      BuildContext context, BatchFacultyAttendances? attendanceData) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDialogHeader(),
                    SizedBox(height: 16.h),
                    ..._buildFeedbackOptions(setState),
                    SizedBox(height: 10.h),
                    _buildDialogActions(context, attendanceData),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDialogHeader() {
    return const Text(
      "Feedback",
      style: TextStyle(
        fontSize: 15,
        height: 1.4,
        color: AppColors.blackcolor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  List<Widget> _buildFeedbackOptions(void Function(void Function()) setState) {
    return FeedbackType.values.map((type) {
      String typeName = type.toString().split('.').last.capitalize();

      // Assign background colors based on feedback type
      Color backgroundColor;
      switch (type) {
        case FeedbackType.A:
          backgroundColor = Colors.green;
          break;
        case FeedbackType.B:
          backgroundColor = Colors.blue;
          break;
        case FeedbackType.C:
          backgroundColor = Colors.amber;
          break;
        case FeedbackType.D:
          backgroundColor = Colors.red;
          break;
        default:
          backgroundColor = Colors.grey;
      }

      return Container(
        decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(5.r)),
        margin: EdgeInsets.only(bottom: 8.h),
        child: RadioListTile(
          value: type,
          dense: true,
          groupValue: feedbacktype,
          contentPadding: EdgeInsets.zero,
          title: Text(
            "$typeName - ${_buildreason(typeName)}",
            style: TextStyle(fontSize: 13.sp, color: backgroundColor),
          ),
          activeColor: backgroundColor,
          onChanged: (FeedbackType? value) {
            setState(() {
              feedbacktype = value!;
            });
          },
        ),
      );
    }).toList();
  }

  String _buildreason(String input) {
    switch (input) {
      case "A":
        return Lang.of(context).lbl_a_reason;
      case "B":
        return Lang.of(context).lbl_b_reason;
      case "C":
        return Lang.of(context).lbl_c_reason;
      case "D":
        return Lang.of(context).lbl_d_reason;
      default:
        return "";
    }
  }

  Widget _buildDialogActions(
    BuildContext context,
    attendanceData,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RnwDialogButton(
          label: Lang.current.lbl_cancle,
          onPressed: () {
            NavigatorService.goBack();
          },
        ),
        RnwDialogButton(
          label: Lang.current.lbl_submit,
          onPressed: () {
            _submitFeedback(attendanceData);
            Timer(
              const Duration(milliseconds: 300),
              () => NavigatorService.goBack(),
            );
          },
        ),
      ],
    );
  }

  String? errorMessage;
  final formKey = GlobalKey<FormState>(); // Key for the form

  void _showSubmissionDialog(
      BuildContext context, int mainID, int admissionId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setStates) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enter Submission Link',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.FONT_COLOR,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Clear controller on dialog close
                              submissionLinkController.clear();
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close, color: Colors.grey),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      RnwCustomTextFormField(
                        context: context,
                        hintText: 'Enter Submission Link',
                        maxLines: 3,
                        controller: submissionLinkController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          String pattern =
                              r'^(https:\/\/)[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(:\d+)?(\/.*)?$';
                          RegExp regExp = RegExp(pattern);
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Submission Link';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Invalid URL Format';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RnwDialogButton(
                            label: Lang.current.lbl_cancle,
                            onPressed: () {
                              // Clear controller on cancel
                              submissionLinkController.clear();
                              NavigatorService.goBack();
                            },
                          ),
                          const SizedBox(width: 8),
                          RnwDialogButton(
                            label: Lang.current.lbl_submit,
                            onPressed: () => _submitLink(mainID, admissionId),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _submitLink(int mainID, int admissionId) {
    if (formKey.currentState!.validate()) {
      // Link is valid, proceed with submission
      _submitSubmission(mainID, admissionId);

      Timer(
        const Duration(milliseconds: 300),
        () => NavigatorService.goBack(),
      );
    }
  }

  void _submitSubmission(int mainID, int admissionId) {
    context.read<SigningSheetBloc>().add(
          CoursesubmissionLinkAPIEvent(
              batchId: widget.batchId,
              submissionLink: submissionLinkController.text,
              submissionId: mainID.toString(),
              admissionId: admissionId),
        );
  }

  void _submitFeedback(BatchFacultyAttendances? attendanceData) {
    context.read<SigningSheetBloc>().add(CourseFeedBackAPIEvent(
        batchId: widget.batchId,
        feedback: feedbacktype.toString().split('.').last.capitalize(),
        courseId: attendanceData!.batchStudentAttendances![0].id.toString()));
  }

  Widget _buildStatusContainer(
    String text,
    Color textColor, {
    bool isUnderline = false,
    double fontSize = 10,
  }) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        // width: 50,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontWeight: FontWeight.w900,
              decoration:
                  isUnderline ? TextDecoration.underline : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }

  Color getCourseStatusColor(String status) {
    switch (status) {
      case 'A':
        return const Color(0xff54ca68);
      case 'B':
        return const Color(0xff3abaf4);
      case 'C':
        return const Color(0xffffa426);
      case 'D':
        return const Color(0xfffc544b);
      default:
        return Colors.black;
    }
  }

  Widget _courseText(String title, String message, {Color? color}) {
    return Tooltip(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.PRIMERY_COLOR),
      message: message,
      child: Text(title,
          // maxLines: 1,
          // overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12.0.sp,
                color: color ?? AppColors.FONT_COLOR,
                letterSpacing: 0.5,
                fontWeight: FontWeight.bold,
              )),
    );
  }

  Widget _buildHeaderText(String headerName) {
    return Text(
      headerName,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontSize: 11.sp, color: AppColors.textColor),
    );
  }

  RNWAppBar _buildAppBar() {
    return RNWAppBar(
        leading: IconButton(
          onPressed: () => NavigatorService.goBack(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.whitecolor,
          ),
        ),
        title: Text(Lang.current.lbl_signing_sheet),
        centerTitle: true,
        action: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () {
                NavigatorService.pushNamed(AppRoutes.rnwnotificationslist);
              },
              child: notificationIcon(),
            ),
          ),
        ]);
  }
}

class NumberCreator {
  NumberCreator() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      //add count to stream
      _controller.sink.add(_count);
      _count++;
    });
  }
  var _count = 1;
  final _controller = StreamController<int>();

  Stream<int> get stream => _controller.stream;

  dispose() {
    _controller.close();
  }
}
