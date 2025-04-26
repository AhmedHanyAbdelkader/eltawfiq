import 'package:eltawfiq_suppliers/core/network/error_message_model.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:http/http.dart' as http;
import 'package:eltawfiq_suppliers/core/error/exceptions.dart';

handleErrorResponse(http.Response response) {
  throw ServerException(
    errorMessageModel: ErrorMessageModel(
      statueMessage: response.reasonPhrase ?? StringManager.errorHappened,
      statusCode: response.statusCode,
    ),
  );
}