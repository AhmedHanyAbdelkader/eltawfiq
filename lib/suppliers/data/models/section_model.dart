import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';

class SectionModel extends SectionEntity{
  const SectionModel({
    super.id,
    super.sectionName,
    super.sectionImageUrl,
    super.order,
});

  factory SectionModel.fromJson(Map<String, dynamic> json) =>
      SectionModel(
        id: json['id'],
        sectionName: json['sectionName'],
        sectionImageUrl: json['sectionImageUrl'],
        order: json['orderr']
      );

}