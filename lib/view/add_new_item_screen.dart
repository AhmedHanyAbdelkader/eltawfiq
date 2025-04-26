import 'dart:io';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/model/item_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;



class AddNewItemScreen extends StatefulWidget {
  const AddNewItemScreen({super.key});

  @override
  State<AddNewItemScreen> createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {

  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemCodeController = TextEditingController();
  TextEditingController purchasingPriceController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController suppliersController = TextEditingController();
  int? suppId;

  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if(image == null) return;
  //     final imageTemp = File(image.path);
  //     setState(() => this.image = imageTemp);
  //   } on PlatformException catch(e) {
  //     print('Failed to pick image: $e');
  //   }
  // }


  File? image;
  Future<File> compressImage(File file) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    final compressedImage = img.encodeJpg(image!, quality: 85); // Adjust quality as needed

    final tempDir = await getTemporaryDirectory();
    final compressedFile = File('${tempDir.path}/${path.basename(file.path)}');
    await compressedFile.writeAsBytes(compressedImage);

    return compressedFile;
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      final compressedImage =await compressImage(imageTemp);
      setState(() => this.image = compressedImage);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  void _showPickerDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('معرض الصور'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('الكاميرا'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }


  String _scannedBarcode = 'Unknown';

  Future<void> scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.BARCODE,
    );

    if (barcodeScanRes != '-1') {
      setState(() {
        _scannedBarcode = barcodeScanRes;
      });
      // Store the scanned barcode

      //await DatabaseHelper.instance.insertItem(barcodeScanRes);
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration.zero, () {
        Provider.of<AppStateProvider>(context, listen: false).getSuppliers(
          id:1
          //Provider.of<AuthStateProvider>(context, listen: false).loginResult!.user!.id!,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AppStateProvider myProvider = Provider.of<AppStateProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('اضافة منتج جديد'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('اسم المنتج'),
              TextFormField(
                controller: itemNameController,
                keyboardType: TextInputType.text,
                validator: (newValue){
                  if(newValue == null || newValue.isEmpty){
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
                onChanged: (String newPayedAmount){
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder()
                ),
              ),
              const Text('كود المنتج'),
              TextFormField(
                controller: itemCodeController,
                keyboardType: TextInputType.text,
                validator: (newValue){
                  if(newValue == null || newValue.isEmpty){
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
                onChanged: (String newValue){},
                decoration: const InputDecoration(
                    border: OutlineInputBorder()
                ),
              ),
              ElevatedButton(
                onPressed: () => _showPickerDialog(context),
                child: const Text('اختر صوره'),
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 250,
                color: Colors.grey[300],
                child: image != null
                    ? Image.file(image!, fit: BoxFit.cover)
                    : const Text('Please select an image'),
              ),
              ElevatedButton(
                  onPressed: (){
                    scanBarcode();
                  },
                  child: const Text('scanner'),
              ),
              BarcodeWidget(
                barcode: Barcode.code128(),
                data: _scannedBarcode,
              ),
              const Text('سعر الشراء'),
              TextFormField(
                controller: purchasingPriceController,
                keyboardType: TextInputType.number,
                validator: (newValue){
                  if(newValue == null || newValue.isEmpty){
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
                onChanged: (String newPayedAmount){
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder()
                ),
              ),
              const Text('سعر البيع'),
              TextFormField(
                controller: sellingPriceController,
                keyboardType: TextInputType.number,
                validator: (newValue){
                  if(newValue == null || newValue.isEmpty){
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
                onChanged: (String newPayedAmount){
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20,),
              Consumer<AppStateProvider>(
                  builder: (context, suppliersStateProvider, _){
                    if(suppliersStateProvider.getItemsForSectionIsLoading){
                      return const Center(child: CircularProgressIndicator.adaptive(),);
                    }else if(suppliersStateProvider.getSuppliersErrorMessage.isNotEmpty){
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
                    }else if(suppliersStateProvider.getSuppliersResult != null){
                      return DropdownMenu<dynamic>(
                        width: MediaQuery.of(context).size.width * 0.95,
                        controller: suppliersController,
                        textStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        onSelected: (newSupplier){
                          setState(() {
                            suppId = newSupplier;
                          });
                        },
                        label: const Text('اختر مورد هذا المنتج'),
                        dropdownMenuEntries: suppliersStateProvider.getSuppliersResult!.map(
                                (e) => DropdownMenuEntry(
                              label: e.supplierName!,
                              labelWidget: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        e.supplierName!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,// Prevents overflow with ellipsis
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              value: e.supplierId,
                              enabled: true,
                              style: const ButtonStyle(),
                            ),

                        ).toList(),
                      );


                      //   ListView.separated(
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   itemCount: suppliersStateProvider.getSuppliersResult!.length,
                      //   separatorBuilder: (context, index)=> const Divider(),
                      //   itemBuilder: (context, index){
                      //     return ListTile(
                      //       onTap: (){
                      //         Provider.of<AppStateProvider>(context,listen: false).changeCurrentISupplier(newSupplier:  suppliersStateProvider.getSuppliersResult![index]);
                      //         RouteGenerator.navigationTo(AppRoutes.supplierScreenRoute);
                      //       },
                      //       title: Text(
                      //         suppliersStateProvider.getSuppliersResult![index].supplierName,
                      //         style: const TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 18
                      //         ),
                      //       ),
                      //       subtitle: SelectableText(
                      //         suppliersStateProvider.getSuppliersResult![index].supplierPhoneNumber,
                      //         style: const TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 18
                      //         ),
                      //       ),
                      //       leading: Text((index+1).toString()),
                      //       trailing: suppliersStateProvider.getSuppliersResult![index].supplierWhatsappNumber != null
                      //           ? IconButton(
                      //         onPressed: () {
                      //           String forrmattedWhatsappNumber = formatPhoneNumber(suppliersStateProvider.getSuppliersResult![index].supplierWhatsappNumber!);
                      //           launchWhatsAppUri(whatsappNumber: forrmattedWhatsappNumber);
                      //         },
                      //
                      //         icon: const Icon(Icons.chat, color: Colors.green,),
                      //       ): null,
                      //     );
                      //   },
                      // );
                    }
                    return const Center(child: CircularProgressIndicator.adaptive(),);
                  }
              ),
              const SizedBox(height: 20,),

              Consumer<AppStateProvider>(
                builder: (context, appState, _) {
                  // Check loading state
                  if (appState.addItemIsLoading) {
                    return const CircularProgressIndicator.adaptive(); // Show loading indicator
                  } else if (appState.addItemErrorMessage.isNotEmpty) {
                    return Text('Error: ${appState.addItemErrorMessage}'); // Show error message if any
                  } else if (appState.addItemResult != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم اضافة المنتج بنجاح')),
                    );
                    return const Text('Item added successfully!'); // Show success message if item added
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        appState.addItem(addNewItemParameters: AddNewItemParameters(
                          sectionId: myProvider.currentSection!.id,
                          purchasingPrice: double.parse(purchasingPriceController.text),
                          itemImage: image!,
                          itemName: itemNameController.text,
                          itemSupplierId: suppId!,
                          sellingPrice: double.parse(sellingPriceController.text),
                          barcode: _scannedBarcode,
                          itemCode: itemCodeController.text,
                        ));
                      },
                      child: const Text('إضافة منتج'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
