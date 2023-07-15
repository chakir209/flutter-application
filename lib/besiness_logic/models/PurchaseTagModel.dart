import '../models/TagModel.dart';
import '../models/PurchaseModel.dart';
class PurchaseTagModel {
  int? id;
  PurchaseModel? purchase;
  TagModel? tag;

  PurchaseTagModel({
    this.id,
    this.purchase,
    this.tag,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'purchase': purchase?.toJson(),
      'tag': tag?.toJson(),
    };
  }
}