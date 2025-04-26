import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable{
  final int? id;
  final String? groupName;

  const GroupEntity({
    this.id,
    this.groupName,
});

  @override
  List<Object?> get props => [
    id,
    groupName,
  ];
}