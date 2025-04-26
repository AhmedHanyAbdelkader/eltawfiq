import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_payment_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/payment/get_supplier_payments_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/add_new_supplier_payment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class SupplierPaymentsScreen extends StatefulWidget {
  const SupplierPaymentsScreen({super.key, required this.supplier});
  final SupplierEntity supplier;
  @override
  State<SupplierPaymentsScreen> createState() => _SupplierPaymentsScreenState();
}

class _SupplierPaymentsScreenState extends State<SupplierPaymentsScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData();
  }

  _fetchData()async{
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetSupplierPaymentsPaymentsController>(context, listen: false).getSupplierPayments(widget.supplier.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${StringManager.payments} ${widget.supplier.supplierName}'),
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          showDialog(
              context: context,
              builder: (context){
                return AddSupplierPaymentDialog(supplier: widget.supplier,);
              },
          );
        },
      ),
      body: Consumer<GetSupplierPaymentsPaymentsController>(
        builder: (context, paymentsController, _){
          if(paymentsController.getSupplierPaymentsIsLoading){
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if(paymentsController.getSupplierPaymentsErrorMessage.isNotEmpty){
            return Center(
              child: Text(paymentsController.getSupplierPaymentsErrorMessage),
            );
          }
          if(paymentsController.gettingSupplierPayments == null || paymentsController.gettingSupplierPayments!.isEmpty){
            return const Center(
              child: Text('No Payments available'),
            );
          }
          else{
            return PaymentsListView(payments: paymentsController.gettingSupplierPayments,);
          }
        },
      ),
    );
  }


}


class PaymentsListView extends StatelessWidget {
  const PaymentsListView({super.key, required this.payments});
  final List<SupplierPaymentEntity>? payments;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index){
          final SupplierPaymentEntity supplierPaymentEntity = payments![index];
          return ListTile(
            leading: _buildImageViewer(supplierPaymentEntity: supplierPaymentEntity, context: context),

          //   supplierPaymentEntity.paymentImage != null
          // ? Container(
          // width: 100,
          //   height: 150,
          //   margin: const EdgeInsets.symmetric(horizontal: 5.0),
          //   child: CachedMemoryImage(
          //     uniqueKey: supplierPaymentEntity.paymentImage ?? '',
          //     errorWidget: Center(child: const Text('Error')),
          //     base64: supplierPaymentEntity.paymentImage,
          //     //height: MediaQuery.of(context).size.height * 0.4,
          //     fit: BoxFit.cover,
          //     placeholder: const Center(
          //       child: Icon(
          //         Icons.image,  // Replace with your desired placeholder icon or widget
          //         size: 40,
          //         color: Colors.grey, // Customize the color
          //       ),
          //     ),
          //   ),
          // )
          //     : const SizedBox(
          // width: 100,
          // height: 150,
          // child: Icon(
          // Icons.image,  // Replace with your desired placeholder icon or widget
          // size: 40,
          // color: Colors.grey, // Customize the color
          // )
          // ),

            title: Text(intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(supplierPaymentEntity.paymentDate.toString()))),
            trailing: Column(
              children: [
                Text('مدفوع ${supplierPaymentEntity.payedAmountFromSupplierTotal.toString()}'),
                //Text('متبقي ${supplierPaymentEntity.remainedAmountFromSupplierTotal.toString()}'),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: payments!.length,
    );
  }

  Widget _buildImageViewer({required SupplierPaymentEntity supplierPaymentEntity, required context}) {
    return supplierPaymentEntity.paymentImage != null
        ? GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImage(
              base64Image: supplierPaymentEntity.paymentImage ?? '',
            ),
          ),
        );
      },
      child: Container(
        width: 100,
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: CachedMemoryImage(
          uniqueKey: supplierPaymentEntity.paymentImage ?? '',
          errorWidget: Center(child: const Text('Error')),
          base64: supplierPaymentEntity.paymentImage,
          fit: BoxFit.cover,
          placeholder: const Center(
            child: Icon(
              Icons.image,
              size: 40,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    )
        : const SizedBox(
      width: 100,
      height: 150,
      child: Icon(
        Icons.image,
        size: 40,
        color: Colors.grey,
      ),
    );
  }

}






class FullScreenImage extends StatelessWidget {
  final String base64Image;

  const FullScreenImage({Key? key, required this.base64Image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: CachedMemoryImage(
          uniqueKey: base64Image,
          errorWidget: const Center(child: Text('Error loading image', style: TextStyle(color: Colors.white))),
          base64: base64Image,
          fit: BoxFit.contain,
          placeholder: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}


