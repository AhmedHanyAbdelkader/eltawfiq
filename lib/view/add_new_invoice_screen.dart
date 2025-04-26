import 'dart:developer';
import 'dart:io';
import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/model/invoice_model.dart';
import 'package:eltawfiq_suppliers/model/item_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddNewInvoiceScreen extends StatefulWidget {
  const AddNewInvoiceScreen({super.key});

  @override
  State<AddNewInvoiceScreen> createState() => _AddNewInvoiceScreenState();
}

class _AddNewInvoiceScreenState extends State<AddNewInvoiceScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, (){
      Provider.of<AppStateProvider>(context,listen: false).getSupplierItems(
          id: Provider.of<AppStateProvider>(context,listen: false).currentSupplier!.supplierId!);
      Provider.of<AppStateProvider>(context, listen: false).emptyTheInvoiceItems();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.newInvoice),
        ),
        body: const BuildAddNewInvoiceBodyWidget(),
          ),

    );
  }
}




class BuildAddNewInvoiceBodyWidget extends StatefulWidget {
  const BuildAddNewInvoiceBodyWidget({super.key});

  @override
  State<BuildAddNewInvoiceBodyWidget> createState() => _BuildAddNewInvoiceBodyWidgetState();
}

class _BuildAddNewInvoiceBodyWidgetState extends State<BuildAddNewInvoiceBodyWidget> {
  final TextEditingController itemsController = TextEditingController();
  final TextEditingController payedController = TextEditingController();

  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;
      final imageTemp = File(pickedImage.path);
      setState(() => image = imageTemp);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final invoices = Provider.of<AppStateProvider>(context, listen: false).currentSupplier!;
    final myProvider = Provider.of<AppStateProvider>(context, listen: false);
    //final authProvider = Provider.of<AuthStateProvider>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${StringManager.invoiceFrom} ${invoices.supplierName}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(DateTime.now().toLocal().toString()),
              Consumer<AppStateProvider>(
                builder: (context, invoiceTotalStateProvider, _){
                  return Text('اجمالي الفاتورة : ${invoiceTotalStateProvider.getInvoiceTotal} جنيه مصري');
                },
              ),
              // Consumer<AppStateProvider>(
              //   builder: (context, supplierItemsStateProvider, _){
              //     if(supplierItemsStateProvider.getSupplierItemsIsLoading == true){
              //       return const Center(child: CircularProgressIndicator.adaptive(),);
              //     }
              //     else if(supplierItemsStateProvider.getSupplierItemsErrorMessage.isNotEmpty){
              //       showDialog(
              //         context: context,
              //         builder: (context) => AlertDialog(
              //           title: const Text(StringManager.error),
              //           content: Text(supplierItemsStateProvider.getSupplierItemsErrorMessage),
              //           actions: [
              //             TextButton(
              //               onPressed: () {
              //                 Navigator.pop(context);
              //               },
              //               child: const Text(StringManager.ok),
              //             ),
              //           ],
              //         ),
              //       );
              //     }else if(supplierItemsStateProvider.getSupplierItemsResult != null){
              //       return Padding(
              //         padding: const EdgeInsets.all(15.0),
              //         child: DropdownMenu(
              //           width: MediaQuery.of(context).size.width * 0.8,
              //           controller: itemsController,
              //           textStyle: const TextStyle(
              //             color: Colors.black,
              //           ),
              //           label: const Text(StringManager.addItemsToInvoice,),
              //           dropdownMenuEntries: supplierItemsStateProvider.getSupplierItemsResult!.map(
              //                   (e) => DropdownMenuEntry(
              //                 label: StringManager.addItemsToInvoice,
              //                 labelWidget: Padding(
              //                   padding: const EdgeInsets.symmetric(vertical: 8.0),
              //                   child: Row(
              //                     children: [
              //                       SizedBox(
              //                         width: 80, // Ensure fixed width
              //                         height: 80, // Ensure fixed height
              //                         child: Image.network(
              //                           ApiConstance.getImage(e.itemImageUrl),
              //                           fit: BoxFit.cover, // Ensure the image fits within the container
              //                         ),
              //                       ),
              //                       const SizedBox(width: 8), // Add some spacing between the image and the text
              //                       Expanded(
              //                         child: Text(
              //                           e.itemName,
              //                           overflow: TextOverflow.ellipsis,
              //                           maxLines: 3,// Prevents overflow with ellipsis
              //                         ),
              //                       ),
              //                       IconButton(
              //                         onPressed: () async {
              //                           if (!supplierItemsStateProvider.getInvoiceItems.contains(e) && !e.isAdded) { // Check if the item is not already in the invoice
              //                             e.setAdded(true);
              //                             await supplierItemsStateProvider.addNewItemToInvoice(e);
              //                             await supplierItemsStateProvider.calculateInvoiceTotal();
              //                           }
              //                         },
              //                         icon: e.isAdded == true
              //                             ? const Icon(Icons.add_circle_outlined, color: Colors.purpleAccent,)
              //                             : const Icon(Icons.add_circle_outlined),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 value: e.itemId,
              //                 enabled: true,
              //                 style: const ButtonStyle(),
              //               )
              //
              //           ).toList(),
              //         ),
              //       );
              //       //   ListView.separated(
              //       //   shrinkWrap: true,
              //       //   physics: const NeverScrollableScrollPhysics(),
              //       //   itemCount: supplierItemsStateProvider.getSupplierItemsResult!.length,
              //       //   separatorBuilder: (context, index)=> const Divider(),
              //       //   itemBuilder: (context, index){
              //       //     return ListTile(
              //       //       onTap: (){
              //       //         Provider.of<AppStateProvider>(context,listen: false).changeCurrentItem(newItem: supplierItemsStateProvider.getSupplierItemsResult![index]);
              //       //         RouteGenerator.navigationTo(AppRoutes.itemDetailsScreenRoute);
              //       //       },
              //       //       title: Text(
              //       //         supplierItemsStateProvider.getSupplierItemsResult![index].itemName,
              //       //         style: const TextStyle(
              //       //             fontWeight: FontWeight.bold,
              //       //             fontSize: 18
              //       //         ),
              //       //       ),
              //       //       leading: Text((index+1).toString()),
              //       //       trailing: Image.network(
              //       //         ApiConstance.getImage(supplierItemsStateProvider.getSupplierItemsResult![index].itemImageUrl),
              //       //         height: 100,
              //       //         width: 100,
              //       //       ),
              //       //     );
              //       //   },
              //       // );
              //     }
              //     return const Center(child: CircularProgressIndicator.adaptive(),);
              //   },
              // ),

              const BuildAddItemsWidget(),

              Consumer<AppStateProvider>(
                  builder: (context, invoiceItemsStateProvider, _){
                    if(invoiceItemsStateProvider.getInvoiceItems.isNotEmpty){
                      return SizedBox(
                        // height: MediaQuery.of(context).size.height * 0.65,
                        child: ListView.separated(
                          separatorBuilder: (context, index)=> const Divider(),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: invoiceItemsStateProvider.getInvoiceItems.length,
                          itemBuilder: (context , index){
                            return Dismissible(
                              key: Key('${invoiceItemsStateProvider.getInvoiceItems[index].itemId}'),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('حذف',
                                        style: TextStyle(
                                            color: Colors.white
                                        ),),
                                      SizedBox(height: 10,),
                                      Icon(Icons.delete_forever,color: Colors.white,),
                                    ],
                                  ),
                                ),
                              ),
                              onDismissed: (DismissDirection dismissDirection){
                                setState(() {
                                  invoiceItemsStateProvider.getInvoiceItems[index].setAdded(false);
                                  invoiceItemsStateProvider.getInvoiceItems.removeAt(index);
                                  invoiceItemsStateProvider.calculateInvoiceTotal();
                                });
                              },
                              child: SizedBox(
                                height: 110,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.7,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(invoiceItemsStateProvider.getInvoiceItems[index].itemName,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                          const SizedBox(height: 10,),
                                          Text(' سعر الشراء : ${invoiceItemsStateProvider.getInvoiceItems[index].purchasingPrice}جنيه مصري '),
                                          Text(' الاجمالي : ${invoiceItemsStateProvider.getInvoiceItems[index].itemTotal == 0
                                              ? invoiceItemsStateProvider.getInvoiceItems[index].purchasingPrice
                                              : invoiceItemsStateProvider.getInvoiceItems[index].itemTotal
                                          } جنيه مصري '),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    BuildItemQuantityColumn(itemModel: invoiceItemsStateProvider.getInvoiceItems[index])
                                  ],
                                ),
                              ),
                            );

                            // ListTile(
                            //   trailing: Column(
                            //     children: [
                            //       const Icon(Icons.add),
                            //       SizedBox(
                            //           width: 30,
                            //           height: 8,
                            //           child: TextFormField()),
                            //       const Icon(Icons.minimize_outlined)
                            //     ],
                            //   ),
                            //   title: Text(invoiceItemsStateProvider.getInvoiceItems[index].itemName),
                            //   subtitle: Text(' سعر الشراء : ${invoiceItemsStateProvider.getInvoiceItems[index].purchasingPrice}جنيه مصري '),
                            // );
                          },
                        ),
                      );
                    }else {
                      return const Center(child: CircularProgressIndicator.adaptive(),);
                    }
                  }
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => pickImage(ImageSource.camera),
                    child: const Text('الكاميرا'),
                  ),
                  ElevatedButton(
                    onPressed: () => pickImage(ImageSource.gallery),
                    child: const Text('معرض الصور'),
                  ),
                ],
              ),


              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 300,
                color: Colors.grey[300],
                child: image != null
                    ? Image.file(image!, fit: BoxFit.cover)
                    : const Text('Please select an image'),
              ),
              const SizedBox(height: 20,),

              const SizedBox(height: 20,),
              const Text('المدفوع'),
              TextFormField(
                controller: payedController,
                keyboardType: TextInputType.number,
                validator: (newValue){
                  if(newValue == null || newValue.isEmpty){
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
                onChanged: (String newPayedAmount){
                  //remainedController.text = (supplier.total! -  (double.parse(newPayedAmount) + supplier.payed!) ).toString();
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20,),


              Consumer<AppStateProvider>(
                builder: (context, storeInvoiceStateProvider, _){
                  if(storeInvoiceStateProvider.storeInvoiceIsLoading){
                    return const Center(child: CircularProgressIndicator.adaptive(),);
                  }else if(storeInvoiceStateProvider.storeInvoiceErrorMessage.isNotEmpty){
                    log(storeInvoiceStateProvider.storeInvoiceErrorMessage);
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(storeInvoiceStateProvider.storeInvoiceErrorMessage),
                        ),
                      );
                    });
                  }else if(storeInvoiceStateProvider.storeInvoiceResult != null){
                    Future.microtask((){
                      Provider.of<AppStateProvider>(context,listen: false).getSupplierInvoices(
                          id: 1,
                          //Provider.of<AuthStateProvider>(context,listen: false).loginResult!.user!.id!,
                          supplierId:  Provider.of<AppStateProvider>(context,listen: false).currentSupplier!.supplierId!
                      );
                      Navigator.pop(context); // Close current dialog
                      RouteGenerator.navigationReplacementTo(AppRoutes.suppliersScreenRoute);
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> InvoiceDetailsScreen(
                      //   invId: supplierInvoiceStateProvider.getSupplierInvoicesResult![index].id,
                      // )));
                    });
                  }
                  return ElevatedButton(
                    onPressed: () async {
                      try{
                        storeInvoiceStateProvider.storeInvoice(
                          storeInvoiceParameters: StoreInvoiceParameters(
                            invSupplierId: invoices.supplierId!,
                            createdById: 1,
                            //authProvider.loginResult!.user!.id!,
                            total: double.parse(myProvider.getInvoiceTotal.toString()),
                            payedAmount: double.parse(payedController.text),
                            remainedAmount: myProvider.getInvoiceTotal! - double.parse(payedController.text),
                            items: myProvider.getInvoiceItems,
                            imagePath: image!.path,
                          ),
                        );
                      }catch(e){
                        showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                content: Text(e.toString()),
                              );
                            }
                        );
                      }
                    },
                    child: const Text('انشاء الفاتوره'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class BuildAddItemsWidget extends StatelessWidget {
  const BuildAddItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        showDialog(
          context: context,
          builder: (context){
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: const Text('اختر الاصناف'),
                content: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Consumer<AppStateProvider>(
                    builder: (context, supplierItemsStateProvider, _){
                      if(supplierItemsStateProvider.getSupplierItemsIsLoading == true){
                        return const Center(child: CircularProgressIndicator.adaptive(),);
                      }
                      else if(supplierItemsStateProvider.getSupplierItemsErrorMessage.isNotEmpty){
                        showDialog(context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(StringManager.error),
                            content: Text(supplierItemsStateProvider.getSupplierItemsErrorMessage),
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
                      }
                      else if(supplierItemsStateProvider.getSupplierItemsResult != null){
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: supplierItemsStateProvider.getSupplierItemsResult!.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index){
                            return BuildInvoiceItemCard(itemModel: supplierItemsStateProvider.getSupplierItemsResult![index]);
                          },
                        );
                      }
                      return const Center(child: CircularProgressIndicator.adaptive(),);
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Text('اضف اصناف للفاتورة'),
    );
  }
}


class BuildInvoiceItemCard extends StatefulWidget {
   const BuildInvoiceItemCard({super.key, required this.itemModel});
  final ItemModel itemModel;

  @override
  State<BuildInvoiceItemCard> createState() => _BuildInvoiceItemCardState();
}

class _BuildInvoiceItemCardState extends State<BuildInvoiceItemCard> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController quantityController = TextEditingController(text: widget.itemModel.itemQuantity.toString());
    final TextEditingController priceController = TextEditingController(text: widget.itemModel.purchasingPrice.toString());
    return Card(
      elevation: 2.0,
      child: Row(
        children: [
          SizedBox(
            width: 50, // Set a fixed width
            height: 50, // Set a fixed height
            child: Image.network(
              ApiConstance.getImage(widget.itemModel.itemImageUrl),
              fit: BoxFit.cover, // Ensure the image covers the container
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(widget.itemModel.itemName),
                Row(
                  children: [
                    // Flexible(
                    //   flex: 1,
                    //   child: TextField(
                    //     controller: quantityController,
                    //     decoration: InputDecoration(
                    //       labelText: 'الكميه',
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //     ),
                    //     keyboardType: TextInputType.number,
                    //   ),
                    // ),
                    // const SizedBox(width: 10,),
                    Flexible(
                      flex: 1,
                      child: TextField(
                        controller: priceController,
                        decoration: InputDecoration(
                          labelText: 'السعر',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

      IconButton(
        onPressed: () async {
          if (!context.read<AppStateProvider>().getInvoiceItems.contains(widget.itemModel) && !widget.itemModel.isAdded) { // Check if the item is not already in the invoice
            widget.itemModel.setAdded(true);
            widget.itemModel.setItemPrice(int.parse(priceController.text));
            widget.itemModel.setItemQuantity(int.parse(quantityController.text));
            widget.itemModel.setItemTotal(int.parse(quantityController.text) * int.parse(priceController.text));
            await context.read<AppStateProvider>().addNewItemToInvoice(widget.itemModel);
            await context.read<AppStateProvider>().calculateInvoiceTotal();
          }
          },
        icon: widget.itemModel.isAdded == true
            ? const Icon(Icons.add_circle_outlined, color: Colors.purpleAccent,)
            : const Icon(Icons.add_circle_outlined),
      ),

        ],
      ),
    );
  }
}



class BuildItemQuantityColumn extends StatefulWidget {
  const BuildItemQuantityColumn({super.key, required this.itemModel});
  final ItemModel itemModel;

  @override
  State<BuildItemQuantityColumn> createState() => _BuildItemQuantityColumnState();
}

class _BuildItemQuantityColumnState extends State<BuildItemQuantityColumn> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController qtyController = TextEditingController(text: widget.itemModel.itemQuantity.toString());
    widget.itemModel.setItemQuantity(widget.itemModel.itemQuantity);
    //widget.itemModel.setItemTotal(widget.itemModel.itemQuantity * int.parse(source) ?? 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
          InkWell(
            onTap: (){
              widget.itemModel.setItemTotal((++widget.itemModel.itemQuantity) * (widget.itemModel.purchasingPrice)!.toInt());
              qtyController.text = widget.itemModel.itemQuantity.toString();
              Provider.of<AppStateProvider>(context, listen: false).calculateInvoiceTotal();
              //Provider.of<AppStateProvider>(context, listen: false).notifyListeners();
            },
              child: const Icon(Icons.add)),
        SizedBox(
          width: 60,
          height: 25,
          child: TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder()
            ),
            controller: qtyController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (String newValue){
              widget.itemModel.setItemQuantity(int.parse(newValue));
              widget.itemModel.setItemTotal(widget.itemModel.itemQuantity * (widget.itemModel.purchasingPrice)!.toInt());
              Provider.of<AppStateProvider>(context, listen: false).calculateInvoiceTotal();
              //Provider.of<AppStateProvider>(context, listen: false).notifyListeners();
            },
          ),
        ),
        InkWell(
          onTap: (){
            if(int.parse(qtyController.text) > 1){
              widget.itemModel.setItemTotal((--widget.itemModel.itemQuantity) * (widget.itemModel.purchasingPrice)!.toInt());
              qtyController.text = widget.itemModel.itemQuantity.toString();
              Provider.of<AppStateProvider>(context, listen: false).calculateInvoiceTotal();
              //Provider.of<AppStateProvider>(context, listen: false).notifyListeners();
            }
          },
            child: const Icon(Icons.minimize_outlined)),

      ],
    );
  }
}

