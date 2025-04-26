import 'package:eltawfiq_suppliers/authentication/data/models/role_model.dart';
import 'package:eltawfiq_suppliers/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  const UserModel({
    required super.id, 
    required super.name, 
    super.password,
    super.email,
    super.phone,
    super.userRoleEntity,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
          id: json['id'], 
          name: json['name'], 
          password: json['password'], 
          email: json['email'], 
          phone: json['phone'], 
          userRoleEntity: json['role'] != null ? RoleModel.fromJson(json['role']) : null,
      );
  
}