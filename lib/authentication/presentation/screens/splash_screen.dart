import 'dart:io';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:eltawfiq_suppliers/authentication/data/data_source/local_data_source/shred_prefs_helper.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/auth_controller.dart';
import 'package:eltawfiq_suppliers/core/resources/assets_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});


  Future<void> _checkToken(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper(prefs);

    Map? token = await sharedPreferencesHelper.getToken();
    if (token!['token'] != null) {
      // Navigate to home screen
      RouteGenerator.navigationReplacementTo(AppRoutes.homeScreenRoute);
    } else {
      // Navigate to login screen
      RouteGenerator.navigationReplacementTo(AppRoutes.signinScreenRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FlutterSplashScreen.scale(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white,
          ],
        ),
        childWidget: SizedBox(
          height: Platform.isWindows ? 300 : 150,
          child: Image.asset(ImageManager.logo),
        ),
        animationDuration: const Duration(milliseconds: 1500),
        onAnimationEnd: () => debugPrint("On Scale End"),
        asyncNavigationCallback: () => _checkToken(context),
      ),
    );
  }
}
