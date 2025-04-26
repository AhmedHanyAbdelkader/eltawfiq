
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';

validateUserNameOrPassword(String? input){
  if(input == null || input.isEmpty){
    return StringManager.fieldRequired;
  }
  return null;
}