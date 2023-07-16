import '../models/ClientModel.dart';
import '../models/PurchaseItemsModel.dart';
import '../models/PurchaseTagModel.dart';

class PurchaseModel {
  int? id;
  String? reference;
  String? image;
  double? total;
  String? description;
  ClientModel? client;
  List<PurchaseItemModel>? purchaseItems;
  // List<PurchaseTagModel>? purchaseTag;

  PurchaseModel({
    this.id,
    this.reference,
    this.image,
    this.total,
    this.description,
    this.client,
    this.purchaseItems,
    // this.purchaseTag,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Gérer le cas où le JSON est nul
      return PurchaseModel(id:0, reference: '');
    }

    return PurchaseModel(
      id: json['id'],
      reference: json['reference'],
      image: json['image'],
      total: json['total'],
      description: json['description'],
      client: json['client'] != null ? ClientModel.fromJson(json['client']) : null,
      purchaseItems: json['purchaseItems'] != null
          ? (json['purchaseItems'] as List<dynamic>)
              .map((item) => PurchaseItemModel.fromJson(item))
              .toList()
          : null,
      // purchaseTag: json['purchaseTag'] != null
      //     ? (json['purchaseTag'] as List<dynamic>)
      //         .map((tag) => PurchaseTagModel.fromJson(tag))
      //         .toList()
      //     : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'reference': reference,
      'image':image,
      'total': total,
      'description': description,
      'client': client?.toJson(),
      'purchaseItems': purchaseItems?.map((item) => item.toJson()).toList(),
      // 'purchaseTag': purchaseTag?.map((tag) => tag.toJson()).toList(),
    };
  }
}