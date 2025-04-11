import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../health/Consumed.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Daily Medication Reminder',
          style: TextStyle(
            color: Colors.cyan,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Date Section
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade100,
                    ),
                    padding: const EdgeInsets.all(10),
                    width: screenWidth * 0.9,
                    child: TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: DateTime.now(),
                      selectedDayPredicate: (day) {
                        return isSameDay(day, DateTime.now());
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        // เพิ่มฟังก์ชันเมื่อเลือกวัน
                        print("Selected: $selectedDay");
                      },
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.cyan,
                          shape: BoxShape.circle,
                        ),
                        outsideDaysVisible: false,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Info Card
                _buildInfoCard(
                  context,
                  title: "Calories Consumed",
                  value: "1234",
                  unit: "Cal",
                  onTap: () {
                    print("Show details tapped");
                  },
                ),
                const SizedBox(height: 20),
                // Medication Card
                _buildActionCard(
                  context,
                  title: "Vitamin C",
                  dose: "1 tablet",
                  time: "08:00 - 09:00 AM",
                  onLeftArrowTap: () {
                    print("Left arrow tapped");
                  },
                  onRightArrowTap: () {
                    print("Right arrow tapped");
                  },
                ),
              ],
            ),
          ),
        ),

    );
  }

  Widget _buildInfoCard(
      BuildContext context, {
        required String title,
        required String value,
        required String unit,
        required VoidCallback onTap,
      }) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CaloriesConsumedScreen()),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(bottom: 0.0),
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  children: [
                    TextSpan(
                      text: " $unit",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Show details",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildActionCard(
      BuildContext context, {
        required String title,
        required String dose,
        required String time,
        required VoidCallback onLeftArrowTap,
        required VoidCallback onRightArrowTap,
      }) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 20.0),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.grey),
              onPressed: onLeftArrowTap,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    dose,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right, color: Colors.grey),
              onPressed: onRightArrowTap,
            ),
          ],
        ),
      ),
    );
  }
}
