import 'package:equatable/equatable.dart';

class PhoneEntity extends Equatable{
  final int? id;
  final String? phoneNumber;

  const PhoneEntity({
    this.id,
    this.phoneNumber,
});

  @override
  List<Object?> get props => [
    id,
    phoneNumber,
  ];

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['phonenum'] = phoneNumber;
    return data;
  }

}

