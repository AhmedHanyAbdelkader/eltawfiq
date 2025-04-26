
import 'package:eltawfiq_suppliers/core/app/my_app.dart';

import 'package:eltawfiq_suppliers/core/services/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  runApp(const MyApp());
}



