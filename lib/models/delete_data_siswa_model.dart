import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helpers/globals.dart' as global;

class DeleteDataSiswaModel {
  int? status;

  DeleteDataSiswaModel({
    required this.status,
  });

  factory DeleteDataSiswaModel.fromJson(Map<String, dynamic> object) {
    return DeleteDataSiswaModel(
      status: object['status'],
    );
  }

  static Future<DeleteDataSiswaModel> toJson(
    String? token,
    int? id,
  ) async {
    String apiURL = "${global.localURL}/siswa/delete/$id";
    var response = await http.delete(
      Uri.parse(apiURL),
      headers: {
        "Authorization": "Bearer " + token.toString(),
      },
    );
    var jsonObject = json.decode(response.body);
    var data = (jsonObject as Map<String, dynamic>);
    print(data.toString());

    return DeleteDataSiswaModel.fromJson(data);
  }
}
