import 'package:equatable/equatable.dart';

class RoleEntity extends Equatable{
  final int id;
  final String role;

  const RoleEntity({
    required this.id,
    required this.role,
});

  @override
  List<Object?> get props => [
    id,
    role,
  ];


}