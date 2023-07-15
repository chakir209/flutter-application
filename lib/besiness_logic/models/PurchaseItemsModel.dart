import '../models/ProductModel.dart';
import '../models/PurchaseModel.dart';

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
      //'purchase': purchase?.toJson(),
    };
  }

  factory PurchaseItemModel.fromJson(Map<String, dynamic> json) {
    return PurchaseItemModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      price: json['price'],
      quantity: json['quantity'],
     // purchase: PurchaseModel.fromJson(json['purchase']),
    );
  }
}