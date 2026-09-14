import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DralikoStore extends ChangeNotifier {
  List<dynamic> forms = [];
  bool isLoading = true;

  Future<void> load(String jsonContent) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('draliko_data')) {
      await prefs.setString('draliko_data', jsonContent);
    }
    final data = json.decode(prefs.getString('draliko_data')!);
    forms = List.from(data['forms'] ?? []);
    isLoading = false;
    notifyListeners();
  }
}
