import 'package:cv_app/Config/config.dart';
import 'package:cv_app/Tools/FirebaseHelper.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

final TextEditingController _adresseController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _UpdateState extends State<Update> {
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
        height: screenHeight(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Container(
                width: screenWidth(context) * 0.85,
                height: screenHeight(context) * 0.2,
                decoration: BoxDecoration(color: Colors.white),

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        cvDataList?["adresse"] ?? '',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _adresseController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF9195FF),
                              labelText: "Adresse",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is empty!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print(_adresseController.text.trim());
                                  FirebaseCustomService().updateData(
                                    "users",
                                    "montassarbenhariz90@gmail.com",
                                    {"adresse": _adresseController.text.trim()},
                                  );
                                }
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
