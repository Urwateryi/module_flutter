import 'shopping_entity.dart';

class InventoryShoppingEntity {
  String recordcount;
  List<ShoppingEntity> detail;

  InventoryShoppingEntity({this.recordcount, this.detail});

  InventoryShoppingEntity.fromJson(Map<String, dynamic> json) {
    recordcount = json['recordcount'];
    if (json['detail'] != null) {
      detail = new List<ShoppingEntity>();
      (json['detail'] as List).forEach((v) {
        detail.add(new ShoppingEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordcount'] = this.recordcount;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
