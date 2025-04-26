// import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
// import 'package:eltawfiq_suppliers/core/app/functions.dart';
// import 'package:eltawfiq_suppliers/core/router/app_router.dart';
// import 'package:eltawfiq_suppliers/model/supplier_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class SupplierListWidget extends StatefulWidget {
//   const SupplierListWidget({super.key, required this.suppliers});
//   final List<SupplierModel> suppliers;
//   @override
//   State<SupplierListWidget> createState() => _SupplierListWidgetState();
// }
//
// class _SupplierListWidgetState extends State<SupplierListWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       shrinkWrap: true,
//       physics: const BouncingScrollPhysics(),
//       itemCount: widget.suppliers.length,
//       separatorBuilder: (context, index)=> const Divider(),
//       itemBuilder: (context, index){
//         String? supName = widget.suppliers[index].supplierName;
//         String? comName = widget.suppliers[index].company?.companyName;
//         return ListTile(
//           onTap: ()  {
//             Provider.of<AppStateProvider>(context, listen: false).changeCurrentISupplier(newSupplier: widget.suppliers[index]);
//             RouteGenerator.navigationTo(AppRoutes.supplierScreenRoute);
//           },
//           title: Text(supName ?? '',
//             style: const TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 16
//             ),
//           ),
//           subtitle: SelectableText(comName ?? '',
//             style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20
//             ),
//           ),
//           leading: Text((index+1).toString()),
//           trailing: widget.suppliers[index].supplierWhatsappNumber != null
//               ? IconButton(
//             onPressed: () {
//               String forrmattedWhatsappNumber = formatPhoneNumber(widget.suppliers[index].supplierWhatsappNumber!);
//               launchWhatsAppUri(whatsappNumber: forrmattedWhatsappNumber);
//             },
//
//             icon: const Icon(Icons.chat, color: Colors.green,),
//           ): null,
//         );
//       },
//     );
//   }
// }


import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/core/app/functions.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/services/service_locator.dart';
import 'package:eltawfiq_suppliers/model/supplier_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SupplierListWidget extends StatefulWidget {
  const SupplierListWidget({super.key, required this.suppliers});
  final List<SupplierModel> suppliers;

  @override
  State<SupplierListWidget> createState() => _SupplierListWidgetState();
}

class _SupplierListWidgetState extends State<SupplierListWidget> {
  List<SupplierModel> _suppliers = [];
  late AppStateProvider _appStateProvider;

  @override
  void initState() {
    super.initState();
    _suppliers = widget.suppliers;
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appStateProvider = sl<AppStateProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _appStateProvider,
      child: ReorderableListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            final SupplierModel item = _suppliers.removeAt(oldIndex);
            _suppliers.insert(newIndex, item);
          });
          _appStateProvider.saveSuppliersOrder(_suppliers);
        },
        children: List.generate(
            _suppliers.length,
                (index) {
          String? supName = _suppliers[index].supplierName;
          String? comName = _suppliers[index].company?.companyName;
          return ListTile(
            key: ValueKey(_suppliers[index]),
            onTap: () {
              Provider.of<AppStateProvider>(context, listen: false)
                  .changeCurrentISupplier(newSupplier: _suppliers[index]);
              RouteGenerator.navigationTo(AppRoutes.supplierScreenRoute);
            },
            title: Text(
              supName ?? '',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            subtitle: SelectableText(
              comName ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            leading: Text((index + 1).toString()),
            trailing: _suppliers[index].supplierWhatsappNumber != null
                ? IconButton(
              onPressed: () {
                String formattedWhatsappNumber =
                formatPhoneNumber(_suppliers[index].supplierWhatsappNumber!);
                launchWhatsAppUri(whatsappNumber: formattedWhatsappNumber);
              },
              icon: const Icon(
                Icons.chat,
                color: Colors.green,
              ),
            )
                : null,
          );
        }),
      ),
    );
  }
}
