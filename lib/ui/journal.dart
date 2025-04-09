import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'journalDetailed.dart';
import 'package:redawn/theme.dart';

class MoodCalendar extends StatefulWidget {
  @override
  _MoodCalendarState createState() => _MoodCalendarState();
}

class _MoodCalendarState extends State<MoodCalendar> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    int daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    int firstWeekday = DateTime(currentDate.year, currentDate.month, 1).weekday;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mood Calendar',
          style: TextStyle(
            color: Colors
                .white, 
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.buttonColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header with month and year, and navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      currentDate =
                          DateTime(currentDate.year, currentDate.month - 1);
                    });
                  },
                ),
                Expanded(
                  // Instead of Flexible
                  child: Center(
                    child: Text(
                      DateFormat('MMMM yyyy').format(currentDate),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.buttonColor, 
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      currentDate =
                          DateTime(currentDate.year, currentDate.month + 1);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 500, 
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, // 7 columns for days of the week
                  childAspectRatio: 0.8, // Make cells square
                ),
                itemCount: daysInMonth + firstWeekday,
                itemBuilder: (context, index) {
                  if (index < firstWeekday) {
                    return Container(); // Empty cells for days before the first day of the month
                  }
                  int day = index - firstWeekday + 1;
                  bool isBeforeApril9 = currentDate.month < 4 ||
                      (currentDate.month == 4 && day <= 8);

                  return GestureDetector(
                    onTap: () {
                      if (!isBeforeApril9) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JournalDetailed(
                              selectedDate: DateTime(
                                currentDate.year,
                                currentDate.month,
                                day,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.teal.shade300),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$day',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isBeforeApril9 ? _getEmojiForDay(day) : '+',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getEmojiForDay(int day) {
    const emojis = ['😊', '😢', '😡', '😂', '😌'];
    return emojis[(day - 1) % emojis.length];
  }
}
