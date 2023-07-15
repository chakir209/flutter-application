class ProductModel {
  int? id;
  String? code;
  String? reference;

  ProductModel({
    this.id,
    this.code,
    this.reference,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'reference': reference,
    };
  }
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      code: json['code'],
      reference: json['reference'],
      //registrationDate: DateTime.tryParse(json['registrationDate']),
    );
  }
}