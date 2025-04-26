import 'dart:io';


class ItemModel {

  int? itemId;
  String itemName;
  String itemImageUrl;
  int? sectionId;
  int sellingPrice;
  int? purchasingPrice;
  String? barcode;
  String? sectionName;
  String? supplierName;
  bool isAdded;
  int itemQuantity;
  int? itemTotal;
  int? invoiceItemsId;
  int? invoiceId;
  int? itemPrice;
  String? itemCode;
  int? itemOrder;

  ItemModel({
    required this.itemId,
    required this.itemName,
    required this.itemImageUrl,
    this.sectionId,
    required this.sellingPrice,
    this.purchasingPrice,
    this.barcode,
    this.sectionName,
    this.supplierName,
    this.isAdded = false,
    this.itemQuantity = 1,
    this.itemTotal = 0,
    this.invoiceId,
    this.invoiceItemsId,
    this.itemPrice,
    this.itemCode,
    this.itemOrder,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    itemId: json['item_id'],
    itemName: json['item_name'],
    itemImageUrl: json['item_image_url'],
    sellingPrice: json['selling_price'],
    purchasingPrice: json['purchasing_price'],
    sectionId: json['section_id'],
    sectionName: json['section'] != null ? json['section']['section_name'] : null,
    supplierName: json['supplier'] != null ? json['supplier']['supplier_name'] : null,
    invoiceItemsId: json["invoice_items_id"],
    invoiceId: json["invoice_id"],
    itemQuantity: json["item_quantity"] ?? 1,
    itemPrice: json["item_price"],
    itemTotal: json["item_total"] ?? 0,
    barcode: json['barcode'],
    itemCode: json['item_code'],
    itemOrder: json['item_order'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["invoice_items_id"] = invoiceItemsId;
    data["invoice_id"] = invoiceId;
    data["item_id"] = itemId;
    data["item_quantity"] = itemQuantity;
    data["item_price"] = itemPrice;
    data["item_total"] = itemTotal;
    return data;
  }

  // Setter method to update isAdded
  void setAdded(bool added) {
    isAdded = added;
  }

  void setItemTotal(int newItemTotal) {
    itemTotal = newItemTotal;
  }

  void setItemQuantity(int newItemQuantity) {
    itemQuantity = newItemQuantity;
  }


  void setItemPrice( newItemPrice) {
    itemPrice = newItemPrice;
    purchasingPrice = newItemPrice;
  }

}


class AddNewItemParameters{
  final String itemName;
  final int sectionId;
  final double purchasingPrice;
  final double sellingPrice;
  final int itemSupplierId;
  final File itemImage;
  String? barcode;
  String? itemCode;

  AddNewItemParameters({
    required this. itemName,
    required this. sectionId,
    required this. purchasingPrice,
    required this. sellingPrice,
    required this. itemSupplierId,
    required this.itemImage,
    this.barcode,
    this.itemCode,
});
}