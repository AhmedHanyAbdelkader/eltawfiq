import 'package:eltawfiq_suppliers/authentication/domain/entities/role_entity.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final int id;
  final String name;
  final String? password;
  final String? email;
  final String? phone;
  final RoleEntity? userRoleEntity;

  const UserEntity({
    required this.id,
    required this.name,
    this.password,
    this.email,
    this.phone,
    this.userRoleEntity,
});

  @override
  List<Object?> get props => [
    id,
    name,
    password,
    email,
    phone,
    userRoleEntity,
  ];
}