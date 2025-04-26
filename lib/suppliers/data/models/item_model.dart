import 'package:eltawfiq_suppliers/suppliers/data/models/section_model.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';

class ItemModel extends ItemEntity{
  const ItemModel({
    super.id,
    super.name,
    super.section,
    super.itemImageUrl,
    super.itemSupplierId,
    super.sectionId,
    super.purchasingPrice,
    super.sellingPrice,
    super.barcode,
    super.itemCode,
    super.itemOrder,
    super.images,

    super.dasta,
    super.kartona,

    super.balanceKetaa,
    super.balanceDasta,
    super.balanceKartona,
});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['itemName'],
      section: json['section'] != null
          ? SectionModel.fromJson(json['section'])
          : null,
      itemImageUrl: json['itemImageUrl'],
      itemSupplierId: json['itemSupplierId'],
      purchasingPrice: json['purchasingPrice'],
      sellingPrice: json['sellingPrice'],
      sectionId: json['sectionId'],
      barcode: json['barcode'],
      itemCode: json['itemCode'],
      itemOrder: json['itemOrder'],
      // Add more checks and print statements for debugging
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      dasta: json['dasta'],
      kartona: json['kartona'],

      balanceKetaa: json['balance_ketaa'],
      balanceDasta: json['balance_dasta'],
      balanceKartona: json['balance_kartona'],
    );
  }

}