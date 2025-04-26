
import 'dart:io';

import 'package:eltawfiq_suppliers/authentication/data/data_source/local_data_source/shred_prefs_helper.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/widgets/app_home_screen_gesture.dart';
import 'package:eltawfiq_suppliers/core/resources/const_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppHomeScreenGrid extends StatefulWidget {
  const AppHomeScreenGrid({super.key});

  @override
  State<AppHomeScreenGrid> createState() => _AppHomeScreenGridState();
}

class _AppHomeScreenGridState extends State<AppHomeScreenGrid> {

  late String? role;

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  getUserRole()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper(prefs);
    Map? token = await sharedPreferencesHelper.getToken();
    setState(() {
      role = token?['role'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if(role == null){
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(SizeManager.s_16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // First Grid with Rectangles
            if(role == 'admin')
              ...[
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: SizeManager.s_8,
                  mainAxisSpacing: SizeManager.s_8,
                  childAspectRatio: Platform.isAndroid ? 5 : 10, // Adjust the aspect ratio for rectangular shape
                  children: [
                    _buildRectangleTile(
                        label: 'المخازن',
                        color: Colors.redAccent,
                        onTap: (){
                          RouteGenerator.navigationTo(AppRoutes.sectionItemsScreenRoute);
                        }
                    ),
                    _buildRectangleTile(
                        label: 'الشركات',
                        color: Colors.greenAccent,
                        onTap: (){
                          RouteGenerator.navigationTo(AppRoutes.companiesScreen);
                        }
                    ),
                    _buildRectangleTile(
                        label: 'المجموعات',
                        color: Colors.blueGrey,
                        onTap: (){
                          RouteGenerator.navigationTo(AppRoutes.groupsScreen);
                        }
                    ),
                    _buildRectangleTile(
                        label: 'التصنيفات',
                        color: Colors.orangeAccent,
                        onTap: (){
                          RouteGenerator.navigationTo(AppRoutes.sectionItemsScreenRoute);
                        }
                    ),
                  ],
                ),
              ],
        
            const SizedBox(height: SizeManager.s_16),
        
            // Second Grid with Gestures
            if(role == 'admin')
            ...[
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: Platform.isWindows ? ConstManager.c_5 : ConstManager.c_2,
                    crossAxisSpacing: SizeManager.s_16,
                    mainAxisSpacing: SizeManager.s_16,
                    childAspectRatio: 1.5,
                    children: [
                      AppHomeScreenGesture(
                        label: StringManager.invoices,
                        iconData: Icons.inventory_rounded,
                        onTap: () {
                          RouteGenerator.navigationTo(AppRoutes.suppliersInvoicesScreenRoute);
                        },
                      ),
                      AppHomeScreenGesture(
                        label: StringManager.items,
                        iconData: Icons.propane_tank,
                        onTap: () {
                          RouteGenerator.navigationTo(AppRoutes.itemsScreenRoute);
                        },
                      ),
                      AppHomeScreenGesture(
                        label: StringManager.suppliers,
                        iconData: Icons.person_add,
                        onTap: () {
                          RouteGenerator.navigationTo(AppRoutes.suppliersScreenRoute);
                        },
                      ),
                      AppHomeScreenGesture(
                        label: StringManager.newInvoice,
                        iconData: Icons.add_shopping_cart,
                        onTap: () {
                          RouteGenerator.navigationTo(AppRoutes.addNewSupplierInvoiceScreenRoute);
                        },
                      ),
                      AppHomeScreenGesture(
                        label: 'مرتجع مشتريات',
                        iconData: Icons.restore_sharp,
                        onTap: () {
                          RouteGenerator.navigationTo(AppRoutes.addNewReturnedSupplierInvoiceScreenRoute);
                        },
                      ),
                      AppHomeScreenGesture(
                        label: StringManager.clients,
                        iconData: Icons.person_remove,
                        onTap: () {
                          RouteGenerator.navigationTo(AppRoutes.clientsScreenRoute);
                        },
                      ),
                      AppHomeScreenGesture(
                        label: StringManager.salesInvoice,
                        iconData: Icons.shopping_cart_rounded,
                        onTap: () {
                          RouteGenerator.navigationTo(AppRoutes.addNewClientInvoiceScreenRoute);
                        },
                      ),
                      AppHomeScreenGesture(
                        label: 'مرتجع مبيعات',
                        iconData: Icons.settings_backup_restore_rounded,
                        onTap: () {
                          RouteGenerator.navigationTo(AppRoutes.addNewReturnedClientInvoiceScreenRoute);
                        },
                      ),
                      AppHomeScreenGesture(
                        label: StringManager.users,
                        iconData: Icons.supervised_user_circle,
                        onTap: () {
                          RouteGenerator.navigationTo(AppRoutes.usersScreenRoute);
                        },
                      ),
                    ],
                  ),
            ],
            // Second Grid with Gestures
            if(role == 'staff')
              ...[
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: Platform.isWindows ? ConstManager.c_5 : ConstManager.c_2,
                  crossAxisSpacing: SizeManager.s_16,
                  mainAxisSpacing: SizeManager.s_16,
                  childAspectRatio: 1.5,
                  children: [
                    AppHomeScreenGesture(
                      label: StringManager.items,
                      iconData: Icons.propane_tank,
                      onTap: () {
                        RouteGenerator.navigationTo(AppRoutes.itemsScreenRoute);
                      },
                    ),
                    AppHomeScreenGesture(
                      label: StringManager.salesInvoice,
                      iconData: Icons.shopping_cart_rounded,
                      onTap: () {
                        RouteGenerator.navigationTo(AppRoutes.addNewClientInvoiceScreenRoute);
                      },
                    ),
                    AppHomeScreenGesture(
                      label: 'مرتجع مبيعات',
                      iconData: Icons.settings_backup_restore_rounded,
                      onTap: () {
                        RouteGenerator.navigationTo(AppRoutes.addNewReturnedClientInvoiceScreenRoute);
                      },
                    ),
        
                  ],
                ),
              ],

          ],
        ),
      ),
    );
  }

  Widget _buildRectangleTile({required String label, required Color color, required onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(SizeManager.s_8),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

      // GridView.count(
      //   shrinkWrap: true,
      //   crossAxisCount: Platform.isWindows ?  ConstManager.c_5 : ConstManager.c_2,
      //   crossAxisSpacing: SizeManager.s_16,
      //   mainAxisSpacing: SizeManager.s_16,
      //   children:  [
      //     AppHomeScreenGesture(
      //       label: StringManager.stores,
      //       iconData: Icons.store,
      //       onTap: (){
      //         RouteGenerator.navigationTo(AppRoutes.sectionItemsScreenRoute);
      //       },
      //     ),
      //     AppHomeScreenGesture(
      //       label: StringManager.items,
      //       iconData: Icons.production_quantity_limits,
      //       onTap: (){
      //         RouteGenerator.navigationTo(AppRoutes.itemsScreenRoute);
      //       },
      //     ),
      //     AppHomeScreenGesture(
      //       label: StringManager.suppliers,
      //       iconData: Icons.people_alt_outlined,
      //       onTap: (){
      //         RouteGenerator.navigationTo(AppRoutes.suppliersScreenRoute);
      //       },
      //     ),
      //     AppHomeScreenGesture(
      //       label: StringManager.newInvoice,
      //       iconData: Icons.pending_actions,
      //       onTap: (){
      //         RouteGenerator.navigationTo(AppRoutes.addNewSupplierInvoiceScreenRoute);
      //       },
      //     ),
      //     AppHomeScreenGesture(
      //       label: StringManager.invoices,
      //       iconData: Icons.inventory_rounded,
      //       onTap: (){
      //         RouteGenerator.navigationTo(AppRoutes.suppliersInvoicesScreenRoute);
      //       },
      //     ),
      //
      //
      //     AppHomeScreenGesture(
      //       label: StringManager.salesInvoice,
      //       iconData: Icons.pending_actions,
      //       onTap: (){
      //         RouteGenerator.navigationTo(AppRoutes.addNewClientInvoiceScreenRoute);
      //       },
      //     ),
      //     AppHomeScreenGesture(
      //       label: StringManager.clients,
      //       iconData: Icons.people_alt_outlined,
      //       onTap: (){
      //         RouteGenerator.navigationTo(AppRoutes.clientsScreenRoute);
      //       },
      //     ),
      //
      //     AppHomeScreenGesture(
      //       label: StringManager.users,
      //       iconData: Icons.supervised_user_circle,
      //       onTap: (){
      //         RouteGenerator.navigationTo(AppRoutes.usersScreenRoute);
      //       },
      //     ),
      //   ],
      // ),
