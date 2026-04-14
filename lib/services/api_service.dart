import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ CHANGE THIS TO YOUR LAPTOP IP ADDRESS
  static const String baseUrl = 'http://10.10.10.251:3000/api';
  
  // Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      print('Attempting login to: $baseUrl/login');
      print('Email: $email');
      
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      ).timeout(const Duration(seconds: 10));
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('فشل تسجيل الدخول - Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Login error: $e');
      throw Exception('خطأ في الاتصال بالخادم: $e');
    }
  }
  
  // Get all exams
  static Future<List<dynamic>> getExams() async {
    final response = await http.get(Uri.parse('$baseUrl/exams'));
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    throw Exception('فشل تحميل الامتحانات');
  }
  
  // Create exam
  static Future<Map<String, dynamic>> createExam(Map<String, dynamic> examData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/exams'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: jsonEncode(examData),
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    throw Exception('فشل إنشاء الامتحان');
  }
  
  // Get student answers
  static Future<List<dynamic>> getStudentAnswers(String studentId) async {
    final response = await http.get(Uri.parse('$baseUrl/student/exams/$studentId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('فشل تحميل الإجابات');
  }
  
  // Get exam by ID
  static Future<Map<String, dynamic>> getExam(String examId) async {
    final response = await http.get(Uri.parse('$baseUrl/exams/$examId'));
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    throw Exception('فشل تحميل الامتحان');
  }
  
  // Get answers by student ID
  static Future<List<dynamic>> getAnswers(String studentId) async {
    final response = await http.get(Uri.parse('$baseUrl/answers/$studentId'));
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    throw Exception('فشل تحميل الإجابات');
  }
}
