import 'package:cv_app/Config/config.dart';
import 'package:cv_app/Pages/CvPage.dart';
import 'package:cv_app/Pages/LoginPage.dart';
import 'package:cv_app/Tools/FirebaseHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool selectedThemeLight = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CvPage()),
                );
              },
              child: Image.asset("assets/myphoto.png", width: 300),
            ),
            Text(
              " Montassar Ben Hariz ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              "Spiele",
              style: TextStyle(
                fontSize: 20,
                color: isDarkMode == true ? Colors.white : Colors.black,
              ),
            ),

            ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder: (_, currentMode, __) {
                return IconButton(
                  icon: Icon(
                    currentMode == ThemeMode.dark
                        ? Icons.wb_sunny
                        : Icons.nightlight_round,
                  ),
                  onPressed: () {
                    // Toggle the global theme
                    themeNotifier.value = currentMode == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
                  },
                );
              },
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  FirebaseCustomService().addDataToFirebase();
                },
                child: Text(
                  "Add to Firebase",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                },
                child: Text("Log out", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
