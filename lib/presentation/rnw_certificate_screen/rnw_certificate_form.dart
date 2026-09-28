import 'package:intl/intl.dart';
import 'package:rnw_institue/presentation/student_info_screen/model/student_details_model.dart';
import 'package:rnw_institue/utils/app_export.dart';

class CirtificateFormScreen extends StatefulWidget {
  final Function(int) setCurrentIndex;
  final String index;
  final List<StudentData>? studentData;
  const CirtificateFormScreen(
      {required this.setCurrentIndex,
      super.key,
      this.studentData,
      required this.index});

  static Widget builder(BuildContext context) {
    final List args = ModalRoute.of(context)?.settings.arguments as List;
    final String index = args[1];
    return BlocProvider<StudentInfoBloc>(
        create: (context) => StudentInfoBloc(const StudentInfoState(),
            HomeModuleRepository(apiClient: ApiClient()))
          ..add(StudentInfoilsitialEvent()),
        child: CirtificateFormScreen(
            setCurrentIndex: (setCurrentIndex) {
              setCurrentIndex;
            },
            studentData: args[2],
            index: index));
  }

  @override
  State<CirtificateFormScreen> createState() => _CirtificateFormScreenState();
}

class _CirtificateFormScreenState extends State<CirtificateFormScreen> {
  DateTime? selectedDate;
  DateTime? eighteenYearsAgo =
      DateTime.now().subtract(const Duration(days: 18 * 365 + 5));
  String? formattedDate;
  TextEditingController caleanderController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController enteryornameController = TextEditingController();

  TextEditingController gridController = TextEditingController();
  TextEditingController mobile = TextEditingController();

  TextEditingController courseName = TextEditingController();
  TextEditingController runningBranch = TextEditingController();
  TextEditingController cJoiningDate = TextEditingController();
  TextEditingController emailId = TextEditingController();

  @override
  void initState() {
    super.initState();
    context
        .read<StudentInfoBloc>()
        .add(GetStudentDetailsAPIEvent(admissionId: widget.index));
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  String? selectSatisfaction;
  final List<String> selectSatisfactionLevel = ['Student', 'Parent'];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentInfoBloc, StudentInfoState>(
        builder: (context, state) {
      if (state.isLoad && !state.isLoad && state.studentdetailsModel != null) {
        enteryornameController = TextEditingController(
            text:
                "${state.studentdetailsModel?.data?.first.firstName} ${state.studentdetailsModel?.data?.first.middleName} ${state.studentdetailsModel?.data?.first.lastName}");
        gridController = TextEditingController(
            text: state.studentdetailsModel?.data!.first.grId.toString() ?? '');
        mobile = TextEditingController(
            text: state.studentdetailsModel?.data?.first.contact ??
                Lang.current.lbl_ent_your_num);
        courseName = TextEditingController(
            text: state.studentdetailsModel?.data?.first.courseType
                    ?.toLowerCase() ??
                Lang.current.lbl_enter_corse_name);
        runningBranch = TextEditingController(
            text: state.studentdetailsModel?.data?.first.branchName ??
                Lang.current.lbl_enter_running_branch);
        // emailId = TextEditingController(
        //     text: state.studentdetailsModel?.data?.first.email ??
        //         Lang.current.lbl_enter_e_mail_id);
        // final DateTime? startDate = state.studentdetailsModel?.data?.first
        //             .sta !=
        //         null
        //     ? DateTime.parse(state.studentdetailsModel!.data!.first
        //         .admissionSubcourses!.first.batch!.startDate!)
        //     : null;
        // formattedDate =
        //     startDate != null ? DateFormat('dd/MM/yyyy').format(startDate) : '';

        context.read<StudentInfoBloc>().add(GetStudentDetailsFatched());
      }
      return SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              child: Column(children: [buildFormFeild(state)])));
    });
  }

  Widget buildFormFeild(StudentInfoState state) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextFiledTitle(Lang.current.lbl_name),
          buildSizedBoxH(3),
          RnwCustomTextFormField(
            context: context,
            hintText: Lang.current.lbl_enter_yor_name,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: enteryornameController,
          ),
          buildSizedBoxH(20),
          Row(children: [
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _buildTextFiledTitle(Lang.current.lbl_gr_id),
                  buildSizedBoxH(3),
                  RnwCustomTextFormField(
                    context: context,
                    hintText: Lang.current.lbl_enter_gr_id,
                    controller: gridController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                  )
                ])),
            buildSizedboxW(15),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _buildTextFiledTitle(Lang.current.lbl_mobile_no),
                  buildSizedBoxH(3),
                  RnwCustomTextFormField(
                    context: context,
                    hintText: Lang.current.lbl_ent_your_num,
                    controller: mobile,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                  )
                ]))
          ]),
          buildSizedBoxH(20),
          _buildTextFiledTitle(Lang.current.lbl_course_name),
          buildSizedBoxH(3),
          RnwCustomTextFormField(
            context: context,
            hintText: Lang.current.lbl_enter_corse_name,
            controller: courseName,
            textInputAction: TextInputAction.next,
          ),
          buildSizedBoxH(20),
          Row(children: [
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _buildTextFiledTitle(Lang.current.lbl_running_branch),
                  buildSizedBoxH(3),
                  RnwCustomTextFormField(
                    context: context,
                    hintText: Lang.current.lbl_enter_running_branch,
                    controller: runningBranch,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  )
                ])),
            buildSizedboxW(15),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _buildTextFiledTitle(Lang.current.lbl_course_joining_date),
                  buildSizedBoxH(3),
                  RnwCustomTextFormField(
                    readOnly: true,
                    context: context,
                    onTap: () async {
                      selectedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                          helpText: 'Calendar',
                          cancelText: Lang.current.lbl_cancle,
                          confirmText: "Confirm",
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                                data: ThemeData.light().copyWith(
                                    colorScheme: const ColorScheme.light(
                                        primary: AppColors.primaryColor,
                                        onPrimary: Colors.white,
                                        onSurface: Colors.black),
                                    textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                            textStyle:
                                                TextStyle(fontSize: 15.sp),
                                            foregroundColor:
                                                AppColors.textboldColor))),
                                child: child!);
                          });
                      if (selectedDate != null) {
                        setState(() {
                          selectedDate = selectedDate;
                        });
                        formattedDate = selectedDate != null
                            ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                            : '';
                      }
                    },
                    hintText: Lang.current.lbl_enter_collection_date,
                    controller: TextEditingController(text: formattedDate),
                    textInputAction: TextInputAction.none,
                    textInputType: TextInputType.none,
                    suffix: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: CustomImageView(
                            imagePath: Assets.image.icon.icCalender.path,
                            fit: BoxFit.contain,
                            height: 1.h,
                            width: 1.w,
                            color: AppColors.blackcolor)),
                  )
                ]))
          ]),
          buildSizedBoxH(20),
          _buildTextFiledTitle(Lang.current.lbl_e_mail_com),
          buildSizedBoxH(3),
          RnwCustomTextFormField(
            context: context,
            hintText: Lang.current.lbl_enter_e_mail_id,
            controller: emailId,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
          ),
          buildSizedBoxH(20),
          _buildTextFiledTitle(Lang.current.lbl_statisfaction),
          buildSizedBoxH(3),
          Container(
              height: 45.h,
              decoration: BoxDecoration(
                  color: AppColors.whitecolor,
                  borderRadius: BorderRadius.circular(4.r),
                  border:
                      Border.all(color: AppColors.blackcolor.withOpacity(0.2))),
              child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                          value: selectSatisfaction,
                          hint: Text(Lang.current.lbl_choose,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.blackcolor.withOpacity(0.7),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal)),
                          items: selectSatisfactionLevel
                              .map((String statisfaction) =>
                                  DropdownMenuItem<String>(
                                      value: statisfaction,
                                      child: Text(statisfaction,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: AppColors.textColor,
                                                  fontSize: 15.sp,
                                                  fontWeight:
                                                      FontWeight.w500))))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectSatisfaction = value;
                            });
                          },
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: AppColors.grayColors,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal),
                          dropdownStyleData: DropdownStyleData(
                              scrollbarTheme: ScrollbarThemeData(
                                radius: Radius.circular(40.r),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility:
                                    MaterialStateProperty.all(true),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 4.w),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4))),
                          isExpanded: true)))),
          buildSizedBoxH(20),
          //Submit Button
          Center(
              child: RnWCustomButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              widget.setCurrentIndex(2);
            },
            text: Lang.current.btn_submit,
          ))
        ]);
  }

  Widget _buildTextFiledTitle(String textfieldlable) {
    return Text(textfieldlable,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColors.grayColors, fontSize: 13.sp));
  }
}
