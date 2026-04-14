import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService extends ChangeNotifier {
  Map<String, dynamic>? _currentUser;
  
  Map<String, dynamic>? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  
  Future<bool> login(String email, String password) async {
    try {
      final result = await ApiService.login(email, password);
      if (result['success']) {
        _currentUser = result['student'];
        
        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', _currentUser!['id']);
        await prefs.setString('userName', _currentUser!['name']);
        
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  
  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
  
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final userName = prefs.getString('userName');
    
    if (userId != null && userName != null) {
      _currentUser = {'id': userId, 'name': userName};
      notifyListeners();
    }
  }
}
