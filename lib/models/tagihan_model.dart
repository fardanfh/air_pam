class TagihanModel {
  int? id;
  int? idUser;
  int? idTipeTransaksi;
  String? tanggal;
  int? meteranTerakhir;
  int? meteran;
  int? jumlahTagihan;
  String? status;
  String? createdAt;
  String? updatedAt;

  TagihanModel({
    this.id,
    this.idUser,
    this.idTipeTransaksi,
    this.tanggal,
    this.meteranTerakhir,
    this.meteran,
    this.jumlahTagihan,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  TagihanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0;
    idUser = json['id_user'] is int ? json['id_user'] : int.tryParse(json['id_user'].toString()) ?? 0;
    idTipeTransaksi = json['id_tipe_transaksi'] is int ? json['id_tipe_transaksi'] : int.tryParse(json['id_tipe_transaksi'].toString()) ?? 0;
    tanggal = json['tanggal'];
    meteranTerakhir = json['meteran_terakhir'] is int ? json['meteran_terakhir'] : int.tryParse(json['meteran_terakhir'].toString()) ?? 0;
    meteran = json['meteran'] is int ? json['meteran'] : int.tryParse(json['meteran'].toString()) ?? 0;
    jumlahTagihan = json['jumlah_tagihan'] is int ? json['jumlah_tagihan'] : int.tryParse(json['jumlah_tagihan'].toString()) ?? 0;
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_user'] = idUser;
    data['id_tipe_transaksi'] = idTipeTransaksi;
    data['tanggal'] = tanggal;
    data['meteran_terakhir'] = meteranTerakhir;
    data['meteran'] = meteran;
    data['jumlah_tagihan'] = jumlahTagihan;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
