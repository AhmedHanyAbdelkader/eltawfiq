import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/clients/clients_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/suppliers_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ClientsController>(context, listen: false).getClients(const NoParameters());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.clients),
          automaticallyImplyLeading: true,
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.add_event,
          tooltip: 'اضافة عميل جديد',
          children: [
            SpeedDialChild(
              child: const Icon(Icons.contact_phone_outlined),
              label: 'جهات الاتصال',
              onTap: () {
                RouteGenerator.navigationTo(AppRoutes.clientsContactsScreenRoute);
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.edit_note),
              label: 'تسجيل عميل',
              onTap: () =>  RouteGenerator.navigationTo(AppRoutes.addNewClientScreenRoute),
            ),

          ],
        ),

        body: Consumer<ClientsController>(
          builder: (context, clientsController, _){
            if(clientsController.getClientsIsLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(clientsController.getClientsErrorMessage.isNotEmpty){
              return Center(
                child: Text(clientsController.getClientsErrorMessage),
              );
            }
            if(clientsController.gettingClients == null || clientsController.gettingClients!.isEmpty){
              return const Center(
                child: Text('No Suppliers available'),
              );
            }
            else{
              return SuppliersListView(suppliers: clientsController.gettingClients,);
            }
          },
        ),
      ),
    );
  }

}






