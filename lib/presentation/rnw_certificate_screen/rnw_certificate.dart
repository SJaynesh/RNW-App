import 'package:intl/intl.dart';
import 'package:rnw_institue/utils/app_export.dart';

class CertificateScreen extends StatefulWidget {
  final Function(int) setCurrentIndex;
  const CertificateScreen({required this.setCurrentIndex, super.key});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  String? selectSatisfaction;
  TextEditingController centerController = TextEditingController();
  TextEditingController collectionController = TextEditingController();
  TextEditingController collectiopntimeController = TextEditingController();

  DateTime? selectedDate;
  DateTime? eighteenYearsAgo =
      DateTime.now().subtract(const Duration(days: 18 * 365 + 5));

  String formattedDate = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [buildCertificateScreenFormFEild()])));
  }

// build Cerificate Center name Form Feild
  Widget buildCertificateScreenFormFEild() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextFiledTitle(Lang.current.lbl_center_name),
          buildSizedBoxH(3),
          RnwCustomTextFormField(
            context: context,
            hintText: Lang.current.lbl_enter_center_name,
            controller: centerController,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.text,
          ),
          buildSizedBoxH(20),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFiledTitle(Lang.current.lbl_collection_branch),
                buildSizedBoxH(3),
                RnwCustomTextFormField(
                  context: context,
                  fillColor: AppColors.whitecolor,
                  filled: true,
                  hintText: Lang.current.lbl_collection_branch,
                  controller: collectionController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                )
              ]),
          buildSizedBoxH(15),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFiledTitle(Lang.current.lbl_collection_date),
                buildSizedBoxH(3),
                RnwCustomTextFormField(
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
                                    onSurface: Colors.black,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                          textStyle: TextStyle(fontSize: 15.sp),
                                          foregroundColor:
                                              AppColors.textboldColor))),
                              child: child!);
                        });
                    if (selectedDate != null) {
                      formattedDate =
                          DateFormat('dd/mm/yyyy').format(selectedDate!);
                      selectedDate = selectedDate;
                      setState(() {});
                    }
                  },
                  hintText: Lang.current.lbl_enter_collection_date,
                  suffix: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: CustomImageView(
                          imagePath: Assets.image.icon.icCalender.path,
                          fit: BoxFit.contain,
                          height: 1.h,
                          width: 1.w,
                          color: AppColors.blackcolor)),
                  controller: TextEditingController(text: formattedDate),
                  textInputAction: TextInputAction.none,
                  textInputType: TextInputType.none,
                )
              ]),
          buildSizedBoxH(20),
          _buildTextFiledTitle(Lang.current.lbl_collection_time),
          buildSizedBoxH(3),
          RnwCustomTextFormField(
            context: context,
            hintText: Lang.current.lbl_enter_collection_time,
            controller: collectiopntimeController,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.datetime,
          ),
          buildSizedBoxH(20),
          Center(
              child: RnWCustomButton(
            text: Lang.current.btn_submit,
            onPressed: () {
              FocusScope.of(context).unfocus();
              widget.setCurrentIndex(3);
            },
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
