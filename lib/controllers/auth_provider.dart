import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  bool? _hasExpired;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_hasExpired != null && _hasExpired == false && _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    final url = Uri.parse('https://www.eldrway.com/score_api/login');
    var bytes = utf8.encode("$email:$password");
    var credentials = base64.encode(bytes);
    var headers = {
      "Accept": "application/json",
      "Authorization": "Basic $credentials"
    };
    try {
      http.Response response = await http.get(url, headers: headers);
      final responseData = jsonDecode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['token'];
      _hasExpired = JwtDecoder.isExpired(_token.toString());
      notifyListeners();
      // Store token in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final userToken = jsonEncode({
        'token': _token,
      });
      prefs.setString('userToken', userToken);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    // This gets the token from SharedPreferences if present
    // then populates the token to authenticate.
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userToken')) {
      return false;
    }
    final extractedUserData =
        jsonDecode(prefs.getString('userToken').toString());
    if (JwtDecoder.isExpired(extractedUserData['token'].toString()) == false) {
      _token = extractedUserData['token'].toString();
      _hasExpired = JwtDecoder.isExpired(extractedUserData['token'].toString());
      notifyListeners();
      return true;
    }

    return false;
  }
}
