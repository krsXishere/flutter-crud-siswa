import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siswa_flutter/data/siswa_data.dart';
import 'package:siswa_flutter/helpers/button.dart';
import 'package:siswa_flutter/models/delete_data_siswa_model.dart';
import 'package:siswa_flutter/models/siswa_model.dart';
import 'package:siswa_flutter/pages/edit_data_siswa_page.dart';
import 'package:siswa_flutter/pages/insert_data_siswa_page.dart';

class ManageSiswaPage extends StatefulWidget {
  const ManageSiswaPage({Key? key}) : super(key: key);

  @override
  State<ManageSiswaPage> createState() => _ManageSiswaPageState();
}

class _ManageSiswaPageState extends State<ManageSiswaPage> {
  SiswaData siswaData = SiswaData();
  List<SiswaModel> siswaModel = [];
  DeleteDataSiswaModel? deleteDataSiswaModel;
  String? token;

  Future<void> delete(int? id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString('token');
    DeleteDataSiswaModel.toJson(token, id).then((value) {
      deleteDataSiswaModel = value;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (deleteDataSiswaModel?.status == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil menghapus data siswa.'),
            backgroundColor: Colors.blueAccent,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menghapus data siswa.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  Future<void> getListSiswa() async {
    siswaModel = await siswaData.listSiswa();
    setState(() {});
  }

  @override
  void initState() {
    getListSiswa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Atur Siswa'),
      ),
      body: RefreshIndicator(
        onRefresh: getListSiswa,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${siswaModel[index].nama}'),
                                  Text('${siswaModel[index].kelas}'),
                                  Text('${siswaModel[index].jurusan}'),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: DefaultButton(
                                color: Colors.blueAccent,
                                text: 'Edit',
                                onPressed: () {
                                  Route route = MaterialPageRoute(
                                    builder: (context) => EditDataSiswaPage(
                                        id: siswaModel[index].id),
                                  );
                                  Navigator.of(context).push(route);
                                },
                                width: 0,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 3,
                              child: DefaultButton(
                                color: Colors.red,
                                text: 'Hapus',
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          title:
                                              const Text('Hapus data siswa?'),
                                          content: const Text(
                                              'Tindakan ini akan menghapus data siswa.'),
                                          actions: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: DefaultButton(
                                                    text: 'Batal',
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    width: double.infinity,
                                                    color: Colors.blueAccent,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: DefaultButton(
                                                    text: 'Konfirmasi',
                                                    onPressed: () {
                                                      delete(
                                                          siswaModel[index].id);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    width: double.infinity,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      });
                                },
                                width: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: siswaModel.length,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Route route = MaterialPageRoute(
              builder: (context) => const InsertDataSiswaPage());
          Navigator.of(context).push(route);
        },
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
