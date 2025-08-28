class AbsensiModel {
  final String tanggal;
  final String statusLokasi;
  final String fotoPath;

  AbsensiModel({
    required this.tanggal,
    required this.statusLokasi,
    required this.fotoPath,
  });

  Map<String, dynamic> toMap() {
    return {
      "tanggal": tanggal,
      "statusLokasi": statusLokasi,
      "fotoPath": fotoPath,
    };
  }

  factory AbsensiModel.fromMap(Map<String, dynamic> map) {
    return AbsensiModel(
      tanggal: map["tanggal"],
      statusLokasi: map["statusLokasi"],
      fotoPath: map["fotoPath"],
    );
  }
}
