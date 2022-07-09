import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/globals.dart' as global;

class SignInModel {
  int? id, status;
  String? name, email, token;

  SignInModel({
    required this.id,
    required this.status,
    required this.name,
    required this.email,
  });

  factory SignInModel.fromJson(Map<String, dynamic> object) {
    return SignInModel(
      id: object['id'],
      status: object['status'],
      name: object['user']['name'],
      email: object['user']['email'],
    );
  }

  static Future<SignInModel> toJson(String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String apiURL = "${global.localURL}/login";
    var reponse = await http.post(Uri.parse(apiURL), body: {
      "email": email,
      "password": password,
    });
    var jsonObject = json.decode(reponse.body);
    var data = (jsonObject as Map<String, dynamic>);
    preferences.setString('token', jsonObject['token']);

    return SignInModel.fromJson(data);
  }
}
