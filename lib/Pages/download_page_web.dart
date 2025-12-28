import 'dart:html' as html;
import 'package:flutter/material.dart';

class DownloadPageWeb extends StatelessWidget {
  const DownloadPageWeb({super.key});

  void _downloadApk() {
    // ✅ Direct Google Drive download link
    final apkUrl =
        'https://drive.google.com/uc?export=download&id=1C6zkY7Rz-QZin0OayMTh94BumWGh8p6h';

    final anchor = html.AnchorElement(href: apkUrl)
      ..setAttribute('download', 'mycvapp.apk')
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Download APK"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 800;

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 80,
              vertical: isMobile ? 20 : 50,
            ),
            child: isMobile
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Take a Look at My CV",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 40),
                      ),
                      Text(
                        "(Best CV btw)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff3a68f5),
                        ),
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: _downloadApk,
                        child: Text("Download APK"),
                      ),
                      SizedBox(height: 30),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/webcvimage.png",
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Take a Look at My CV",
                            style: TextStyle(fontSize: screenWidth * 0.04),
                          ),
                          Text(
                            "(Best CV btw)",
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              color: Color(0xff3a68f5),
                            ),
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: _downloadApk,
                            child: Text("Download APK"),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/webcvimage.png",
                          width: screenWidth * 0.4,
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
