import 'dart:convert';
import 'package:eltawfiq_suppliers/core/error/exceptions.dart';
import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
import 'package:eltawfiq_suppliers/core/network/error_message_model.dart';
import 'package:eltawfiq_suppliers/core/network/network_info.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/shared_methods/handle_error_response_function.dart';
import 'package:eltawfiq_suppliers/suppliers_module/data/data_source/suppliers_remote_data_source.dart';
import 'package:eltawfiq_suppliers/suppliers_module/data/models/supplier_model.dart';
import 'package:eltawfiq_suppliers/suppliers_module/domain/use_cases/add_new_supplier_use_case.dart';
import 'package:http/http.dart' as http
;
class SuppliersRemoteDataSourceImpl implements SuppliersRemoteDataSource{

  final http.Client client;
  final NetworkInfo networkInfo;

  SuppliersRemoteDataSourceImpl({required this.client, required this.networkInfo});


  @override
  Future<List<SupplierModel>> getYourSuppliers(int id) async {
      if (await networkInfo.isConnected) {
        final response = await client.get(
          Uri.parse(ApiConstance.getSuppliersEndPoint(id)),
          headers: {
            'Content-Type': 'application/json',
            //'token' : token
          },
        );

        return response.statusCode == 200
            ? _handleSuppliersSuccessResponse(response) : handleErrorResponse(response);
      }
      else {
        throw NoInternetException(
            errorMessageModel: ErrorMessageModel(
                statueMessage: StringManager.noInternet,
                statusCode: 505
            )
        );
      }
    }

  Future<List<SupplierModel>> _handleSuppliersSuccessResponse(http.Response response) async {
      List jsn = json.decode(response.body);
      return List.from(jsn.map((supplier) => SupplierModel.fromJson(supplier)));
    }

  @override
  Future<int> addNewSupplier(AddNewSupplierParameters addNewSupplierParameters) async
  {
    if (await networkInfo.isConnected) {
      final response = await client.post(
        Uri.parse(ApiConstance.addNewSupplierEndPoint),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
        body: json.encode(addNewSupplierParameters),
      );

      return response.statusCode == 200
          ? _handleAddNewSupplierSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }

  Future<int> _handleAddNewSupplierSuccessResponse(http.Response response) async {
    return response.statusCode;
  }




}