import 'package:flutter/foundation.dart';
import 'package:healthcare/services/api_service.dart';

class FoodRecordProvider with ChangeNotifier {
  List<Map<String, dynamic>> _records = [];
  bool _isLoading = false;
  bool _isSaving = false;

  List<Map<String, dynamic>> get records => _records;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;

  /// ดึงข้อมูล Food Records
  Future<void> fetchRecords(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      _records = await ApiService.fetchFoodRecords(token);
    } catch (e) {
      print('Error fetching records: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// บันทึกข้อมูล Food Record ใหม่
  Future<void> saveFoodRecord({
    required String token,
    required String name,
    required String time,
    required String date,
    required int calories,
  }) async {
    _isSaving = true;
    notifyListeners();

    try {
      await ApiService.addFoodRecord(
        token,
        {
          'name': name,
          'time': time,
          'date': date,
          'calories': calories,
        },
      );

      // เพิ่มรายการใหม่ใน _records
      _records.add({
        'name': name,
        'time': time,
        'date': date,
        'calories': calories,
      });

      notifyListeners();
    } catch (e) {
      print('Error saving food record: $e');
      rethrow;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
}
