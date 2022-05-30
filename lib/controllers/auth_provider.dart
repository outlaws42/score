import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  Future<void> signup(
    String email,
    String password,
  ) async {
    final url = Uri.parse('https://192.168.1.9:3000/score_api/login');
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          'email': email,
          'password': email,
        },
      ),
    );
    print(jsonDecode(response.body));
  }
}
