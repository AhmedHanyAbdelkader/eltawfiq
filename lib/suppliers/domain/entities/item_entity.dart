import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
import 'package:equatable/equatable.dart';

class ItemEntity {
  final int? id;
  final String? name;
  final String? itemImageUrl;
  final int? sectionId;
  final num? purchasingPrice;
  final num? sellingPrice;
  final int? itemSupplierId;
  final String? barcode;
  final String? itemCode;
  final int? itemOrder;
  final SectionEntity? section;
  final List<String?>? images;

  final num? dasta;
  final num? kartona;
  final num? balanceKetaa;
  final num? balanceKartona;
  final num? balanceDasta;

  final num? ketaaQuntity;
  final num? dastaQuntity;
  final num? kartonaQuntity;

  final num? itemTotalPrice;

  const ItemEntity({
    this.id,
    this.name,
    this.itemImageUrl,
    this.sectionId,
    this.purchasingPrice,
    this.sellingPrice,
    this.itemSupplierId,
    this.barcode,
    this.itemCode,
    this.itemOrder,
    this.section,
    this.images,

    this.dasta,
    this.kartona,

    this.balanceKetaa,
    this.balanceDasta,
    this.balanceKartona,

    this.ketaaQuntity,
    this.dastaQuntity,
    this.kartonaQuntity,

    this.itemTotalPrice,
});


  ItemEntity copyWith({
    int? id,
    String? name,
    num? sellingPrice,
    num? dasta,
    num? kartona,
    num? ketaaQuntity,
    num? dastaQuntity,
    num? kartonaQuntity,
    double? itemTotalPrice,
    List<String?>? images, // Add images field here
    num? balanceKetaa,
    num? balanceKartona,
    num? balanceDasta,
    num? purchasingPrice,
  }) {
    return ItemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      dasta: dasta ?? this.dasta,
      kartona: dasta ?? this.kartona,

      ketaaQuntity: ketaaQuntity ?? this.ketaaQuntity,
      dastaQuntity: dastaQuntity ?? this.dastaQuntity,
      kartonaQuntity: kartonaQuntity ?? this.kartonaQuntity,

      itemTotalPrice: itemTotalPrice ?? this.itemTotalPrice,
      images: images ?? this.images, // Ensure images are copied over

      balanceKetaa:balanceKetaa ?? this.balanceKetaa,
      balanceDasta: balanceDasta ?? this.balanceDasta,
      balanceKartona: balanceKartona ?? this.balanceKartona,

      purchasingPrice: purchasingPrice ?? this.purchasingPrice,
    );
  }
  // @override
  // List<Object?> get props =>[
  //   id,
  //   name,
  //   section,
  //   itemImageUrl,
  //   sectionId,
  //   purchasingPrice,
  //   sellingPrice,
  //   itemSupplierId,
  //   barcode,
  //   itemCode,
  //   itemOrder,
  // ];

}


