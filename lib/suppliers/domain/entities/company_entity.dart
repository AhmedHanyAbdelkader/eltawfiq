import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable{
  final int? id;
  final String? companyName;
  final String? companyDescription;

  const CompanyEntity({
    this.id,
    this.companyName,
    this.companyDescription,
});

  @override
  List<Object?> get props => [
    id,
    companyName,
    companyDescription,
  ];
}