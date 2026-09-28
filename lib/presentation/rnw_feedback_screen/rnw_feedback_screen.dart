import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/utils/mixin.dart';

class RNWFeedbackScreen extends StatefulWidget {
  const RNWFeedbackScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<FeedbackBloc>(
        create: (context) => FeedbackBloc(FeedbackInitials(), HomeModuleRepository(apiClient: ApiClient()))..add(FeedbackInitialEvent()), child: const RNWFeedbackScreen());
  }

  @override
  State<RNWFeedbackScreen> createState() => _RNWFeedbackScreenState();
}

class _RNWFeedbackScreenState extends State<RNWFeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedFeedbackSubject;
  final List<String> feedbackSubject = ['Student', 'Other'];

  String? selectedFeedbacktype;
  final List<String> feedbackType = ['Positive Feedback', 'Negative Feedback'];
  String selectedRole = 'STUDENT';

  final TextEditingController remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColors.bgcolor,
        appBar: RNWAppBar(
            leading: IconButton(onPressed: () => NavigatorService.goBack(), icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white)),
            title: Text(Lang.current.lbl_feedback),
            centerTitle: true,
            action: [
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: GestureDetector(
                    onTap: () {
                      NavigatorService.pushNamed(AppRoutes.rnwnotificationslist);
                    },
                    child: notificationIcon()),
              ),
            ]),
        body: BackgroundImage(
          child: BlocConsumer<FeedbackBloc, FeedbackState>(listener: (context, state) {
            if (state.isLoading) {
            } else if (state is FeedbackSuccess) {
              // showToast('Feedback submitted successfully!');
              Future.delayed(const Duration(seconds: 2), () {
                NavigatorService.goBack();
              });
            }
          }, builder: (BuildContext context, FeedbackState state) {
            return Form(
                key: _formKey,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ListView(children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        buildSizedBoxH(16),
                        buildFeedbackSubject(),
                        buildSizedBoxH(16),
                        buildFeedbackType(),
                        buildSizedBoxH(16),
                        buildRemark(height),
                        buildSizedBoxH(10),
                        buildRadioButton(),
                        buildSizedBoxH(16),
                        buildFeedbackSubmit(width, state),
                        buildSizedBoxH(16)
                      ])
                    ])));
          }),
        ));
  }

  //Feedback DropDown button

  Widget buildFeedbackSubject() {
    return Container(
        height: 45.h,
        decoration: BoxDecoration(color: AppColors.whitecolor, borderRadius: BorderRadius.circular(4.r), boxShadow: const [BoxShadow(blurRadius: 1, color: Colors.black26)]),
        child: Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                    value: selectedFeedbackSubject,
                    hint: Text(Lang.current.lbl_subject, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade400, fontSize: 15.sp, fontWeight: FontWeight.normal)),
                    items: feedbackSubject
                        .map((String feedback) => DropdownMenuItem<String>(
                            value: feedback, child: Text(feedback, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColor, fontSize: 15.sp, fontWeight: FontWeight.w500))))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedFeedbackSubject = value;
                      });
                    },
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColor, fontSize: 15.sp, fontWeight: FontWeight.normal),
                    iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.blackcolor)),
                    dropdownStyleData: DropdownStyleData(
                        scrollbarTheme: ScrollbarThemeData(
                          radius: Radius.circular(40.r),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility: MaterialStateProperty.all(true),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 4.w),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4))),
                    isExpanded: true))));
  }

  //feedback type
  Widget buildFeedbackType() {
    return Container(
        height: 45.h,
        decoration: BoxDecoration(color: AppColors.whitecolor, borderRadius: BorderRadius.circular(4.r), boxShadow: const [BoxShadow(blurRadius: 1, color: Colors.black26)]),
        child: Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                    value: selectedFeedbacktype,
                    hint: Text(Lang.current.lbl_type, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade400, fontSize: 15.sp, fontWeight: FontWeight.normal)),
                    items: feedbackType
                        .map((String feedbackType) => DropdownMenuItem<String>(
                            value: feedbackType,
                            child: Text(feedbackType, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColor, fontSize: 15.sp, fontWeight: FontWeight.w500))))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedFeedbacktype = value;
                      });
                    },
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColor, fontSize: 15.sp, fontWeight: FontWeight.normal),
                    iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.blackcolor)),
                    dropdownStyleData: DropdownStyleData(
                        scrollbarTheme: ScrollbarThemeData(
                          radius: Radius.circular(40.r),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility: MaterialStateProperty.all(true),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 4.w),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r))),
                    isExpanded: true))));
  }

//remark Container
  Widget buildRemark(double height) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(Lang.current.lbl_remark, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 12.sp, color: AppColors.textColor)),
      buildSizedBoxH(5),
      TextFormField(
          maxLines: 5,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColor, fontSize: 15.sp, fontWeight: FontWeight.normal),
          validator: FormValidators.validateFeedback,
          controller: remarkController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.sp),
              filled: true,
              fillColor: AppColors.whitecolor,
              hintText: Lang.current.msg_typeyourremark,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade400),
              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
              border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black12))))
    ]);
  }

  // Radio button for Parents or Student feedback
  Widget buildRadioButton() {
    return Row(children: [
      Row(children: [
        Radio<String>(
            value: 'PARENTS',
            activeColor: AppColors.primaryColor,
            fillColor: const WidgetStatePropertyAll(AppColors.primaryColor),
            groupValue: selectedRole,
            onChanged: (String? value) {
              setState(() {
                selectedRole = value!;
              });
            }),
        Text(Lang.current.lbl_parents, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500, fontSize: 15.sp, color: AppColors.textColor))
      ]),
      Row(children: [
        Radio<String>(
            activeColor: AppColors.primaryColor,
            fillColor: const WidgetStatePropertyAll(AppColors.primaryColor),
            value: 'STUDENT',
            groupValue: selectedRole,
            onChanged: (String? value) {
              setState(() {
                selectedRole = value!;
              });
            }),
        Text(Lang.current.lbl_student, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500, fontSize: 15.sp, color: AppColors.textColor))
      ])
    ]);
  }

// Matireal Button
  Widget buildFeedbackSubmit(double width, FeedbackState state) {
    return Center(
        child: RnWCustomButton(
      buttonStyle: ButtonStyle(
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          backgroundColor: const WidgetStatePropertyAll(AppColors.primaryColor),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)))),
      onPressed: () {
        //TODO: FIX CONDITION
        FocusScope.of(context).unfocus();

        if (_formKey.currentState!.validate()) {
          if (selectedFeedbackSubject == null || selectedFeedbacktype == null) {
            selectedFeedbackSubject == null
                ? selectedFeedbackSubject == null && selectedFeedbacktype == null
                    ? showToast('Please select Subject and feedbak type before submitting.')
                    : showToast('Please select Subject before submitting.')
                : showToast('Please select Feedback Type before submitting.');
          } else {
            context
                .read<FeedbackBloc>()
                .add(SubmitFeedbackEvent(subject: selectedFeedbackSubject?.toUpperCase() ?? "", type: selectedFeedbacktype ?? "", remarks: remarkController.text, feedbackType: selectedRole));
          }
        }
      },
      text: Lang.current.lbl_submit,
      isLoading: state.isLoading,
      isDisabled: state.isLoading,
    ));
  }
}
