import 'package:cv_app/Config/config.dart';
import 'package:cv_app/Tools/FirebaseHelper.dart';
import 'package:flutter/material.dart';

class CvPage extends StatefulWidget {
  const CvPage({super.key});

  @override
  State<CvPage> createState() => _CvPageState();
}

class _CvPageState extends State<CvPage> {
  Map<String, dynamic>? cvDataList;

  Future<void> _loadCvData() async {
    cvDataList = await FirebaseCustomService().getAllFromDoc(
      "users",
      "montassarbenhariz90@gmail.com",
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadCvData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: screenWidth(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              Image.asset("assets/myphoto.png", width: 300),
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
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Text(
                      "Profil",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode == true ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: screenWidth(context) * 0.85,
                height: screenHeight(context) * 0.2,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cvDataList?["description"] ?? '',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Education",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode == true ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ...((cvDataList?['education'] ?? [])
                  .map(
                    (e) => buildEducationBox(
                      e['year'],
                      e['place'],
                      e['diploma'],
                      context,
                    ),
                  )
                  .toList()),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Formation",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode == true ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...((cvDataList?['formation'] ?? [])
                        .map(
                          (e) => buildFormationBox(
                            int.parse(e['color']),
                            e['platform'],
                            e['title'],
                            e['year'],
                          ),
                        )
                        .toList()),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Expérience",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode == true ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...((cvDataList?['experience'] ?? [])
                        .map(
                          (e) => buildExperienceBox(
                            e['role'],
                            e['domain'],
                            e['period'],
                          ),
                        )
                        .toList()),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Compétences",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode == true ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth(context) * 0.9,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...((cvDataList?['competence'] ?? [])
                            .map(
                              (e) => buildCompetenceBox(
                                e['name'],
                                e['image'],
                                Color(int.parse(e['color'])),
                              ),
                            )
                            .toList()),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Compétences Linguistique",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode == true ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth(context) * 0.8,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cvDataList?['langue'][0]["name"] ?? " ",
                            style: TextStyle(
                              fontSize: 20,
                              color: isDarkMode == true
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          Text(
                            cvDataList?['langue'][0]["level"] ?? " ",
                            style: TextStyle(
                              fontSize: 20,
                              color: isDarkMode == true
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cvDataList?['langue'][1]["name"] ?? " ",
                            style: TextStyle(
                              fontSize: 20,
                              color: isDarkMode == true
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          Text(
                            cvDataList?['langue'][1]["level"] ?? " ",
                            style: TextStyle(
                              fontSize: 20,
                              color: isDarkMode == true
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cvDataList?['langue'][2]["name"] ?? " ",
                            style: TextStyle(
                              fontSize: 20,
                              color: isDarkMode == true
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          Text(
                            cvDataList?['langue'][2]["level"] ?? " ",
                            style: TextStyle(
                              fontSize: 20,
                              color: isDarkMode == true
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              Container(
                width: screenWidth(context) * 0.8,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SizedBox(height: 25),
                      InformationsText("Adresse"),
                      SizedBox(height: 5),
                      InformationsText(cvDataList?['adresse'] ?? " "),
                      SizedBox(height: 25),
                      InformationsText("Phone"),
                      SizedBox(height: 5),
                      InformationsText(cvDataList?['phone'] ?? " "),
                      SizedBox(height: 25),
                      InformationsText("Email"),
                      SizedBox(height: 5),
                      InformationsText(cvDataList?['email'] ?? " "),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildEducationBox(String year, String place, String diploma, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: screenWidth(context) * 0.8,
      height: screenHeight(context) * 0.15,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(year, style: TextStyle(color: Colors.white)),
                Text(place, style: TextStyle(color: Colors.white)),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.school, size: 30, color: Colors.black),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(diploma, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ),
  );
}

Widget buildFormationBox(
  int coleur,
  String platform,
  String title,
  String year,
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 200,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(coleur),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(year, style: TextStyle(color: Colors.white)),
          Text(platform, style: TextStyle(color: Colors.white)),
          Container(
            height: 60,
            width: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildExperienceBox(String role, String domain, String period) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 250,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffFF6347), // Couleur rouge-orange
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(Icons.work, size: 30, color: Color(0xffFF6347)),
          ),
          SizedBox(height: 10),
          Text(
            role,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(domain, style: TextStyle(color: Colors.white, fontSize: 14)),
          SizedBox(height: 5),
          Text(period, style: TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    ),
  );
}

Widget buildCompetenceBox(String name, String image, Color couleur) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 100,
      height: 110,
      decoration: BoxDecoration(
        color: couleur,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Image.asset(image, width: 50, height: 60),
          SizedBox(height: 5),
          Text(name, style: TextStyle(fontSize: 18, color: Colors.black)),
        ],
      ),
    ),
  );
}

Widget InformationsText(String name) {
  return Text(
    name,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 20,
    ),
  );
}
