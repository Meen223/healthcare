import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthcare/providers/food_record_provider.dart';
import 'package:healthcare/screens/health/FoodRecord.dart';
import 'package:healthcare/providers/auth_provider.dart';

class CaloriesConsumedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.cyan),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Calories Consumed Today',
          style: TextStyle(
            color: Colors.cyan,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer2<AuthProvider, FoodRecordProvider>(
        builder: (context, authProvider, foodRecordProvider, child) {
          final userId = authProvider.token; // เปลี่ยนเพื่อใช้ token ตรวจสอบการล็อกอิน

          if (userId == null) {
            return const Center(
              child: Text(
                'User not logged in. Please log in first.',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          }

          if (foodRecordProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (foodRecordProvider.records.isEmpty) {
            return const Center(
              child: Text(
                'No food records found.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          double totalCalories = foodRecordProvider.records
              .fold(0, (sum, item) => sum + (item['calories'] as double));

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Calories:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${totalCalories.toStringAsFixed(2)} Cal',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: foodRecordProvider.records.length,
                  itemBuilder: (context, index) {
                    final food = foodRecordProvider.records[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        title: Text(
                          food['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          food['time'],
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: Text(
                          '${food['calories']} Cal',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FoodRecordScreen()),
          );
        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}
