import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable{
  final int statusCode;
  final String statueMessage;

  const ErrorMessageModel({
    required this.statusCode,
    required this.statueMessage,
  });


  factory ErrorMessageModel.fromJson(Map<String,dynamic> json) => ErrorMessageModel(
      statusCode: json["status_code"],
      statueMessage: json["status_message"],
  );

  @override
  List<Object?> get props => [
    statusCode,
    statueMessage,
  ];
}

