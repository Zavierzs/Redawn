import 'package:flutter/material.dart';
import 'package:redawn/theme.dart';
import 'package:redawn/components/button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/percent_indicator.dart'; // Import percent_indicator
import 'contact.dart';
import 'counselling.dart';

class MoodAnalysisPage extends StatelessWidget {
  const MoodAnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First Card with Bar Chart
            SizedBox(
              width: double.infinity,
              child: Card(
                color: AppTheme.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        barGroups: [
                          BarChartGroupData(
                            x: 0,
                            barRods: [
                              BarChartRodData(toY: 35, color: Colors.white)
                            ],
                          ),
                          BarChartGroupData(
                            x: 1,
                            barRods: [
                              BarChartRodData(toY: 28, color: Colors.white)
                            ],
                          ),
                          BarChartGroupData(
                            x: 2,
                            barRods: [
                              BarChartRodData(toY: 34, color: Colors.white)
                            ],
                          ),
                          BarChartGroupData(
                            x: 3,
                            barRods: [
                              BarChartRodData(toY: 32, color: Colors.white)
                            ],
                          ),
                          BarChartGroupData(
                            x: 4,
                            barRods: [
                              BarChartRodData(toY: 40, color: Colors.white)
                            ],
                          ),
                        ],
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true)),
                          bottomTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Second Card with Circular Progress Indicator
            SizedBox(
              width: double.infinity,
              child: Card(
                color: AppTheme.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularPercentIndicator(
                    radius: 80.0, // Radius of the circle
                    lineWidth: 10.0, // Thickness of the progress bar
                    percent: 0.8, // Progress percentage (e.g., 80%)
                    center: const Text(
                      "80%",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    progressColor: Colors.green, // Color of the progress bar
                    backgroundColor:
                        Colors.grey[300]!, // Background color of the circle
                    circularStrokeCap: CircularStrokeCap.round, // Rounded edges
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Buttons
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
    );
  }
}

Widget createMoodAnalysisPage() {
  return const MoodAnalysisPage();
}
