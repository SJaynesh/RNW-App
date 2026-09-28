import 'package:rnw_institue/presentation/student_info_screen/model/student_details_model.dart';
import 'package:rnw_institue/utils/app_export.dart';

class RnwCertificateScreen extends StatefulWidget {
  final String addmissionID;
  final List<StudentData>? studentData;
  const RnwCertificateScreen(
      {super.key, required this.addmissionID, this.studentData});

  static Widget builder(BuildContext context) {
    final List args = ModalRoute.of(context)?.settings.arguments as List;
    final int index = args[1];
    return BlocProvider<StudentInfoBloc>(
      create: (context) => StudentInfoBloc(const StudentInfoState(),
          HomeModuleRepository(apiClient: ApiClient()))
        ..add(StudentInfoilsitialEvent()),
      child: RnwCertificateScreen(
          addmissionID: index.toString(), studentData: args[2]),
    );
  }

  @override
  State<RnwCertificateScreen> createState() => _RnwCertificateScreenState();
}

class _RnwCertificateScreenState extends State<RnwCertificateScreen> {
  int currentIndex = 0;
  bool isLoading = false;
  void setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RNWAppBar(
            title: Text(Lang.current.lbl_certificate,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.whitecolor)),
            centerTitle: true,
            leading: IconButton(
                onPressed: () => NavigatorService.goBack(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.whitecolor))),
        body: BlocBuilder<StudentInfoBloc, StudentInfoState>(
            builder: (context, state) {
          return Stack(children: [
            IndexedStack(index: currentIndex, children: [
              buildGetCertificate(),
              CirtificateFormScreen(
                  setCurrentIndex: setCurrentIndex,
                  index: widget.addmissionID,
                  studentData: widget.studentData),
              CertificateScreen(setCurrentIndex: setCurrentIndex),
              const CongratulationsCertificateScreen()
            ])
          ]);
        }));
  }

//Get Certificate UI
  Widget buildGetCertificate() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageView(
              imagePath: Assets.image.png.pngCertificate1.path,
              fit: BoxFit.contain,
              height: 200.h,
              width: 200.w,
              alignment: Alignment.center),
          buildSizedBoxH(20),
          RnWCustomButton(
              isLoading: isLoading == true,
              isDisabled: isLoading == true,
              onPressed: () {
                FocusScope.of(context).unfocus();
                buildGetCertificateDialog(context);
              },
              buttonStyle: ButtonStyle(
                  backgroundColor:
                      const WidgetStatePropertyAll(AppColors.primaryColor),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r)))),
              text: Lang.current.btn_get_certificate)
        ]);
  }

//Dialog Not Eligible for certificate
  void buildGetCertificateDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return _buildDailog();
        });
  }

  Widget _buildDailog() {
    return Dialog(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 10.h),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        CustomImageView(
            imagePath: Assets.image.png.pngCertificate3.path,
            fit: BoxFit.contain,
            alignment: Alignment.center,
            height: 130.h,
            width: 130.w),
        buildSizedBoxH(12),
        Text(Lang.current.lbl_not_eligible_certificate,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp)),
        buildSizedBoxH(10),
        Text(
          textAlign: TextAlign.center,
          Lang.current.lbl_certificate_department,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.grayColors,
              fontSize: 12.sp),
        ),
        buildSizedBoxH(10),
        TextButton(
            autofocus: false,
            onPressed: () async {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
              setCurrentIndex(1);
            },
            child: Text(Lang.current.btn_contact_now,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: AppColors.primaryColor)))
      ]),
    ));
  }
}
