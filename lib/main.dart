import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:rnw_institue/firebase_options.dart';
import 'package:rnw_institue/utils/app_export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeFirebase();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    )
  );
  await initializeDateFormatting('en_US');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  try {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    final box = await Hive.openBox('RNW');
    runApp(RnwApp(prefs: box));
  } catch (e) {
    Logger.lOG("Hive init error: $e");
    // Fallback in case Hive fails, to prevent the app from being permanently stuck on splash screen
    runApp(MaterialApp(
        home: Scaffold(
            body: Center(child: Text("Failed to initialize app: $e")))));
  }
}

Future initializeFirebase() async {
  if (!kIsWeb) {
    await Firebase.initializeApp();
  }
}
