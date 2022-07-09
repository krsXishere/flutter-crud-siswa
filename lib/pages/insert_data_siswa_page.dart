import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siswa_flutter/helpers/button.dart';
import 'package:siswa_flutter/models/insert_data_siswa_model.dart';

import '../helpers/loading_button.dart';
import '../helpers/textfield.dart';

class InsertDataSiswaPage extends StatefulWidget {
  const InsertDataSiswaPage({Key? key}) : super(key: key);

  @override
  State<InsertDataSiswaPage> createState() => _InsertDataSiswaPageState();
}

class _InsertDataSiswaPageState extends State<InsertDataSiswaPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  TextEditingController jurusanController = TextEditingController();
  String? token;
  InsertDataSiswaModel? insertDataSiswaModel;
  bool isLoading = false;

  Future<void> insert() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String nama = namaController.text;
    String kelas = kelasController.text;
    String jurusan = jurusanController.text;
    token = preferences.getString('token');

    InsertDataSiswaModel.toJson(
      nama,
      kelas,
      jurusan,
      token,
    ).then((value) {
      insertDataSiswaModel = value;
    });

    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (insertDataSiswaModel?.status == 200) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil menambahkan data.'),
            backgroundColor: Colors.blueAccent,
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menambahkan data.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tambahkan Data Siswa'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const FlutterLogo(
                  size: 150,
                ),
                const SizedBox(
                  height: 30,
                ),
                GenTextfield(
                  controller: namaController,
                  hintName: 'Tambahkan nama',
                  suffixIcon: null,
                ),
                const SizedBox(
                  height: 20,
                ),
                GenTextfield(
                  controller: kelasController,
                  hintName: 'Tambahkan kelas',
                  suffixIcon: null,
                ),
                const SizedBox(
                  height: 20,
                ),
                GenTextfield(
                  controller: jurusanController,
                  hintName: 'Tambahkan jurusan',
                  suffixIcon: null,
                ),
                const SizedBox(
                  height: 30,
                ),
                isLoading == false
                    ? DefaultButton(
                        text: 'Tambahkan Data',
                        onPressed: insert,
                        width: double.infinity,
                        color: Colors.blueAccent,
                      )
                    : LoadingButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
