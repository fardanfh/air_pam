class TagihanBayarModel {
  int? pin;
  int? idTagihan;

  TagihanBayarModel({this.pin, this.idTagihan});

  factory TagihanBayarModel.fromJson(Map<String, dynamic> json) {
    return TagihanBayarModel(
      pin: json['pin'],
      idTagihan: json['id_tagihan'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'pin': pin,
      'id_tagihan': idTagihan,
    };
  }
}
