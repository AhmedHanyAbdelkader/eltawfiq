import 'package:eltawfiq_suppliers/suppliers/domain/entities/group_entity.dart';

class GroupModel extends GroupEntity{
  const GroupModel({
    super.id,
    super.groupName,
});

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      GroupModel(
        id: json['id'],
        groupName: json['groupName'],
      );

}