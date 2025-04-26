// import 'dart:io';
// import 'package:colins_tex/core/services/export_to_excel_service.dart';
// import 'package:colins_tex/core/services/printing_service.dart';
// import 'package:colins_tex/core/use_case/base_use_case.dart';
// import 'package:colins_tex/suppliers/domain/entities/permission_entity.dart';
// import 'package:colins_tex/suppliers/domain/entities/permission_item_entity.dart';
// import 'package:colins_tex/suppliers/presentation/controllers/delete_permission_controller.dart';
// import 'package:colins_tex/suppliers/presentation/controllers/get_permission_controller.dart';
// import 'package:colins_tex/suppliers/presentation/controllers/permissions_controller.dart';
// import 'package:colins_tex/suppliers/presentation/screens/edit_store_permission_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
//
//
// class PermissionDetailsScreen extends StatefulWidget {
//   const PermissionDetailsScreen({super.key, required this.permissionId});
//   final int permissionId;
//
//   @override
//   State<PermissionDetailsScreen> createState() => _PermissionDetailsScreenState();
// }
//
// class _PermissionDetailsScreenState extends State<PermissionDetailsScreen> {
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<GetPermissionController>(context, listen: false).getPermission(widget.permissionId);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Consumer<GetPermissionController>(
//         builder: (context, permissionController, _){
//           if (permissionController.getPermissionIsLoading) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: const Text('تفاصيل اذن الاستلام المخزني'),
//                 automaticallyImplyLeading: true,
//               ),
//               body: const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//           else if (permissionController.getPermissionErrorMessage.isNotEmpty) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: const Text('تفاصيل اذن الاستلام المخزني'),
//                 automaticallyImplyLeading: true,
//               ),
//               body: Center(
//                 child: Text(permissionController.getPermissionErrorMessage),
//               ),
//             );
//           }
//           else if (permissionController.gettingPermission == null) {
//             return const Center(
//               child: Text('No stores available'),
//             );
//           }
//           else{
//             return Scaffold(
//               appBar: AppBar(
//                 title: const Text('تفاصيل اذن الاستلام المخزني'),
//                 actions: [
//                   IconButton(
//                     onPressed: (){
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => EditStorePermissionScreen(invoiceData: permissionController.gettingPermission!),
//                         ),
//                       );
//
//                     },
//                     icon: const Icon(Icons.edit),
//                   ),
//                   IconButton(
//                     onPressed: (){
//                       showDialog(
//                         context: context,
//                         builder: (context){
//                           return AlertDialog(
//                             title: Text('حذف اذن استلام'),
//                             content: Text('متأكد من حذف اذن الاستلام ${permissionController.gettingPermission!.props}'),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.of(context).pop(),
//                                 child: const Text('Cancel'),
//                               ),
//                               ElevatedButton(
//                                 onPressed: ()async{
//                                   final deletePermissionController = Provider.of<DeletePermissionController>(context, listen: false);
//                                   await deletePermissionController.deletePermission(permissionController.gettingPermission!.id);
//                                   Provider.of<PermissionsController>(context, listen: false).getPermission(const NoParameters());
//                                   Navigator.of(context).pop();
//                                   if (deletePermissionController.deletePermissionResult != null) {
//                                     Navigator.of(context).pop();
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: Text(
//                                           deletePermissionController.deletePermissionErrorMessage +
//                                               'deleted successfully',
//                                         ),
//                                       ),
//                                     );
//                                   } else {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                           content: Text(deletePermissionController
//                                               .deletePermissionErrorMessage)),
//                                     );
//                                   }
//                                 },
//                                 child: Text('حذف'),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     icon: const Icon(Icons.delete_forever),
//                   ),
//                 ],
//               ),
//               body: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildInfoCard('التاريخ', permissionController.gettingPermission?.date ?? ''),
//
//                       _buildSectionTitle('تفاصيل المورد'),
//                       _buildInfoCard('اسم المورد', permissionController.gettingPermission?.supplier.name?? ''),
//
//                       _buildSectionTitle('تفاصيل الأذن'),
//                       _buildInfoCard('رقم الأذن', permissionController.gettingPermission!.permissionNo.toString()),
//                       _buildInfoCard('رقم المورد في الأذن', permissionController.gettingPermission!.supPerNo.toString()),
//
//                       _buildInfoCard('إجمالي', permissionController.gettingPermission!.total.toString()),
//                       _buildInfoCard('مدفوع', permissionController.gettingPermission!.paid.toString()),
//                       _buildInfoCard('متبقي', permissionController.gettingPermission!.remain.toString()),
//                       _buildInfoCard('ملاحظة', permissionController.gettingPermission?.remark ?? ''),
//
//                       _buildSectionTitle('الاصناف في هذا الاذن'),
//                       _buildItemsListViewCard(permissionController.gettingPermission!.permissionItemEntity ?? []),
//                       _buildSectionTitle('صورة الأذن'),
//                       _buildImage(permissionController.gettingPermission?.imgUrl ?? ''),
//
//                       _buildSectionTitle('تفاصيل المستخدم'),
//                       _buildInfoCard('اسم الموظف', permissionController.gettingPermission!.employeeName.toString()),
//                       _buildInfoCard('معرف المستخدم', permissionController.gettingPermission!.user.id.toString()),
//                       _buildInfoCard('اسم المستخدم', permissionController.gettingPermission!.user.name.toString()),
//
//                     ],
//                   ),
//                 ),
//               ),
//               floatingActionButton: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   FloatingActionButton(
//                     backgroundColor: Colors.blueAccent,
//                     onPressed: () {
//                       printOrders(permission: permissionController.gettingPermission);
//                     },
//                     tooltip: 'print',
//                     child: const Icon(
//                       Icons.print,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(width: 25,),
//                   FloatingActionButton(
//                     backgroundColor: Colors.green,
//                     onPressed: () {
//                       exportToExcel(
//                         permissionController.gettingPermission!,
//                       );
//                     },
//                     tooltip: 'export to excel',
//                     child: const Icon(
//                       Icons.file_copy_rounded,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 20.0,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoCard(String label, String value) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListTile(
//           title: Text(label),
//           subtitle: Text(value),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildItemsListViewCard(List<PermissionItemEntity> permissionItems){
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView.separated(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: permissionItems.length,
//           separatorBuilder: (context, index) => const Divider(),
//           itemBuilder: (context, index){
//             double total = (permissionItems[index].quntity ?? 0) * (permissionItems[index].price ?? 0).toDouble();
//             return ListTile(
//               leading: Text((index+1).toString()),
//               title: Text(permissionItems[index].item?.name.toString() ?? ''),
//               subtitle: Text('${permissionItems[index].quntity.toString()} * ${permissionItems[index].price.toString()}'),
//               trailing: Text(total.toString()),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildImage(String imageUrl) {
//     const placeholderImage = 'https://via.placeholder.com/150'; // Your placeholder image URL
//     final displayImage = (imageUrl.isEmpty || imageUrl == 'null') ? placeholderImage : imageUrl;
//
//     return Center(
//       child: Card(
//         child: displayImageWidget(displayImage),
//       ),
//     );
//   }
//   Widget displayImageWidget(String imageUrl) {
//     try {
//       return Image.network(
//         imageUrl,
//         fit: BoxFit.cover,
//         errorBuilder: (context, error, stackTrace) {
//           return Image.network(
//             'https://via.placeholder.com/150', // Your placeholder image URL
//             fit: BoxFit.cover,
//           );
//         },
//       );
//     } catch (e) {
//       return Image.network(
//         'https://via.placeholder.com/150', // Your placeholder image URL
//         fit: BoxFit.cover,
//       );
//     }
//   }
//
// }
//
//
//
//
//
//
//
//






import 'dart:io';

import 'package:eltawfiq_suppliers/core/resources/assets_manager.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_invoice_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/invoice/invoice_by_id_controller.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class InvoiceDetailsScreen extends StatefulWidget {
   const InvoiceDetailsScreen({super.key, required this.invId});
   final int invId;

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {

  Uint8List? pdfFileBytes;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<InvoiceByIdController>(context, listen: false).getInvoiceByIds(widget.invId);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('عرض الفاتوره'),
      ),
      body: Consumer<InvoiceByIdController>(
        builder: (context, invoiceController , _){
          if(invoiceController.getInvoiceByIdsIsLoading){
            return const Center(child: CircularProgressIndicator.adaptive(),);
          }
          if(invoiceController.getInvoiceByIdsErrorMessage.isNotEmpty){
            return Center(
              child: Text(invoiceController.getInvoiceByIdsErrorMessage),
            );
          }
          if (invoiceController.gettingInvoiceByIds == null) {
            return const Center(
              child: Text('No Invoices available'),
            );
          }
          else{
            return PdfPreview(
              allowPrinting: true,
              allowSharing: true,
              canChangePageFormat: true,
              canChangeOrientation: true,
              canDebug: false,
              dynamicLayout: true,
              enableScrollToPage: true,
              initialPageFormat: PdfPageFormat.a4,
              build: (format) => generatePdf(permission: invoiceController.gettingInvoiceByIds),
            );
          }
        },
      ),
    );
  }
}




Future<Uint8List> generatePdf({SupplierInvoiceEntity? permission}) async {
  final products = permission!.invoiceItems;
  String createdAt = intl.DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String invDate = intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(permission.invDate ?? '2000-07-01'));

  final ByteData logoByteData = await rootBundle.load(ImageManager.logo);
  final Uint8List logoBytes = logoByteData.buffer.asUint8List();
  final logoImage = pw.MemoryImage(logoBytes);

  final fontData = await rootBundle.load('assets/fonts/Amiri-Regular.ttf');
  final boldFontData = await rootBundle.load('assets/fonts/Amiri-Bold.ttf');
  final ttf = pw.Font.ttf(fontData);
  final boldTtf = pw.Font.ttf(boldFontData);

  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      build: (context) => [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              permission.type == "from supplier" ? 'فاتورة مشتريات' :
              permission.type == "to supplier" ? 'مرتجعات لمورد' :
              permission.type == "from client" ? 'مرتجعات من عميل' :
              'فاتورة عميل / ممبيعات',
              style: pw.TextStyle(fontSize: 24, font: boldTtf),
            ),
            pw.Image(logoImage, width: 100, height: 100),
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('الاسم: ${permission.supplier?.supplierName ?? ''}', style: pw.TextStyle(font: ttf)),
                pw.Text('كود: ${permission.supplier?.id ?? ''}', style: pw.TextStyle(font: ttf)),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('كود الفاتوره: ${permission.id}', style: pw.TextStyle(font: ttf)),
                pw.Text('تاريخ الفاتوره: $invDate', style: pw.TextStyle(font: ttf)),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Text('الاصناف:', style: pw.TextStyle(fontSize: 18, font: boldTtf)),
        pw.TableHelper.fromTextArray(
          headers: [
            'الاجمالي',
            'السعر',
            'القطعة',
            'دستة',
            'كرتونة',
            'اسم المنتج',
            'كود المنتج',
            'م'
          ],
          data: List<List<String>>.generate(products!.length, (index) {
            final product = products[index];
            return [
              '${product.itemTotal} EG',
              '${product.itemPrice}',
              '${product.ketaa ?? '-'}',
              '${product.dasta ?? '-'}',
              '${product.kartona ?? '-'}',
              (product.item?.name.toString() ?? ''),
              '${product.id}',
              '${index + 1}',
            ];
          }),
          border: pw.TableBorder.all(),
          cellStyle: pw.TextStyle(font: ttf),
          headerStyle: pw.TextStyle(font: boldTtf),
          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
          cellAlignment: pw.Alignment.centerRight,
          columnWidths: {
            0: const pw.FlexColumnWidth(1),
            1: const pw.FlexColumnWidth(1),
            2: const pw.FlexColumnWidth(1),
            3: const pw.FlexColumnWidth(1),
            4: const pw.FlexColumnWidth(1),
            5: const pw.FlexColumnWidth(2),
            6: const pw.FlexColumnWidth(1),
            7: const pw.FlexColumnWidth(0.5),
          },
        ),
        pw.SizedBox(height: 20),
        pw.Text('الاجمالى: ${permission.total} EG', style: pw.TextStyle(font: ttf)),
        pw.Text('المدفوع: ${permission.payedAmount} EG', style: pw.TextStyle(font: ttf)),
        pw.Text('المتبقي: ${permission.remainedAmount} EG', style: pw.TextStyle(font: ttf)),
        pw.SizedBox(height: 20),
        pw.Text('اسم الموظف: ${permission.user?.name ?? ''}', style: pw.TextStyle(font: ttf)),
      ],
      textDirection: pw.TextDirection.rtl,
      theme: pw.ThemeData.withFont(
        base: ttf,
        bold: boldTtf,
      ),
      footer: (context) {
        return pw.Container(
          alignment: pw.Alignment.center,
          margin: const pw.EdgeInsets.only(top: 2.0 * PdfPageFormat.cm),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              pw.Text(
                'صفحة ${context.pageNumber} من ${context.pagesCount}',
                style: pw.TextStyle(color: PdfColors.grey, font: ttf),
              ),
              pw.Text(
                ' سُجل بواسطة ${permission.user?.name ?? ''}',
                style: pw.TextStyle(color: PdfColors.grey, font: ttf),
              ),
              pw.Text(
                'تاريخ طباعة الفاتورة: $createdAt',
                style: pw.TextStyle(color: PdfColors.grey, font: ttf),
              ),
            ],
          ),
        );
      },
    ),
  );

  return pdf.save();
}

// Future<Uint8List> generatePdf({SupplierInvoiceEntity? permission}) async {
//   final products = permission!.invoiceItems;
//   String createdAt = intl.DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
//   String invDate = intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(permission.invDate ?? '2000-07-01'));
//
//   final ByteData logoByteData = await rootBundle.load(ImageManager.logo);
//   final Uint8List logoBytes = logoByteData.buffer.asUint8List();
//   final logoImage = pw.MemoryImage(logoBytes);
//
//   final fontData = await rootBundle.load('assets/fonts/Amiri-Regular.ttf');
//   final boldFontData = await rootBundle.load('assets/fonts/Amiri-Bold.ttf');
//   final ttf = pw.Font.ttf(fontData);
//   final boldTtf = pw.Font.ttf(boldFontData);
//
//   final pdf = pw.Document();
//
//   pdf.addPage(
//     pw.MultiPage(
//       pageFormat: PdfPageFormat.a4,
//       margin: const pw.EdgeInsets.symmetric(horizontal: 35, vertical: 15),
//       build: (context) => [
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             if (permission.type == "from supplier")
//               pw.Text(
//                 'فاتورة مشتريات',
//                 style: pw.TextStyle(fontSize: 24, font: boldTtf),
//               ),
//             if (permission.type == "to supplier")
//               pw.Text(
//                 'مرتجعات لمورد',
//                 style: pw.TextStyle(fontSize: 24, font: boldTtf),
//               ),
//             if (permission.type == "from client")
//               pw.Text(
//                 'مرتجعات من عميل',
//                 style: pw.TextStyle(fontSize: 24, font: boldTtf),
//               ),
//             if (permission.type == "to client")
//               pw.Text(
//                 'فاتورة عميل / ممبيعات',
//                 style: pw.TextStyle(fontSize: 24, font: boldTtf),
//               ),
//             pw.Image(logoImage, width: 100, height: 100),
//           ],
//         ),
//         pw.SizedBox(height: 20),
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text('الاسم: ${permission.supplier?.supplierName ?? ''}',
//                     style: pw.TextStyle(font: ttf)),
//                 pw.Text('كود: ${permission.supplier?.id ?? ''}',
//                     style: pw.TextStyle(font: ttf)),
//               ],
//             ),
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text('كود الفاتوره: ${permission.id}',
//                     style: pw.TextStyle(font: ttf)),
//                 pw.Text('تاريخ الفاتوره: $invDate',
//                     style: pw.TextStyle(font: ttf)),
//               ],
//             ),
//           ],
//         ),
//         pw.SizedBox(height: 20),
//         pw.Text('الاصناف:',
//             style: pw.TextStyle(fontSize: 18, font: boldTtf)),
//         pw.TableHelper.fromTextArray(
//           headers: [
//             'الاجمالي',
//             'السعر',
//             'الكميه',
//             //'اسم المخزن',
//             //'كود المخزن',
//             //'الوحده',
//             'اسم المنتج',
//             'كود المنتج',
//             'م'
//           ],
//           data: List<List<String>>.generate(products!.length, (index) {
//             final product = products[index];
//             double total = (product.itemPrice?? 1 * product.itemQuantity!).toDouble();
//             return [
//               '$total EG',
//               '${product.itemPrice}',
//               '${product.itemQuantity}',
//               //(product.item?.unitEntity?.name ?? ''),
//               (product.item?.name.toString() ?? ''),
//               '${product.id}',
//               '${index + 1}',
//             ];
//           }),
//           border: pw.TableBorder.all(),
//           cellStyle: pw.TextStyle(font: ttf),
//           headerStyle: pw.TextStyle(font: boldTtf),
//           headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
//           cellAlignment: pw.Alignment.centerRight,
//           columnWidths: {
//             0: const pw.FlexColumnWidth(1),
//             1: const pw.FlexColumnWidth(1),
//             2: const pw.FlexColumnWidth(1),
//             3: const pw.FlexColumnWidth(2),
//             4: const pw.FlexColumnWidth(1),
//             5: const pw.FlexColumnWidth(0.5),
//             //6: const pw.FlexColumnWidth(1),
//             //7: const pw.FlexColumnWidth(1),
//           },
//         ),
//         pw.SizedBox(height: 20),
//         pw.Text('الاجمالى: ${permission.total} EG',
//             style: pw.TextStyle(font: ttf)),
//         pw.Text('المدفوع: ${permission.payedAmount} EG',
//             style: pw.TextStyle(font: ttf)),
//         pw.Text('المتبقي: ${permission.remainedAmount} EG',
//             style: pw.TextStyle(font: ttf)),
//         pw.SizedBox(height: 20),
//         pw.Text('اسم الموظف: ${permission.user?.name ?? ''}',
//             style: pw.TextStyle(font: ttf)),
//       ],
//       textDirection: pw.TextDirection.rtl,
//       theme: pw.ThemeData.withFont(
//         base: ttf,
//         bold: boldTtf,
//       ),
//       footer: (context) {
//         return pw.Container(
//           alignment: pw.Alignment.center,
//           margin: const pw.EdgeInsets.only(top: 2.0 * PdfPageFormat.cm),
//           child: pw.Row(
//             mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
//             children: [
//               pw.Text(
//                 'صفحة ${context.pageNumber} من ${context.pagesCount}',
//                 style: pw.TextStyle(color: PdfColors.grey, font: ttf),
//               ),
//               pw.Text(
//                 ' سُجل بواسطة ${permission.user?.name ?? ''}',
//                 style: pw.TextStyle(color: PdfColors.grey, font: ttf),
//               ),
//               pw.Text(
//                 'تاريخ طباعة الفاتورة: $createdAt',
//                 style: pw.TextStyle(color: PdfColors.grey, font: ttf),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
//
//   return pdf.save();
// }
