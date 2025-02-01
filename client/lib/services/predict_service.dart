import 'package:http/http.dart' as http;

Future<http.Response> predict(
    int pregnentCount,
    double bloodPressure,
    double glucose,
    double skinThickness,
    double insulin,
    double bmi,
    double dpf,
    int age) {
  return http.get(Uri.parse(
      'http://10.0.2.2:5000/predict?pregnancies=5&glucose=${glucose}&blood_pressure=${bloodPressure}&skin_thickness=${skinThickness}&insulin=${insulin}&bmi=${bmi}&dpf=${dpf}&age=${age}'));
}
