import 'package:intl/intl.dart';
import 'package:rnw_institue/presentation/rnw_fees_details_scrteen/model/fee_details_model.dart';
import 'package:rnw_institue/utils/app_export.dart';
import 'package:rnw_institue/utils/mixin.dart';

class RnwFeesDetailsScreen extends StatefulWidget {
  final String admissionID;
  const RnwFeesDetailsScreen({super.key, required this.admissionID});

  static Widget builder(BuildContext context) {
    final List args = ModalRoute.of(context)?.settings.arguments as List;
    final int index = args[1];
    return BlocProvider<FeesDetailBloc>(
        create: (context) => FeesDetailBloc(FeesDetailInitial(), HomeModuleRepository(apiClient: ApiClient())), child: RnwFeesDetailsScreen(admissionID: index.toString()));
  }

  @override
  State<RnwFeesDetailsScreen> createState() => _RnwFeesDetailsScreenState();
}

class _RnwFeesDetailsScreenState extends State<RnwFeesDetailsScreen> {
  String? date;
  List feesStatuis = ['Paid', 'Unpaid'];
  bool isStartScreen = true;
  FeeDetailsModel? feeDetailsModel;
  bool isClick = false;
  int? clickPay;

  @override
  void initState() {
    context.read<FeesDetailBloc>().add(FeesdetailsApi(admissionId: widget.admissionID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: RNWAppBar(
            leading: IconButton(onPressed: () => NavigatorService.goBack(), icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.whitecolor)),
            title: Text(Lang.current.lbl_feedetails),
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
            ]),
        body: BackgroundImage(
          child: BlocBuilder<FeesDetailBloc, FeesDetailState>(builder: (context, state) {
            if (state.isLoading) {
              return const RnwFeesDetailsShimmer();
            } else if (state.feeDetailsModel?.data == null) {
              return const Center(
                child: RnwExceptionScreen(),
              );
            }
            return state.feeDetailsModel?.data?.isEmpty ?? true
                ? const RnwExceptionScreen()
                : SingleChildScrollView(
                    child: Padding(padding: EdgeInsets.symmetric(horizontal: 14.w), child: Column(children: [buildSizedBoxH(20), feesContainer(width, state.feeDetailsModel), buildSizedBoxH(20)])));
          }),
        ));
  }

// 1 st fees Container
  Widget feesContainer(double width, FeeDetailsModel? feeDetailsModel) {
    return Center(
        child: Container(
            decoration: BoxDecoration(color: AppColors.whitecolor, borderRadius: BorderRadius.circular(4.r), boxShadow: const [BoxShadow(blurRadius: 1, color: AppColors.boxShadow)]),
            child: Column(
                children: List.generate(feeDetailsModel?.data?.length ?? 0, (index) {
              return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                buildSizedBoxH(index == 0 ? 8 : 0),
                index == 0 ? buildFeesDetails("#", Lang.current.lbl_mode, Lang.current.lbl_dueamt, Lang.current.lbl_receivedamt) : const SizedBox.shrink(),
                buildSizedBoxH(index == 0 ? 8 : 0),
                index == 0 ? const Divider(thickness: 1, color: Colors.black12, height: 1) : const SizedBox.shrink(),
                buildSizedBoxH(index == 0 ? 8 : 0),
                buildFeesDetailsModeAmt(index, Lang.current.lbl_cash, feeDetailsModel?.data?[index].dueAmount ?? '00', feeDetailsModel?.data?[index].payAmount ?? '00   '),
                buildSizedBoxH(10),
                dateOrFeesStatus(feeDetailsModel, index),
                buildSizedBoxH(0),

                //Total payable Fees Details
                grandTotalFees(width, feeDetailsModel, index),
                index != (feeDetailsModel?.data?.length ?? 0) - 1 ? Padding(padding: EdgeInsets.only(bottom: 5.h), child: const Divider(color: Colors.black12, height: 1)) : buildSizedBoxH(0)
              ]);
            }))));
  }

  // Fees Details Row
  Widget buildFeesDetails(String index, String mode, String dueAmount, String receivedamt) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(flex: 1, child: Text(index, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.sp, color: AppColors.textboldColor))),
          Expanded(flex: 3, child: Text(overflow: TextOverflow.ellipsis, mode, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.sp, color: AppColors.textboldColor))),
          Expanded(flex: 3, child: Text(dueAmount, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.sp, color: AppColors.textboldColor))),
          Expanded(flex: 3, child: Text(overflow: TextOverflow.ellipsis, receivedamt, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.sp, color: AppColors.textboldColor)))
        ]));
  }

// Date of fees Status
  Widget dateOrFeesStatus(FeeDetailsModel? feeDetailsModel, int index) {
    DateTime dateTime = DateTime.parse("${feeDetailsModel?.data?[index].installmentDate}");
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(formattedDate, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey.shade600, fontSize: 12.sp)),
          Text(
              "${feeDetailsModel?.data?[index].status == "PAID" ? "Paid" : feeDetailsModel?.data?[index].status == "CANCELLED" ? "Cancelled" : feeDetailsModel?.data?[index].status == "UNPAID" ? 'Unpaid' : feeDetailsModel?.data?[index].status == "OVERDUE" ? 'Overdue' : ''} ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: feeDetailsModel?.data?[index].status == "PAID"
                      ? Colors.green
                      : feeDetailsModel?.data?[index].status == "CANCELLED"
                          ? const Color(0xFFE17276)
                          : feeDetailsModel?.data?[index].status == "UNPAID"
                              ? Colors.amber
                              : feeDetailsModel?.data?[index].status == "OVERDUE"
                                  ? AppColors.primaryColor
                                  : const Color.fromARGB(255, 81, 72, 72),
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp))
        ]));
  }

// Total payable Fees Amount
  Widget grandTotalFees(double width, FeeDetailsModel? feeDetailsModel, int index) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(children: [
          Row(children: [
            _buildText(Lang.current.lbl_grand_total),
            _buildText(" ₹ ${feeDetailsModel?.data?[index].payAmount ?? '00'}", iscolon: false),
          ]),
          const Spacer(),
          feeDetailsModel?.data?[index].status?.isEmpty ?? true
              ? Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: MaterialButton(
                      height: 30.h,
                      color: AppColors.primaryColor,
                      onPressed: () {},
                      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      child: Text(Lang.current.btn_pay_now, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.whitecolor, fontSize: 12.sp))))
              : Padding(
                  padding: EdgeInsets.only(right: 20.w, top: 10.h, bottom: 10.h),
                  child: Align(alignment: Alignment.centerRight, child: Text("", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12.sp)))),
          buildSizedboxW(width * 0.0)
        ]));
  }

// fees mode amt due amt etc...
  Widget buildFeesDetailsModeAmt(int index, String mode, String dueAmount, String payAmount) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(flex: 1, child: Text(" ${index + 1}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 12.sp))),
          buildSizedboxW(5),
          Expanded(flex: 3, child: Text(maxLines: 1, overflow: TextOverflow.ellipsis, "---", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp))),
          buildSizedboxW(5),

          Expanded(flex: 3, child: Text(overflow: TextOverflow.ellipsis, "₹ $dueAmount", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp))),
          buildSizedboxW(5),
          Expanded(
              flex: 3,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(overflow: TextOverflow.ellipsis, "₹ $payAmount", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp))))
          // )
        ]));
  }

  Widget _buildText(String text, {bool iscolon = true}) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 12.sp),
          ),
          if (iscolon)
            TextSpan(
              text: ' :',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 14.sp),
            ),
        ],
      ),
    );
  }
}
