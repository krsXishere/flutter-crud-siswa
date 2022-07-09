import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helpers/globals.dart' as global;

class InsertDataSiswaModel {
  int? status;

  InsertDataSiswaModel({
    required this.status,
  });

  factory InsertDataSiswaModel.fromJson(Map<String, dynamic> object) {
    return InsertDataSiswaModel(
      status: object['status'],
    );
  }

  static Future<InsertDataSiswaModel> toJson(
    String nama,
    String kelas,
    String jurusan,
    String? token,
  ) async {
    String apiURL = "${global.localURL}/siswa/input";
    var response = await http.post(
      Uri.parse(apiURL),
      headers: {
        "Authorization": "Bearer " + token.toString(),
      },
      body: {
        "nama": nama,
        "kelas": kelas,
        "jurusan": jurusan,
      },
    );
    var jsonObject = json.decode(response.body);
    var data = (jsonObject as Map<String, dynamic>);

    return InsertDataSiswaModel.fromJson(data);
  }
}
