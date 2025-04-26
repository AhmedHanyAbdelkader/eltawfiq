class SectionModel{
  final int id;
  final String name;
  final String imgUrl;
  final int order;

  SectionModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.order,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json)
  => SectionModel(
      id: json['sec_id'],
      name: json['section_name'],
      imgUrl: json['section_image_url'],
    order: json['order']
  );
}