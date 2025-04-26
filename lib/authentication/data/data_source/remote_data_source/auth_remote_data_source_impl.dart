import 'dart:convert';
import 'package:eltawfiq_suppliers/authentication/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:eltawfiq_suppliers/authentication/data/models/role_model.dart';
import 'package:eltawfiq_suppliers/authentication/data/models/user_model.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/add_new_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/add_new_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/edit_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/edit_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/login_user_use_case.dart';
import 'package:eltawfiq_suppliers/core/error/exceptions.dart';
import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
import 'package:eltawfiq_suppliers/core/network/error_message_model.dart';
import 'package:eltawfiq_suppliers/core/network/network_info.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/shared_methods/handle_error_response_function.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:http/http.dart'as http;

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{

  final http.Client client;
  final NetworkInfo networkInfo;

  AuthRemoteDataSourceImpl({required this.client, required this.networkInfo});

  @override
  Future<List<UserModel>> getUsers(NoParameters noParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.usersEndPoint),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response.statusCode == 200
          ? await _handleUsersSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }


  Future<List<UserModel>> _handleUsersSuccessResponse(http.Response response) async{
    List jsn = json.decode(response.body);
    return List.from(jsn.map((user) => UserModel.fromJson(user)));
  }

  @override
  Future<int> addNewUser(AddNewUserParameters addNewUserParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.post(
        Uri.parse(ApiConstance.usersEndPoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(addNewUserParameters),
      );
      return response.statusCode == 201
          ? await _handleAddNewUserSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }

  Future<int> _handleAddNewUserSuccessResponse(http.Response response) async{
    return response.statusCode;
  }

  @override
  Future<List<RoleModel>> getRoles(NoParameters noParameters) async
  {
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.rolesEndPoint),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response.statusCode == 200
          ? await _handleGetRolesSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }

  Future<List<RoleModel>> _handleGetRolesSuccessResponse(http.Response response) async
  {
    List jsn = json.decode(response.body);
    return List.from(jsn.map((role) => RoleModel.fromJson(role)));
  }

  @override
  Future<int> addNewRole(AddNewRoleParameters addNewRoleParameters) async
  {
    if (await networkInfo.isConnected) {
      final response = await client.post(
        Uri.parse(ApiConstance.rolesEndPoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(addNewRoleParameters),
      );
      return response.statusCode == 201
          ? await _handleAddNewRoleSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }

  Future<int> _handleAddNewRoleSuccessResponse(http.Response response) async{
    return response.statusCode;
  }


  @override
  Future<int> deleteUser(int deleteUserParameters) async
  {
    if (await networkInfo.isConnected) {
      final response = await client.delete(
        Uri.parse(ApiConstance.deleteUserEndPoint(deleteUserParameters)),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response.statusCode == 204
          ? await _handleDeleteUserSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }

  Future<int> _handleDeleteUserSuccessResponse(http.Response response) async
  {
    return response.statusCode;
  }

  @override
  Future<int> editUser(EditUserParameters editUserParameters) async
  {
    if (await networkInfo.isConnected) {
      final response = await client.put(
        Uri.parse(ApiConstance.editUserEndPoint(editUserParameters.id)),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(editUserParameters),
      );
      return response.statusCode == 204
          ? await _handleEditUserSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }

  Future<int> _handleEditUserSuccessResponse(http.Response response) async{
    return response.statusCode;
  }

  @override
  Future<int> deleteRole(int deleteRoleParameters) async
  {
    if (await networkInfo.isConnected) {
      final response = await client.delete(
        Uri.parse(ApiConstance.deleteRoleEndPoint(deleteRoleParameters)),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response.statusCode == 204
          ? await _handleDeleteRoleSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }

  Future<int> _handleDeleteRoleSuccessResponse(http.Response response) async
  {
    return response.statusCode;
  }

  @override
  Future<int> editRole(EditRoleParameters editRoleParameters) async
  {
    if (await networkInfo.isConnected) {
      final response = await client.put(
        Uri.parse(ApiConstance.editRoleEndPoint(editRoleParameters.id)),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(editRoleParameters),
      );
      return response.statusCode == 204
          ? await _handleEditRoleSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }

  Future<int> _handleEditRoleSuccessResponse(http.Response response) async{
    return response.statusCode;
  }

  @override
  Future<UserModel> loginUser(LoginUserParameters loginUserParameters) async
  {
    if (await networkInfo.isConnected) {
      final response = await client.post(
        Uri.parse(ApiConstance.loginUserEndPoint),
        headers: {'Content-Type': 'application/json',},
        body: json.encode(loginUserParameters),
      );
      return response.statusCode == 200
          ? await _handleLoginSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }

  Future<UserModel> _handleLoginSuccessResponse(http.Response response) async{
    var jsn = json.decode(response.body)['user'];
    UserModel user = UserModel.fromJson(jsn);
    return user;
  }


}












