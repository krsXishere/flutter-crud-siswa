import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helpers/globals.dart' as global;

class EditDataSiswaModel {
  int? status;

  EditDataSiswaModel({
    required this.status,
  });

  factory EditDataSiswaModel.fromJson(Map<String, dynamic> object) {
    return EditDataSiswaModel(
      status: object['status'],
    );
  }

  static Future<EditDataSiswaModel> toJson(
    String nama,
    String kelas,
    String jurusan,
    String? token,
    int? id,
  ) async {
    String apiURL = "${global.localURL}/siswa/update/$id";
    var response = await http.put(
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
    print(data.toString());

    return EditDataSiswaModel.fromJson(data);
  }
}
