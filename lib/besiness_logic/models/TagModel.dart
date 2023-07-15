class TagModel {
  int? id;
  String? code;
  String? reference;

  TagModel({
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
}