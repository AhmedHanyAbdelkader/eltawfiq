
import 'package:eltawfiq_suppliers/core/network/error_message_model.dart';

class ServerException implements Exception{
  final ErrorMessageModel errorMessageModel;

  const ServerException({
    required this.errorMessageModel
  });

}

class NoInternetException implements Exception{
  final ErrorMessageModel errorMessageModel;
  const NoInternetException({
    required this.errorMessageModel
});
}


class LocalDatabaseException implements Exception{
  final String message;

  const LocalDatabaseException({
    required this.message
  });

}