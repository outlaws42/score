import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  // DateTime _expiryDate = DateTime.now().subtract(Duration(days: 1));
 bool? _hasExpired;
  // late String _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    // if (_expiryDate != null &&
    //     _expiryDate.isAfter(DateTime.now()) &&
    //     _token != null) {
    //   return _token;
    // }
    if (_hasExpired != null && _hasExpired == false && _token != null) {
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
      // final responseHeader = jsonDecode(response);
      // print(responseHeader);
      
      // DateTime expirationDate =
      //     JwtDecoder.getExpirationDate(responseData['token']);

      // print('token: ${responseData['token']}');
      // print('exp: $_hasExpired');
      // print('expDate: $expirationDate');
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['token'];
      _hasExpired = JwtDecoder.isExpired(_token.toString());
      // _userId = responseData['id'];
      // _expiryDate = DateTime.now().add(
      //   Duration(
      //     days: responseData['exp'],
      //   ),
      // );
      print('token: ${responseData['token']}');
      // print('exp: $_hasExpired');
      // print(_token);
      // print(_userId);
      // print(_expiryDate);
      notifyListeners();
      // Store token in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final userToken = jsonEncode({'token': _token,});
      prefs.setString('userToken', userToken);
    } catch (error) {
      print(error);
      // throw error;
    }

    // print(jsonDecode(response.body));
  }
}
