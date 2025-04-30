import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reels_application/config/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Flutter Framework Error: ${details.exception}');
  };

  runZonedGuarded(
    () async {
      try {
        // Initialize Stripe
        // Stripe.publishableKey =
        //     "your_publishable_key"; // Replace with actual key
        // await Stripe.instance.applySettings();

        // Run the app
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
