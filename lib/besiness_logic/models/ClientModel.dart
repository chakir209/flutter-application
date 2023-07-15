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
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
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