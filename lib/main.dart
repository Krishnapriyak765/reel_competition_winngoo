import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:reels_application/config/routes/app_routes.dart';
import 'package:reels_application/core/constants/constants.dart';
import 'package:reels_application/core/services/dio_base_service.dart';

var screenwidth;
var screenHeight;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await dotenv.load(fileName: Constants.envPath); //load .env file
  // HttpOverrides.global = MyHttpOverrides();
  // // ... make network requests using Dio
  // await DioBaseService.init(); //initialize Dio service

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Flutter Framework Error: ${details.exception}');
  };

  runZonedGuarded(
    () async {
      try {
        runApp(const MyApp());
      } catch (e, stackTrace) {
        debugPrint("Error during main(): $e");
        debugPrint("Stack trace: $stackTrace");
      }
    },
    (error, stackTrace) {
      debugPrint('Uncaught zone error: $error');
      debugPrint('Zone stack trace: $stackTrace');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return
    // MaterialApp(home: Scaffold(body: Center(child: Text("It works!"))));
    MaterialApp.router(
      routerConfig: router, // Make sure router is not null or throwing
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return child ??
            const Scaffold(
              body: Center(child: Text("Something went wrong! Check logs.")),
            );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
