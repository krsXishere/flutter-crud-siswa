import 'package:flutter/material.dart';
import 'package:siswa_flutter/data/siswa_data.dart';
import 'package:siswa_flutter/models/siswa_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<SiswaModel> siswaModel = [];
  SiswaData siswaData = SiswaData();

  Future<void> getListSiswa() async {
    siswaModel = await siswaData.listSiswa();
    setState(() {});
  }

  @override
  void initState() {
    getListSiswa();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Beranda"),
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: getListSiswa,
        child: SingleChildScrollView(
          child: Center(
            child: ListView.separated(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${siswaModel[index].nama}'),
                        Text('${siswaModel[index].kelas}'),
                        Text('${siswaModel[index].jurusan}'),
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
          ),
        ),
      ),
    );
  }
}
