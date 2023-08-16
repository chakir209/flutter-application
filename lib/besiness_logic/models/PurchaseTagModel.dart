
import 'package:fluttergenerator/besiness_logic/models/PurchaseModel.dart';
import 'package:fluttergenerator/besiness_logic/models/TagModel.dart';

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