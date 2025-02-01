import 'package:client/utils/widgets.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.result,
    required this.pregnenciesCount,
    required this.bloodPressure,
    required this.glucose,
    required this.skinThickness,
    required this.insulin,
    required this.bmi,
    required this.dpf,
    required this.age,
    required this.probDiabetes,
  });

  final String result;
  final String probDiabetes;
  final int pregnenciesCount;
  final double bloodPressure;
  final double glucose;
  final double skinThickness;
  final double insulin;
  final double bmi;
  final double dpf;
  final int age;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final List<String> highBloodPressureTips = [];
  final List<String> lowBloodPressureTips = [];
  final List<String> highGlucoseTips = [];
  final List<String> lowGlucoseTips = [];
  final List<String> highInsulinTips = [];
  final List<String> lowInsulinTips = [];
  final List<String> underweightTips = [];
  final List<String> overweightTips = [];
  final List<String> normalweightTips = [];
  final List<String> obesityTips = [];

  void setTips() {
    highBloodPressureTips.addAll([
      "Limit salt intake to less than 2,300 mg per day.",
      "Increase potassium-rich foods like bananas, oranges, spinach, and sweet potatoes.",
      "Avoid processed foods and reduce alcohol consumption.",
      "Engage in regular aerobic exercise (e.g., walking, swimming, or cycling).",
      "Manage stress through mindfulness or yoga.",
      "Consult a doctor for potential antihypertensive medications."
    ]);

    lowBloodPressureTips.addAll([
      "Increase fluid intake and avoid dehydration.",
      "Consume small, frequent meals and include more salt (under medical supervision).",
      "Include foods like olives, pickles, and broth-based soups for sodium.",
      "Avoid sudden position changes to prevent dizziness.",
      "Consider compression stockings if symptoms persist.",
      "Discuss with a healthcare provider if symptoms are severe."
    ]);

    highGlucoseTips.addAll([
      "Avoid sugary and processed foods; focus on whole grains, legumes, and lean proteins.",
      "Include low-glycemic-index foods such as lentils, chickpeas, and green leafy vegetables.",
      "Maintain regular physical activity to improve insulin sensitivity.",
      "Limit carbohydrates to about 45-60% of daily caloric intake.",
      "Schedule regular blood sugar monitoring and discuss medication if necessary."
    ]);

    lowGlucoseTips.addAll([
      "Carry quick sources of sugar like glucose tablets or fruit juice.",
      "Eat small, frequent meals with balanced carbohydrates and proteins.",
      "Avoid skipping meals or prolonged fasting.",
      "Monitor blood sugar levels regularly, especially after meals or exercise.",
      "Consult a doctor if episodes are frequent to adjust treatment or medications."
    ]);

    highInsulinTips.addAll([
      "Reduce intake of refined carbohydrates and sugary foods.",
      "Incorporate more fiber-rich foods like vegetables, fruits, and whole grains.",
      "Exercise regularly to improve insulin sensitivity.",
      "Monitor insulin levels under medical supervision.",
      "Consult a healthcare provider for possible medication adjustments."
    ]);

    lowInsulinTips.addAll([
      "Consume balanced meals with adequate carbohydrates and proteins.",
      "Avoid skipping meals and maintain a regular eating schedule.",
      "Include healthy fats like avocados, nuts, and olive oil.",
      "Discuss with a doctor for insulin therapy or other treatments if necessary.",
      "Monitor blood sugar levels frequently to avoid hypoglycemia."
    ]);

    underweightTips.addAll([
      "Increase calorie intake with nutrient-dense foods like nuts, seeds, avocados, and dairy.",
      "Eat frequent meals and healthy snacks.",
      "Incorporate strength training exercises to build muscle mass.",
      "Consult a healthcare provider or dietitian for a personalized plan."
    ]);

    overweightTips.addAll([
      "Focus on a calorie-controlled diet with an emphasis on whole foods.",
      "Incorporate 30 minutes of moderate-intensity exercise daily.",
      "Avoid sugary and processed foods.",
      "Monitor weight regularly and set achievable goals."
    ]);

    normalweightTips.addAll([
      "Maintain a balanced diet with adequate nutrients.",
      "Engage in regular physical activity.",
      "Schedule annual health check-ups to monitor overall well-being."
    ]);

    obesityTips.addAll([
      "Seek a structured weight-loss program under medical supervision.",
      "Adopt a balanced diet focusing on vegetables, lean proteins, and whole grains.",
      "Engage in low-impact physical activities like swimming or walking.",
      "Consider behavioral therapy for sustainable lifestyle changes.",
      "Consult a doctor for potential medical or surgical interventions if necessary."
    ]);
  }

  @override
  void initState() {
    super.initState();
    setTips();
  }

  void showTips(BuildContext context, List<String> tips) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Health Tips"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tips.map((tip) => Text("- $tip")).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 4.0,
          title: const Text(
            "Your health status",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
                color: Colors.white),
          ),
          backgroundColor: Colors.teal,
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 5,
                        color: widget.result.toLowerCase() == "1"
                            ? Colors.red[100]
                            : Colors.teal[100],
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                widget.result.toLowerCase() == "1"
                                    ? "You are diabetic with a probability of ${double.parse(widget.probDiabetes).toStringAsFixed(2)}%. Please consult a doctor for further advice."
                                    : "You are healthy. Keep maintaining your lifestyle!",
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/ask');
                          },
                          child: Text("Need more assistant?")),
                    ),
                    const SizedBox(height: 20),
                    buildTitle(context, "Health Tips"),
                    ...buildHealthTipCards(context)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildHealthTipCards(BuildContext context) {
    final List<Map<String, dynamic>> cardData = [];

    final healthyRanges = {
      'Blood Pressure': [90, 120],
      'Glucose': [70, 140],
      'Insulin': [2, 25],
      'BMI': [18.5, 24.9],
    };

    if (widget.bloodPressure < healthyRanges['Blood Pressure']![0]) {
      cardData.add({
        'icon': Icons.local_hospital,
        'text': "Low Blood Pressure",
        'onTap': () => showTips(context, lowBloodPressureTips),
      });
    } else if (widget.bloodPressure > healthyRanges['Blood Pressure']![1]) {
      cardData.add({
        'icon': Icons.local_hospital,
        'text': "High Blood Pressure",
        'onTap': () => showTips(context, highBloodPressureTips),
      });
    }

    if (widget.glucose < healthyRanges['Glucose']![0]) {
      cardData.add({
        'icon': Icons.bloodtype,
        'text': "Low Glucose",
        'onTap': () => showTips(context, lowGlucoseTips),
      });
    } else if (widget.glucose > healthyRanges['Glucose']![1]) {
      cardData.add({
        'icon': Icons.bloodtype,
        'text': "High Glucose",
        'onTap': () => showTips(context, highGlucoseTips),
      });
    }

    if (widget.insulin < healthyRanges['Insulin']![0]) {
      cardData.add({
        'icon': Icons.medical_services,
        'text': "Low Insulin",
        'onTap': () => showTips(context, lowInsulinTips),
      });
    } else if (widget.insulin > healthyRanges['Insulin']![1]) {
      cardData.add({
        'icon': Icons.medical_services,
        'text': "High Insulin",
        'onTap': () => showTips(context, highInsulinTips),
      });
    }

    if (widget.bmi < healthyRanges['BMI']![0]) {
      cardData.add({
        'icon': Icons.fitness_center,
        'text': "Underweight",
        'onTap': () => showTips(context, underweightTips),
      });
    } else if (widget.bmi > healthyRanges['BMI']![1]) {
      cardData.add({
        'icon': Icons.fitness_center,
        'text': "Overweight",
        'onTap': () => showTips(context, overweightTips),
      });
    }

    final List<Widget> rows = [];
    for (int i = 0; i < cardData.length; i++) {
      rows.add(buildRowOneCard(
        context,
        icon1: cardData[i]['icon'],
        text1: cardData[i]['text'],
        onTap1: cardData[i]['onTap'],
      ));
    }

    return rows;
  }
}
