import 'dart:convert';
import 'package:client/pages/result_screen.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/services/predict_service.dart';
import 'package:flutter/material.dart';
import 'package:client/utils/widgets.dart';
import 'package:http/http.dart' as http;

class PredictScreen extends StatefulWidget {
  const PredictScreen({super.key});

  @override
  State<PredictScreen> createState() => _PredictScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
  String predictionResult = "No prediction yet";
  String probNonDiabetes = "";
  String probDiabetes = "";

  int pregnenciesCount = 0;
  double bloodPressure = 0;
  double glucose = 0;
  double skinThickness = 0;
  double insulin = 0;
  double bmi = 0;
  double dpf = 0;
  int age = 0;

  String pregnentText = "Pregnancies";
  String bloodText = "Blood pressure";
  String glucoseText = "Glucose level";
  String skinText = "Skin thickness";
  String insulinText = "Insulin";
  String bmiText = "BMI";
  String dpfText = "DPF";
  String ageText = "Age";

  final _auth = AuthService();

  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void onPredictButtonPressed() async {
    // Validate the input data
    if (!_validateInputs()) {
      return; // If validation fails, return early and don't call the API
    }

    try {
      // Call the API
      http.Response response = await predict(pregnenciesCount, bloodPressure,
          glucose, skinThickness, insulin, bmi, dpf, age);

      if (response.statusCode == 200) {
        // Parse the JSON response
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          predictionResult = jsonResponse['status'].toString();
          probNonDiabetes = jsonResponse['prob_non_d'].toString();
          probDiabetes = jsonResponse['prob_d'].toString();
        });
      } else {
        setState(() {
          predictionResult = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        predictionResult = "Error occurred: $e";
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          probDiabetes: probDiabetes,
          result: predictionResult,
          pregnenciesCount: pregnenciesCount,
          bloodPressure: bloodPressure,
          glucose: glucose,
          skinThickness: skinThickness,
          insulin: insulin,
          bmi: bmi,
          dpf: dpf,
          age: age,
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (pregnenciesCount < 0) {
      _showError("Pregnancy count must be a non-negative value.");
      return false;
    }
    if (bloodPressure <= 0) {
      _showError("Blood pressure must be a positive value.");
      return false;
    }
    if (glucose <= 0) {
      _showError("Glucose level must be a positive value.");
      return false;
    }
    // if (skinThickness <= 0) {
    //   _showError("Skin thickness must be a positive value.");
    //   return false;
    // }
    // if (insulin <= 0) {
    //   _showError("Insulin level must be a positive value.");
    //   return false;
    // }
    if (bmi <= 0) {
      _showError("BMI must be a positive value.");
      return false;
    }
    if (dpf <= 0) {
      _showError("DPF must be a positive value.");
      return false;
    }
    if (age <= 0) {
      _showError("Age must be a positive value.");
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.teal.shade50,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.teal,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 4.0,
            leading: const Icon(
              Icons.local_hospital_outlined,
              size: 30,
              color: Colors.white,
            ),
            title: const Text(
              "Health Checkup",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
              ),
            ),
            actions: [
              IconButton(
                onPressed: _logout,
                icon: const Icon(
                  Icons.logout,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ],
            backgroundColor: Colors.teal,
            toolbarHeight: 80,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      buildRowOneCard(context,
                          icon1: Icons.bloodtype,
                          text1: bloodText,
                          onTap1: () => _showValueDialog(
                                context,
                                "Blood pressure",
                                bloodPressure.toString(),
                                (value) {
                                  setState(() {
                                    bloodPressure = double.parse(value);
                                    bloodText = "Blood pressure: $value";
                                  });
                                },
                              )),
                      // buildCardRow(
                      //   context,
                      //   icon1: Icons.pregnant_woman,
                      //   text1: pregnentText,
                      //   onTap1: () => _showValueDialog(
                      //     context,
                      //     "Pregnancies",
                      //     pregnenciesCount.toString(),
                      //     (value) {
                      //       setState(() {
                      //         pregnenciesCount = int.parse(value);
                      //         pregnentText = "Pregnancies: $value";
                      //       });
                      //     },
                      //   ),
                      //   icon2: Icons.bloodtype,
                      //   text2: bloodText,
                      //   onTap2: () => _showValueDialog(
                      //     context,
                      //     "Blood pressure",
                      //     bloodPressure.toString(),
                      //     (value) {
                      //       setState(() {
                      //         bloodPressure = double.parse(value);
                      //         bloodText = "Blood pressure: $value";
                      //       });
                      //     },
                      //   ),
                      // ),
                      const SizedBox(height: 16),
                      buildCardRow(
                        context,
                        icon1: Icons.food_bank,
                        text1: glucoseText,
                        onTap1: () => _showValueDialog(
                          context,
                          "Glucose level",
                          glucose.toString(),
                          (value) {
                            setState(() {
                              glucose = double.parse(value);
                              glucoseText = "Glucose level: $value";
                            });
                          },
                        ),
                        icon2: Icons.man,
                        text2: skinText,
                        onTap2: () => _showValueDialog(
                          context,
                          "Skin thickness",
                          skinThickness.toString(),
                          (value) {
                            setState(() {
                              skinThickness = double.parse(value);
                              skinText = "Skin thickness: $value";
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      buildCardRow(
                        context,
                        icon1: Icons.local_hospital,
                        text1: insulinText,
                        onTap1: () => _showValueDialog(
                          context,
                          "Insulin",
                          insulin.toString(),
                          (value) {
                            setState(() {
                              insulin = double.parse(value);
                              insulinText = "Insulin: $value";
                            });
                          },
                        ),
                        icon2: Icons.space_dashboard,
                        text2: bmiText,
                        onTap2: () => _showValueDialog(
                          context,
                          "BMI",
                          bmi.toString(),
                          (value) {
                            setState(() {
                              bmi = double.parse(value);
                              bmiText = "BMI: $value";
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      buildCardRow(
                        context,
                        icon1: Icons.functions,
                        text1: dpfText,
                        onTap1: () => _showValueDialog(
                          context,
                          "DPF",
                          dpf.toString(),
                          (value) {
                            setState(() {
                              dpf = double.parse(value);
                              dpfText = "DPF: $value";
                            });
                          },
                        ),
                        icon2: Icons.numbers,
                        text2: ageText,
                        onTap2: () => _showValueDialog(
                          context,
                          "Age",
                          age.toString(),
                          (value) {
                            setState(() {
                              age = int.parse(value);
                              ageText = "Age: $value";
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    heroTag: null,
                    onPressed: onPredictButtonPressed,
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    heroTag: null,
                    child: const Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/ask');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showValueDialog(
    BuildContext context,
    String title,
    String initialValue,
    Function(String) onSelected,
  ) {
    TextEditingController controller =
        TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Enter value",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  if (controller.text.isEmpty) {
                    throw "Input cannot be empty";
                  }
                  onSelected(controller.text);
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Invalid input: $e"),
                    ),
                  );
                }
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
