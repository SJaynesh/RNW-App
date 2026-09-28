import 'package:rnw_institue/utils/app_export.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({super.key});

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  void initState() {
    super.initState();
    context.read<ConnectivityBloc>().add(ConnectivityChecked());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ConnectivityBloc, ConnectivityState>(
        builder: (context, connectivityState) {
      return Center(
          child: SizedBox(
              height: 500.h,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.image.svg.svgNetworkConnection.path,
                        height: 250.h),
                    buildSizedBoxH(50),
                    Text(
                        textAlign: TextAlign.center,
                        Lang.current.lbl_please_connect,
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: "poppins",
                            fontWeight: FontWeight.w600))
                  ])));
    }));
  }
}
