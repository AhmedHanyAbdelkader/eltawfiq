
import 'dart:io';

import 'package:eltawfiq_suppliers/authentication/data/data_source/local_data_source/shred_prefs_helper.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/auth_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/widgets/app_home_screen_grid.dart';
import 'package:eltawfiq_suppliers/core/resources/assets_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({super.key});

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الصفحه الرئيسية'),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(
              foregroundImage: AssetImage(ImageManager.logo),
            ),
          ),
          actions: [
            InkWell(
              onTap: (){
                RouteGenerator.navigationTo(AppRoutes.searchScreen);
              },
              borderRadius: BorderRadius.circular(24.0),
              child: Container(
                width: Platform.isWindows ? 200 : 100,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8.0),
                    Text(
                      'بحث',
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper(prefs);
                await sharedPreferencesHelper.clearToken();
                RouteGenerator.navigationTo(AppRoutes.signinScreenRoute);
              },
              icon: const Icon(Icons.logout),
            ),
          ],

        ),
        body: const AppHomeScreenGrid(),
      ),
    );
  }
}
