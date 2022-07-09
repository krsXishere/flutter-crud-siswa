import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siswa_flutter/helpers/button.dart';
import 'package:siswa_flutter/helpers/loading_button.dart';
import 'package:siswa_flutter/helpers/scaffold_mssage.dart';
import 'package:siswa_flutter/helpers/textfield.dart';
import 'package:siswa_flutter/models/edit_data_siswa_model.dart';

class EditDataSiswaPage extends StatefulWidget {
  final int? id;
  const EditDataSiswaPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<EditDataSiswaPage> createState() => _EditDataSiswaPageState();
}

class _EditDataSiswaPageState extends State<EditDataSiswaPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  TextEditingController jurusanController = TextEditingController();
  EditDataSiswaModel? editDataSiswaModel;
  bool isLoading = false;

  Future<void> edit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String nama = namaController.text;
    String kelas = kelasController.text;
    String jurusan = jurusanController.text;
    String? token = preferences.getString('token');

    EditDataSiswaModel.toJson(
      nama,
      kelas,
      jurusan,
      token,
      widget.id,
    ).then((value) {
      editDataSiswaModel = value;
    });

    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (editDataSiswaModel?.status == 200) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil mengedit data siswa.'),
            backgroundColor: Colors.blueAccent,
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('gagal mengedit data siswa.'),
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
        title: const Text('Edit Data Siswa'),
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
                  hintName: 'Edit nama',
                  suffixIcon: null,
                ),
                const SizedBox(
                  height: 20,
                ),
                GenTextfield(
                  controller: kelasController,
                  hintName: 'Edit kelas',
                  suffixIcon: null,
                ),
                const SizedBox(
                  height: 20,
                ),
                GenTextfield(
                  controller: jurusanController,
                  hintName: 'Edit jurusan',
                  suffixIcon: null,
                ),
                const SizedBox(
                  height: 30,
                ),
                isLoading == false
                    ? DefaultButton(
                        text: 'Edit Data',
                        onPressed: edit,
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
