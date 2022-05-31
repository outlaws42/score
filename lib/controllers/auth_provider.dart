import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
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

  Future<void> login(
    String email,
    String password,
  ) async {
    final url = Uri.parse('http://192.168.1.9:3000/score_api/login');
    var bytes = utf8.encode("$email:$password");
    var credentials = base64.encode(bytes);
    var headers = {
      "Accept": "application/json",
      "Authorization": "Basic $credentials"
    };
    http.Response response = await http.get(url, headers: headers);
    print(jsonDecode(response.body));
  }
}
