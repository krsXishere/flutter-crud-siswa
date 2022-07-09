class SiswaModel {
  int? id;
  String? nama, kelas, jurusan;

  SiswaModel({
    required this.id,
    required this.nama,
    required this.kelas,
    required this.jurusan,
  });

  factory SiswaModel.fromJson(Map<String, dynamic> siswaObject) {
    return SiswaModel(
      id: siswaObject['id'],
      nama: siswaObject['nama'],
      kelas: siswaObject['kelas'],
      jurusan: siswaObject['jurusan'],
    );
  }
}
