import 'dart:convert';

import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
import 'package:eltawfiq_suppliers/model/invoice_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class InvoiceDetailsScreen extends StatefulWidget {
  const InvoiceDetailsScreen({super.key, required this.invId});

  final int invId;

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {

  @override
  void initState() {
    super.initState();
    getData();
  }

  InvoiceModel? invoice;

  getData()async{
    final response = await  http.get(
        Uri.parse('${ApiConstance.baseUrl}/api/auth/getInvoiceWithPaymentsAndItems?id=${widget.invId}'),
    );
    if(response.statusCode == 200){
      var responseBody = response.body;
      var jsn = json.decode(responseBody)['invoice'];
      InvoiceModel invoiceModel = InvoiceModel.fromJson(jsn);
      setState(() {
        invoice = invoiceModel;
      });
    }else{
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('فاتورة'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
           //crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 const Text('فاتوره رقم'),
                 Text(invoice!.id.toString()),
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 const Text('تاريخ الفاتوره'),
                 Text(invoice!.invDate.toString()),
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 const Text('اسم المورد'),
                 Text(invoice!.invoiceSupplier!.supplierName!),
               ],
             ),
             const Divider(),
             ListView.builder(
               shrinkWrap: true,
               physics: const BouncingScrollPhysics(),
               itemCount: invoice!.items!.length,
                 itemBuilder: (context, index){
                 return ListTile(
                   onTap: (){
                     // Provider.of<AppStateProvider>(context,listen: false).changeCurrentItem(newItem:  itemsStateProvider.getItemsForSectionResult![index]);
                     // RouteGenerator.navigationTo(AppRoutes.itemDetailsScreenRoute);
                   },
                   title: Text(
                    invoice!.items![index].itemName.toString(),
                     style: const TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 18
                     ),
                   ),
                   leading: Text((index+1).toString()),
                   subtitle: Row(
                     children: [
                       Text('${invoice!.items![index].itemQuantity} * ${invoice!.items![index].itemPrice}'),
                       const Text(' = '),
                       Text('${invoice!.items![index].itemTotal}',style: const TextStyle(
                         fontSize: 14,
                         fontWeight: FontWeight.bold
                       ),),
                     ],
                   ),
                   trailing: Image.network(
                     ApiConstance.getImage(invoice!.items![index].itemImageUrl),
                     height: 100,
                     width: 100,
                   ),
                 );
                 },
             ),
             const Divider(),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 const Text('الاجمالي'),
                 Text(invoice!.total.toString()),
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 const Text('المدفوع'),
                 Text(invoice!.payedAmount.toString()),
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 const Text('المتبقي'),
                 Text(invoice!.remainedAmount.toString()),
               ],
             ),
             const Divider(),
             const Text('صورة الفاتوره'),
             Image.network(
               fit: BoxFit.cover,
               ApiConstance.getImage(invoice!.invoiceImageUrl?? ''),
               height: 300,
               width: 250,
             )
           ],
          ),
        ),
      ),
    );
  }

}
