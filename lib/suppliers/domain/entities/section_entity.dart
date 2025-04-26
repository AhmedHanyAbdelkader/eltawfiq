import 'package:equatable/equatable.dart';

class SectionEntity {
  final int? id;
  final String? sectionName;
  final String? sectionImageUrl;
  final int? order;

  const SectionEntity({
    this.id,
    this.sectionName,
    this.sectionImageUrl,
    this.order,
});

  // @override
  // List<Object?> get props => [
  //   id,
  //   sectionName,
  //   sectionImageUrl,
  //   order,
  // ];
}