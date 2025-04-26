class GroupModel{
  final int groupId;
  final String groupName;

  const GroupModel({
    required this.groupId,
    required this.groupName
});

  factory GroupModel.fromJson(Map<String, dynamic> json)
  => GroupModel(
      groupId: json['group_id'],
      groupName: json['group_name'],
  );

  Map<String, dynamic> toJson(){
    return {
      'group_name' : groupName,
    };
  }

}