import 'package:flutter/material.dart';
import 'package:redawn/theme.dart';
import 'package:redawn/components/button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'contact.dart';
import 'counselling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class MoodAnalysisPage extends StatefulWidget {
  const MoodAnalysisPage({super.key});

  @override
  _MoodAnalysisPageState createState() => _MoodAnalysisPageState();
}

class _MoodAnalysisPageState extends State<MoodAnalysisPage> {
  late Future<Map<String, dynamic>> _moodDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchLatestData();
  }

  void _fetchLatestData() {
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    setState(() {
      _moodDataFuture = fetchMoodData(todayDate);
    });
  }

  Future<Map<String, dynamic>> fetchMoodData(String date) async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? "guest_user";

      DocumentReference userDoc =
          FirebaseFirestore.instance.collection("users").doc(userId);

      QuerySnapshot moodEntriesSnapshot = await userDoc
          .collection("moods")
          .doc(date)
          .collection("moodEntries")
          .get();

      if (moodEntriesSnapshot.docs.isEmpty) {
        return {"barGroups": [], "times": [], "sum": 0.0, "average": 0.0};
      }

      // Define the mapping for swapping moodIndex values
      final map = {1: 4, 2: 3, 3: 2, 4: 1};

      List<BarChartGroupData> barGroups = [];
      List<String> times = [];
      double sum = 0.0;
      int count = 0;
      int index = 0;

      for (var doc in moodEntriesSnapshot.docs) {
        int originalMoodIndex = doc["moodIndex"] as int;

        // Add 1 to the original value
        int incrementedMoodIndex = originalMoodIndex + 1;

        // Transform the incremented value using the mapping
        double transformedMoodIndex =
            (map[incrementedMoodIndex] ?? incrementedMoodIndex).toDouble();

        // Add to sum and increment count
        sum += transformedMoodIndex;
        count++;

        String time = doc["time"] as String;

        barGroups.add(
          BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: transformedMoodIndex,
                color: AppTheme.buttonColor,
              ),
            ],
            showingTooltipIndicators: [],
          ),
        );

        times.add(time); 
        index++;
      }

      double average = count > 0 ? sum / count : 0.0;

      return {
        "barGroups": barGroups,
        "times": times,
        "sum": sum,
        "average": average
      };
    } catch (e) {
      print("Error fetching mood data: $e");
      return {"barGroups": [], "times": [], "sum": 0.0, "average": 0.0};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Bar Chart with Mood Data
              FutureBuilder<Map<String, dynamic>>(
                future: _moodDataFuture,
                builder: (context, snapshot) {
                  String todayDate =
                      DateFormat('yyyy-MM-dd').format(DateTime.now());
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text("Error fetching data");
                  } else if (snapshot.data == null ||
                      snapshot.data!["barGroups"].isEmpty) {
                    return Column(
                      children: [
                        Text(
                          "Daily Record For: $todayDate",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                            "No mood data available for the selected date."),
                      ],
                    );
                  } else {
                    List<BarChartGroupData> barGroups =
                        snapshot.data!["barGroups"];
                    List<String> times = snapshot.data!["times"];
                    double sum = snapshot.data!["sum"];
                    double average = snapshot.data!["average"];

                    // Calculate the percentage
                    double percentage =
                        average / 4; // Use 4 as the maximum possible value

                    return Column(
                      children: [
                        Text(
                          "Daily Record For $todayDate",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Bar Chart Card
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            color: Colors.white, // Change background to white
                            elevation: 8, // Add shadow to the card
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: SizedBox(
                                height: 280,
                                child: BarChart(
                                  BarChartData(
                                    barGroups: barGroups,
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 40,
                                          interval: 1,
                                          getTitlesWidget: (value, meta) {
                                            switch (value.toInt()) {
                                              case 4:
                                                return const Text('Happy',
                                                    style: TextStyle(
                                                        fontSize: 10));
                                              case 3:
                                                return const Text('Relaxed',
                                                    style: TextStyle(
                                                        fontSize: 10));
                                              case 2:
                                                return const Text('Sad',
                                                    style: TextStyle(
                                                        fontSize: 10));
                                              case 1:
                                                return const Text('Angry',
                                                    style: TextStyle(
                                                        fontSize: 10));
                                              default:
                                                return const SizedBox.shrink();
                                            }
                                          },
                                        ),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 40,
                                          getTitlesWidget: (value, meta) {
                                            if (value.toInt() >= 0 &&
                                                value.toInt() < times.length) {
                                              return Text(
                                                times[value.toInt()],
                                                style: TextStyle(
                                                  color: AppTheme
                                                      .buttonColor, 
                                                  fontSize: 12,
                                                ),
                                              );
                                            }
                                            return const SizedBox.shrink();
                                          },
                                        ),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      rightTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                    ),
                                    borderData: FlBorderData(show: false),
                                    gridData: FlGridData(show: false),
                                    barTouchData: BarTouchData(enabled: false),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            color: Colors.white, 
                            elevation: 8, 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircularPercentIndicator(
                                radius: 80.0,
                                lineWidth: 10.0,
                                percent: percentage.clamp(0.0, 1.0),
                                center: Text(
                                  "${(percentage * 100).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.buttonColor,
                                  ),
                                ),
                                progressColor: Colors.green,
                                backgroundColor: Colors.grey[300]!,
                                circularStrokeCap: CircularStrokeCap.round,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    child: button(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ContactPage(),
                          ),
                        );
                      },
                      text: 'Contact',
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: button(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CounsellingPage(),
                          ),
                        );
                      },
                      text: 'Counsellor',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget createMoodAnalysisPage() {
  return const MoodAnalysisPage();
}
