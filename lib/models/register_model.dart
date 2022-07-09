import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/globals.dart' as global;

class RegisterModel {
  int? id, status;
  String? name, email, token;

  RegisterModel({
    required this.id,
    required this.status,
    required this.name,
    required this.email,
    required this.token,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> object) {
    return RegisterModel(
      id: object['id'],
      status: object['status'],
      name: object['user']['name'],
      email: object['user']['email'],
      token: object['user']['token'],
    );
  }

  static Future<RegisterModel> toJson(
      String name, String email, String password, String cPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String apiURL = "${global.localURL}/register";
    var response = await http.post(
      Uri.parse(apiURL),
      body: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": cPassword,
      },
    );
    var jsonObject = json.decode(response.body);
    var data = (jsonObject as Map<String, dynamic>);

    return RegisterModel.fromJson(data);
  }
}
