import 'package:eltawfiq_suppliers/suppliers/domain/entities/phone_entity.dart';

class PhoneModel extends PhoneEntity{
  const PhoneModel({
    super.id,
    super.phoneNumber,
});

  factory PhoneModel.fromJson(Map<String, dynamic> json) =>
      PhoneModel(
        id: json['id'],
        phoneNumber: json['phonenum'],
      );

}