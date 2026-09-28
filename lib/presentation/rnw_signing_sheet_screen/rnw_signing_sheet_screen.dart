import 'package:rnw_institue/presentation/student_info_screen/model/student_details_model.dart';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/utils/mixin.dart';

class RNWSigningSheetScreen extends StatefulWidget {
  final String admissionId;
  final List<StudentData> studentdetails;

  const RNWSigningSheetScreen(
      {super.key, required this.admissionId, required this.studentdetails});

  static Widget builder(BuildContext context) {
    final List args = ModalRoute.of(context)?.settings.arguments as List;
    final dynamic admissionID = args[1];
    final List<StudentData> studentdetails = args[2];
    return BlocProvider<SigningSheetBloc>(
      create: (context) => SigningSheetBloc(
        const SigningSheetState(),
        HomeModuleRepository(apiClient: ApiClient()),
      ),
      child: RNWSigningSheetScreen(
        admissionId: admissionID.toString(),
        studentdetails: studentdetails,
      ),
    );
  }

  @override
  State<RNWSigningSheetScreen> createState() => _RNWSigningSheetScreenState();
}

class _RNWSigningSheetScreenState extends State<RNWSigningSheetScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context
        .read<SigningSheetBloc>()
        .add(BatchAPIEvent(batchId: widget.admissionId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BackgroundImage(
        child: BlocBuilder<SigningSheetBloc, SigningSheetState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const AttandanceShimmer();
            } else if (state.batchesModel?.data == null) {
              return const Center(child: RnwExceptionScreen());
            }
            return _buildContent(state);
          },
        ),
      ),
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

  Widget _buildContent(SigningSheetState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            rnWBannerImage(),
            buildSizedBoxH(16.0),
            _buildHeader(),
            _buildBatchDetails(state),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 0.3, color: AppColors.greyColor),
      ),
      child: Row(
        children: [
          buildSizedBoxH(15),
          Expanded(
            flex: 1,
            child: _buildHeaderText(Lang.current.lbl_hastag),
          ),
          Expanded(
            flex: 5,
            child: _buildHeaderText(Lang.current.lbl_batchname),
          ),
          Expanded(
            child: Center(child: _buildHeaderText(Lang.current.lbl_statuse)),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderText(String headerName) {
    return Text(
      headerName,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontSize: 12.sp, color: AppColors.textColor),
    );
  }

  Widget _buildBatchDetails(SigningSheetState state) {
    final batchData = state.batchesModel?.data;

    if (batchData == null || batchData.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      itemCount: batchData.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemBuilder: (context, index) {
        return SigningSheetTile(
            number: index + 1,
            sheet: batchData[index],
            index: index,
            studentdetails: widget.studentdetails);
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 0.2,
          color: AppColors.grayColors,
        );
      },
    );
  }
}
