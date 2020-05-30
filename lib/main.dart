import 'package:AlgoliaFirestore/core/records_repository.dart';
import 'package:AlgoliaFirestore/services/remote_db/remote_db_adapter.dart';
import 'package:AlgoliaFirestore/services/remote_db/srvc_remote_db.dart';
import 'package:AlgoliaFirestore/services/services_manager.dart';
import 'package:AlgoliaFirestore/views/records/screen_records.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:AlgoliaFirestore/services/router.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Router.createRoutes();
  final getIt = GetIt.instance;
  getIt.registerSingleton<SrvcRemoteDb>(SrvcRemoteDb());
  getIt.registerSingleton<RecordsRepository>(RecordsRepository(remoteDb: RemoteDbAdapter()));
  getIt.registerSingleton<ServicesManager>(ServicesManager());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MaterialApp(
      title: 'AlgoliaFirestore',
      navigatorKey: Router.sailor.navigatorKey,
      onGenerateRoute: Router.sailor.generator(),
      home: ScreenRecords(),
      theme: ThemeData(
        textTheme: TextTheme(
          headline1:
              GoogleFonts.manrope(fontSize: 95, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          headline2:
              GoogleFonts.manrope(fontSize: 59, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          headline3: GoogleFonts.manrope(fontSize: 48, fontWeight: FontWeight.w400),
          headline4:
              GoogleFonts.manrope(fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headline5: GoogleFonts.manrope(fontSize: 24, fontWeight: FontWeight.w400),
          headline6:
              GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          subtitle1:
              GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          subtitle2:
              GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyText2:
              GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          bodyText1:
              GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          button:
              GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          caption:
              GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          overline:
              GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        ),
      ),
    ),
  );
}
