import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {
  late String _token;
  DateTime _expiryDate = DateTime.now().subtract(Duration(days: 1));
  late String _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

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
    try {
      http.Response response = await http.get(url, headers: headers);
      final responseData = jsonDecode(response.body);
      print(responseData);
       print('token: ${responseData['token']}');
      print(responseData['id']);
      print('exp: ${responseData['exp']}');
      // if (responseData['error'] != null) {
      //   throw HttpException(responseData['error']['message']);
      // }
      _token = responseData['token'];
      _userId = responseData['id'];
      _expiryDate = DateTime.now().add(
        Duration(
          days: responseData['exp'],
        ),
      );
      // print(_token);
      // print(_userId);
      // print(_expiryDate);
      notifyListeners();

    } catch (error) {
      print(error);
      // throw error;
    }

    // print(jsonDecode(response.body));
  }
}
