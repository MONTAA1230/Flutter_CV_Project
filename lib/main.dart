import 'package:cv_app/Pages/LoginPage.dart';
import 'package:cv_app/Pages/Update.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Config/config.dart';

import 'firebase_options.dart';

// Conditional import: Web only
import 'Pages/download_page_stub.dart'
    if (dart.library.html) 'Pages/download_page_web.dart'
    as webPage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: kIsWeb ? webPage.DownloadPageWeb() : Update(),
        );
      },
    );
  }
}

