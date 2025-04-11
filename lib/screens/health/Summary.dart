import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SummaryGraphScreen extends StatefulWidget {
  @override
  _SummaryGraphScreenState createState() => _SummaryGraphScreenState();
}

class _SummaryGraphScreenState extends State<SummaryGraphScreen> {
  // State สำหรับ Period และ Type
  String _selectedPeriod = 'Weekly';
  String _selectedType = 'Cal.';

  // ตัวอย่างข้อมูลสำหรับกราฟ
  final List<ChartData> _chartData = [
    ChartData('Mon', 50),
    ChartData('Tue', 70),
    ChartData('Wed', 40),
    ChartData('Thu', 80),
    ChartData('Fri', 60),
    ChartData('Sat', 90),
    ChartData('Sun', 100),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Summary Graph',
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              // กราฟ Summary
              SizedBox(
                height: 200,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <LineSeries<ChartData, String>>[
                    LineSeries<ChartData, String>(
                      dataSource: _chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      color: Colors.cyan,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showSettingsModal(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                ),
                child: const Text(
                  'Open Settings',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              // สรุปข้อมูล Average / Max / Min
              _buildSummaryBox(
                'Average',
                '3 meal', '01/04/2024',
                '1.1 KCal', '02/04/2024',
                '2.5 L', '03/04/2024',
              ),
              const SizedBox(height: 10),
              _buildSummaryBox(
                'Max',
                '6 meal', '05/04/2024',
                '1.67 KCal', '05/04/2024',
                '3.0 L', '05/04/2024',
              ),
              const SizedBox(height: 10),
              _buildSummaryBox(
                'Min',
                '2 meal', '02/04/2024',
                '937 Cal', '02/04/2024',
                '1.8 L', '02/04/2024',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryBox(
      String title,
      String mealValue, String mealDate,
      String kcalValue, String kcalDate,
      String waterValue, String waterDate) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                mealValue,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
              Text(
                mealDate,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.cyan,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kcalValue,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
              Text(
                kcalDate,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.cyan,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                waterValue,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
              Text(
                waterDate,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.cyan,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSettingsModal(BuildContext context) {
    String tempSelectedPeriod = _selectedPeriod; // ตัวแปรชั่วคราวสำหรับ Period
    String tempSelectedType = _selectedType; // ตัวแปรชั่วคราวสำหรับ Type

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateModal) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Period',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSelectableOption(
                        label: 'Daily',
                        isSelected: tempSelectedPeriod == 'Daily',
                        onTap: () {
                          setStateModal(() {
                            tempSelectedPeriod = 'Daily';
                          });
                        },
                      ),
                      _buildSelectableOption(
                        label: 'Weekly',
                        isSelected: tempSelectedPeriod == 'Weekly',
                        onTap: () {
                          setStateModal(() {
                            tempSelectedPeriod = 'Weekly';
                          });
                        },
                      ),
                      _buildSelectableOption(
                        label: 'Monthly',
                        isSelected: tempSelectedPeriod == 'Monthly',
                        onTap: () {
                          setStateModal(() {
                            tempSelectedPeriod = 'Monthly';
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedPeriod = tempSelectedPeriod;
                        _selectedType = tempSelectedType;
                      });
                      Navigator.pop(context); // ปิด Modal Bottom Sheet
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSelectableOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.cyan : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


  Widget _buildPeriodButton(String label, bool isActive, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? Colors.cyan : Colors.grey.shade200,
          foregroundColor: isActive ? Colors.white : Colors.black,
        ),
        child: Text(label),
      ),
    );
  }
}

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}
