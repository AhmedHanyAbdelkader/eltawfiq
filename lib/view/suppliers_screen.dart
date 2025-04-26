import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/view/components/supplier_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';


class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration.zero, () {
        Provider.of<AppStateProvider>(context, listen: false).getSuppliers(
          id: 1,
          //Provider.of<AuthStateProvider>(context, listen: false).loginResult!.user!.id!,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.suppliers),
        actions: [
          PopupMenuButton(
            onSelected: (String result) {
              switch (result) {
                case 'Item 1':
                  break;
                case 'Item 2':
                  break;
                case 'Item 3':
                  break;
              }
            },
            itemBuilder: (BuildContext context)
            => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'إضافة مجموعه جديده',
                child: const Text('إضافة مجموعه جديده'),
                onTap: (){
                  //RouteGenerator.navigationTo(AppRoutes.addNewGroupScreenRoute);
                },
              ),
              PopupMenuItem<String>(
                value: 'إضافة شركه جديده',
                child: const Text('إضافة شركه جديده'),
                onTap: (){
                  RouteGenerator.navigationTo(AppRoutes.addNewCompanyScreenRoute);
                },
              ),
              PopupMenuItem<String>(
                value: 'إضافة تصنيف جديد',
                child: const Text('إضافة تصنيف جديد'),
                onTap: (){
                  //RouteGenerator.navigationTo(AppRoutes.addNewSectionScreenRoute);
                },
              ),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              //controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search suppliers...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        tooltip: 'اضافة مورد جديد',
        children: [
          SpeedDialChild(
            child: const Icon(Icons.contact_phone_outlined),
            label: 'جهات الاتصال',
            onTap: () {
              RouteGenerator.navigationTo(AppRoutes.contactsScreenRoute);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.edit_note),
            label: 'تسجيل مورد',
            onTap: () => RouteGenerator.navigationTo(AppRoutes.addNewSupplierScreenRoute),
          ),

        ],
      ),
      body: Consumer<AppStateProvider>(
          builder: (context, suppliersStateProvider, _){
            if(suppliersStateProvider.getItemsForSectionIsLoading){
              return const Center(child: CircularProgressIndicator.adaptive(),);
            }
            else if(suppliersStateProvider.getSuppliersErrorMessage.isNotEmpty){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(StringManager.error),
                    content: Text(suppliersStateProvider.getSuppliersErrorMessage),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(StringManager.ok),
                      ),
                    ],
                  ),
                );
              });
            }
            else if(suppliersStateProvider.getSuppliersResult != null){
              return SupplierListWidget(suppliers: suppliersStateProvider.getSuppliersResult!);
            }
            return const Center(child: CircularProgressIndicator.adaptive(),);
          }
      ),
    );
  }

}






