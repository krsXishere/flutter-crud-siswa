import 'dart:convert';
import 'package:siswa_flutter/helpers/globals.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:siswa_flutter/models/siswa_model.dart';

class SiswaData {
  String apiURL = "${global.localURL}/siswa";

  Future listSiswa() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    try {
      var response = await http.get(Uri.parse(apiURL), headers: {
        'Authorization': 'Bearer ' + token.toString(),
      });

      if (response.statusCode == 200) {
        Iterable iterable = jsonDecode(response.body)['data'];
        List<SiswaModel> siswaModel =
            iterable.map((e) => SiswaModel.fromJson(e)).toList();

        return siswaModel;
      }
    } catch (e) {
      print('Error : ' + e.toString());
    }
  }
}
