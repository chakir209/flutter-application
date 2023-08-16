

import 'package:fluttergenerator/besiness_logic/models/ProductModel.dart';
import 'package:fluttergenerator/besiness_logic/models/PurchaseModel.dart';

class PurchaseItemModel {
  int? id;
  ProductModel? product;
  double? price;
  double? quantity;
  PurchaseModel? purchase;

  PurchaseItemModel({
    this.id,
    this.product,
    this.price,
    this.quantity,
    this.purchase,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product?.toJson(),
      'price': price,
      'quantity': quantity,
      'purchase': purchase?.toJson(),
    };
  }

  factory PurchaseItemModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return PurchaseItemModel(
        id: null,
        product: null,
        price: null,
        quantity: null,
        purchase: null,
      );
    }

    return PurchaseItemModel(
      id: json['id'],
      product: json['product'] != null ? ProductModel.fromJson(json['product']) : null,
      price: json['price'],
      quantity: json['quantity'],
      purchase: json['purchase'] != null ? PurchaseModel.fromJson(json['purchase']) : null,
    );
  }
}