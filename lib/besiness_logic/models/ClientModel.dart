class ClientModel {
  int? id;
  String? fullName;
  String? email;
  //DateTime? registrationDate;

  ClientModel({
    this.id,
    this.fullName,
    this.email,
    //this.registrationDate,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
  return ClientModel(
    id: json['id'] ?? 0, // Mettez ici la valeur par défaut appropriée pour l'ID (peut-être 0 ou -1)
    fullName: json['fullName'] ?? '', // Mettez ici la valeur par défaut appropriée pour fullName (peut-être une chaîne vide)
    email: json['email'] ?? '', // Mettez ici la valeur par défaut appropriée pour l'e-mail (peut-être une chaîne vide)
    //registrationDate: DateTime.tryParse(json['registrationDate']),
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      //'registrationDate': registrationDate?.toIso8601String(),
    };
  }
}