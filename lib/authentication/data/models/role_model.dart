import 'package:eltawfiq_suppliers/authentication/domain/entities/role_entity.dart';

class RoleModel extends RoleEntity{
  const RoleModel({
    required super.id,
    required super.role,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      RoleModel(
          id:json['id'],
          role: json['roleName']
      );

}