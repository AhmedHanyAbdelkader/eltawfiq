import 'package:eltawfiq_suppliers/core/app/functions.dart';
import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/get_supplier_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({super.key, required this.supplier});
  final SupplierEntity supplier;
  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData();
  }

  _fetchData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetSupplierController>(context, listen: false).getSupplier(
          widget.supplier.id!);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المورد'),
        automaticallyImplyLeading: true,
      ),
      body: Consumer<GetSupplierController>(
        builder: (context, getSupplierController, _) {
          if (getSupplierController.getSupplierIsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (getSupplierController.getSupplierErrorMessage.isNotEmpty) {
            return Center(
              child: Text(getSupplierController.getSupplierErrorMessage),
            );
          }
          if (getSupplierController.gettingSupplier == null) {
            return const Center(
              child: Text('No Supplier available'),
            );
          }
          else {
            final SupplierEntity? supplier = getSupplierController.gettingSupplier;
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(supplier: supplier!),
                      const SizedBox(height: 16),
                      _buildContactInfo(supplier: supplier),
                      const SizedBox(height: 16),
                      _buildFinancialSummary(supplier: supplier),
                      const SizedBox(height: 16),
                      _buildAdditionalDetails(supplier: supplier),
                      const SizedBox(height: 16),
                      _buildFooterButtons(supplier: supplier),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildHeader({required SupplierEntity? supplier}) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://image.url'), // Placeholder
        ),
        const SizedBox(width: SizeManager.s_16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'شركة ${supplier!.company?.companyName.toString()}',
              style: const TextStyle(fontSize: SizeManager.s_24, fontWeight: FontWeight.bold),
            ),
            Text(
              supplier.supplierName.toString(),
              style: const TextStyle(fontSize: SizeManager.s_20),
            ),
          ],
        ),
      ],
    );
  }




  // Widget _buildContactInfo({required SupplierEntity? supplier}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       supplier?.supplierWhatsappNumber != null ?
  //        ListTile(
  //         leading:  IconButton(
  //           icon: const Icon(Icons.mark_unread_chat_alt_outlined, color: Colors.teal),
  //           onPressed: (){
  //             String formattedWhatsappNumber = formatPhoneNumber(supplier?.supplierWhatsappNumber??'');
  //             launchWhatsAppUri(whatsappNumber: formattedWhatsappNumber);
  //           },
  //         ),
  //         title: Text(supplier?.supplierWhatsappNumber.toString() ?? ''),
  //       ) : const SizedBox(),
  //
  //       ListTile(
  //         leading: IconButton(
  //           icon: const Icon(Icons.phone),
  //           onPressed: (){},
  //         ),
  //         title: Text('متنساش لستة التليفونات'),
  //       ),
  //
  //       supplier?.email != null ?
  //       ListTile(
  //         leading: IconButton(
  //             onPressed: (){
  //               launchEmailApp(toEmail: supplier?.email ?? '', subject: '', body: '');
  //             },
  //             icon: const Icon(Icons.mark_email_unread_outlined, color: Colors.redAccent,),
  //         ),
  //         title: Text(supplier!.email.toString()),
  //       ) : const SizedBox(),
  //
  //       supplier?.mapLocation != null ?
  //        ListTile(
  //         leading: IconButton(
  //           icon: const Icon(Icons.location_pin, color: Colors.red),
  //           onPressed: (){
  //             launchMapUrl(supplier?.mapLocation ?? '');
  //           },
  //         ),
  //         title: Text(supplier?.address.toString() ?? ''),
  //
  //       ) : const SizedBox(),
  //
  //       supplier?.facebook != null ?
  //        ListTile(
  //         leading: IconButton(
  //           icon: const Icon(Icons.facebook, color: Colors.blue),
  //           onPressed:() => launchFacebookUrl(supplier?.facebook.toString()?? ''),
  //         ),
  //         title: const Text('فيسبوك'),
  //
  //       ) : const SizedBox(),
  //     ],
  //   );
  // }


  Widget _buildContactInfo({required SupplierEntity? supplier}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // WhatsApp number
        (supplier?.supplierWhatsappNumber != null && supplier!.supplierWhatsappNumber!.isNotEmpty)
            ? ListTile(
          leading: IconButton(
            icon: const Icon(Icons.mark_unread_chat_alt_outlined, color: Colors.teal),
            onPressed: () {
              String formattedWhatsappNumber = formatPhoneNumber(supplier?.supplierWhatsappNumber ?? '');
              launchWhatsAppUri(whatsappNumber: formattedWhatsappNumber);
            },
          ),
          title: Text(supplier?.supplierWhatsappNumber ?? ''),
        )
            : const SizedBox(),

        // Phone numbers
        if (supplier?.supplierPhoneNumbers != null && supplier!.supplierPhoneNumbers!.isNotEmpty)
          ExpansionTile(
            leading: IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () {
                String phoneNumber = supplier.supplierPhoneNumbers!.first.phoneNumber.toString();
                makePhoneCall(phoneNumber);
                // Your phone logic here
              },
            ),
            title: Text(supplier!.supplierPhoneNumbers!.first.phoneNumber.toString()),
            children: supplier.supplierPhoneNumbers!.skip(1).map((phoneNumber) {
              return ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.phone),
                  onPressed: () {
                    makePhoneCall(phoneNumber.phoneNumber.toString());
                  },
                ),
                title: Text(phoneNumber.phoneNumber.toString()),
              );
            }).toList(),
          ),

        // Email
        (supplier?.email != null && supplier!.email!.isNotEmpty)
            ? ListTile(
          leading: IconButton(
            onPressed: () {
              launchEmailApp(toEmail: supplier?.email ?? '', subject: '', body: '');
            },
            icon: const Icon(Icons.mark_email_unread_outlined, color: Colors.redAccent),
          ),
          title: Text(supplier?.email ?? ''),
        )
            : const SizedBox(),

        // Map location
        (supplier?.mapLocation != null && supplier!.mapLocation!.isNotEmpty)
            ? ListTile(
          leading: IconButton(
            icon: const Icon(Icons.location_pin, color: Colors.red),
            onPressed: () {
              launchMapUrl(supplier?.mapLocation ?? '');
            },
          ),
          title: Text(supplier?.address ?? ''),
        )
            : const SizedBox(),

        // Facebook
        (supplier?.facebook != null && supplier!.facebook!.isNotEmpty)
            ? ListTile(
          leading: IconButton(
            icon: const Icon(Icons.facebook, color: Colors.blue),
            onPressed: () => launchFacebookUrl(supplier.facebook),
          ),
          title: const Text('فيسبوك'),
        )
            : const SizedBox(),
      ],
    );
  }



  Widget _buildFinancialSummary({required SupplierEntity? supplier}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSummaryCard('الرصيد', supplier!.supplierTotal.toString(), Colors.blue),
        _buildSummaryCard('المدفوع اليه', supplier.supplierPayed.toString(), Colors.green),
        _buildSummaryCard('المدفوع منه', supplier.supplierRemained.toString(), Colors.red),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(SizeManager.s_16),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.white)),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: SizeManager.s_16)),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalDetails({required SupplierEntity? supplier}) {
    return  ExpansionTile(
      title: const Text('بيانات التعاملات البنكيه'),
      children: [
        (supplier?.supplierFullName != null && supplier!.supplierFullName!.isNotEmpty) ?
        ListTile(
          title:  Text(StringManager.supplierFullName),
          subtitle: Text(supplier?.supplierFullName.toString() ?? '', style: const TextStyle(fontSize: SizeManager.s_20),),
        ) : const SizedBox(),

        (supplier?.supplierPostalCode != null && supplier!.supplierPostalCode!.isNotEmpty) ?
        ListTile(
          title:  Text(StringManager.supplierPostalCode),
          subtitle: Text(supplier?.supplierPostalCode.toString() ?? '', style: const TextStyle(fontSize: SizeManager.s_20),),
        ) : const SizedBox(),

        // bank infos
        if (supplier?.bankInfos != null && supplier!.bankInfos!.isNotEmpty)
          ExpansionTile(
            leading: IconButton(
              icon: const Icon(Icons.attach_money_rounded, color: Colors.green,),
              onPressed: () {
                // String phoneNumber = supplier.supplierPhoneNumbers!.first.phoneNumber.toString();
                // makePhoneCall(phoneNumber);
                // Your phone logic here
              },
            ),
            title: Text(supplier!.bankInfos!.first.bankName.toString()),
            subtitle: Text(supplier!.bankInfos!.first.bankAccount.toString()),
            children: supplier.bankInfos!.skip(1).map((bankInfo) {
              return ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.attach_money_rounded, color: Colors.green,),
                  onPressed: () {},
                ),
                title: Text(bankInfo.bankName.toString()),
                subtitle: Text(bankInfo.bankAccount.toString()),
              );
            }).toList(),
          ),

          ListTile(
          title: const Text(StringManager.suppliernotes),
          subtitle: Text(supplier?.notes.toString() ?? ''),
        ),
      ],
    );
  }

  Widget _buildFooterButtons({required SupplierEntity supplier}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            RouteGenerator.navigationTo(AppRoutes.supplierPaymentsScreen,arguments: supplier);
          },
          child: const Text('سجل المدفوعات'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            RouteGenerator.navigationTo(AppRoutes.supplierInvoicesScreen,arguments: supplier);
          },
          child: const Text('فواتير'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            RouteGenerator.navigationTo(AppRoutes.supplierItemsScreen,arguments: supplier);
          },
          child: const Text('منتجات'),
        ),
      ],
    );
  }
}