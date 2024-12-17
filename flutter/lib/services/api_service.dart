import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/report.dart';

class ApiService {
  static const String baseUrl = "http://your-api-url.com";

  // Register User
  Future<bool> registerUser(User user) async {
    final response = await http.post(
      Uri.parse("$baseUrl/User/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );
    return response.statusCode == 200;
  }

  // Login User
  Future<String?> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/User/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'];
    }
    return null;
  }

  // Fetch Reports
  Future<List<Report>> getReports() async {
    final response = await http.get(Uri.parse("$baseUrl/api/Reports"));

    if (response.statusCode == 200) {
      final List<dynamic> reportsJson = jsonDecode(response.body);
      return reportsJson.map((e) => Report.fromJson(e)).toList();
    }
    throw Exception("Failed to load reports");
  }

  // Upload Report with Image
  Future<bool> uploadReport(Report report, String imagePath) async {
    var request = http.MultipartRequest("POST", Uri.parse("$baseUrl/api/Reports"));

    request.fields['Name'] = report.name;
    request.fields['Description'] = report.description;
    request.fields['Place'] = report.place;
    request.fields['UserId'] = report.userId.toString();

    if (imagePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath("Image", imagePath));
    }

    var response = await request.send();
    return response.statusCode == 200;
  }
}
