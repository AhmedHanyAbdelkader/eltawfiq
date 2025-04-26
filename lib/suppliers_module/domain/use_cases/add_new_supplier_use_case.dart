import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers_module/domain/repository/suppliers_base_repository.dart';
import 'package:equatable/equatable.dart';

class AddNewSupplierUseCase extends BaseUseCase<int, AddNewSupplierParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  AddNewSupplierUseCase(this.suppliersBaseRepository);

  @override
  Future<Either<Failure, int>> call(AddNewSupplierParameters parameter) async{
    return await suppliersBaseRepository.addNewSupplier(parameter);
  }

}



class AddNewSupplierParameters extends Equatable{
  final String supplierName;
  final String? supplierFullName;
  final String? supplierPostalCode;
  final List<String>? supplierPhoneNumbers;
  final String? supplierWhatsappNumber;
  final String? address;
  final String? mapLocation;
  final String? email;
  final String? facebook;
  final String? notes;
  final double supplierTotal;
  final double supplierPayed;
  final double supplierRemained;
  final List<Map>? bankInfos;
  final String? supplierPosition;
  final int? companyId;
  final int? groupId;
  final int? secId;

  const AddNewSupplierParameters({
    required this.supplierName,
    this.supplierFullName,
    this.email,
    required this.supplierTotal,
    required this.supplierPayed,
    required this.supplierRemained,
    this.companyId,
    this.groupId,
    this.secId,
    this.supplierPosition,
    this.supplierPhoneNumbers,
    this.supplierPostalCode,
    this.supplierWhatsappNumber,
    this.address,
    this.facebook,
    this.notes,
    this.bankInfos,
    this.mapLocation,
});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['supplier_name'] = supplierName;
    data['supplier_full_name'] = supplierFullName;
    data['supplier_postal_code'] = supplierPostalCode;
    data['supplier_phone_numbers'] = supplierPhoneNumbers;
    data['supplier_whatsapp_number'] = supplierWhatsappNumber;
    data['address'] = address;
    data['map_location'] = mapLocation;
    data['email'] = email;
    data['facebook'] = facebook;
    data['notes'] = notes;
    data['supplier_total'] = supplierTotal;
    data['supplier_payed'] = supplierPayed;
    data['supplier_remained'] = supplierRemained;
    data['bank_infos'] = bankInfos;
    data['supplier_position'] = supplierPosition;
    data['company_id'] = companyId;
    data['group_id'] = groupId;
    data['sec_id'] = secId;
    return data;
  }

  @override
  List<Object?> get props => [
    supplierName,
    supplierFullName,
    email,
    supplierTotal,
    supplierPayed,
    supplierRemained,
    companyId,
    groupId,
    secId,
    supplierPosition,
    supplierPhoneNumbers,
    supplierPostalCode,
    supplierWhatsappNumber,
    address,
    facebook,
    notes,
    bankInfos,
    mapLocation,
  ];


}