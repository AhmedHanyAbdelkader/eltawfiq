import 'dart:convert';
import 'dart:io';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:eltawfiq_suppliers/core/resources/const_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/shared_methods/scan_barcode.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/add_new_item_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/items_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/section/sections_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/suppliers_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/add_new_item_use_case.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {

  late TextEditingController _itemNameController;
  late TextEditingController _sectionIdController;
  late TextEditingController _sectionNameController;
  late TextEditingController _purchasingPriceController;
  late TextEditingController _sellingPriceController;
  late TextEditingController _itemSupplierIdController;
  late TextEditingController _itemSupplierNameController;
  late TextEditingController _itemCodeController;

  late TextEditingController dastaController;
  late TextEditingController kartonaController;
  late TextEditingController balanceKetaaController;
  late TextEditingController balanceDastaController;
  late TextEditingController balanceKartonaController;

  late GlobalKey<FormState> _formKey;

  final FocusNode _itemNameFocusNode = FocusNode();
  final FocusNode _sectionIdFocusNode = FocusNode();
  final FocusNode _sectionNameFocusNode = FocusNode();
  final FocusNode _purchasingPriceFocusNode = FocusNode();
  final FocusNode _sellingPriceFocusNode = FocusNode();
  final FocusNode _itemSupplierIdFocusNode = FocusNode();
  final FocusNode _itemSupplierNameFocusNode = FocusNode();
  final FocusNode _itemCodeFocusNode = FocusNode();
  final FocusNode _itemImageButtonFocusNode = FocusNode();

  final FocusNode dastaFocusNode = FocusNode();
  final FocusNode kartonaFocusNode = FocusNode();
  final FocusNode balanceKetaaFocusNode = FocusNode();
  final FocusNode balanceDastaFocusNode = FocusNode();
  final FocusNode balanceKartonaFocusNode = FocusNode();

  final FocusNode _addItemButtonFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
     _itemNameController = TextEditingController();
     _sectionIdController = TextEditingController();
     _sectionNameController = TextEditingController();
     _purchasingPriceController = TextEditingController();
     _sellingPriceController = TextEditingController();
     _itemSupplierIdController = TextEditingController();
     _itemSupplierNameController = TextEditingController();
     _itemCodeController = TextEditingController();

    dastaController = TextEditingController();
    kartonaController = TextEditingController();
    balanceKetaaController = TextEditingController(text: '0');
    balanceDastaController = TextEditingController(text: '0');
    balanceKartonaController = TextEditingController(text: '0');

     _formKey = GlobalKey<FormState>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchInitialData();
  }

  void _fetchInitialData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final supplierController = Provider.of<SupplierController>(context, listen: false);
      final sectionsController = Provider.of<SectionsController>(context, listen: false);
      supplierController.getSuppliers(const NoParameters());
      sectionsController.getSections(const NoParameters());
    });
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _sectionIdController.dispose();
    _sectionNameController.dispose();
    _purchasingPriceController.dispose();
    _sellingPriceController.dispose();
    _itemSupplierIdController.dispose();
    _itemSupplierNameController.dispose();
    _itemCodeController.dispose();

    super.dispose();
  }

  // File? image;
  // Future<File> compressImage(File file) async {
  //   final bytes = await file.readAsBytes();
  //   final image = img.decodeImage(bytes);
  //   final compressedImage = img.encodeJpg(image!, quality: 60); // Adjust quality as needed
  //
  //   final tempDir = await getTemporaryDirectory();
  //   final compressedFile = File('${tempDir.path}/${path.basename(file.path)}');
  //   await compressedFile.writeAsBytes(compressedImage);
  //
  //   return compressedFile;
  // }
  //
  // Future<void> pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;
  //     final imageTemp = File(image.path);
  //     final compressedImage =await compressImage(imageTemp);
  //     setState(() => this.image = compressedImage);
  //   } on PlatformException catch (e) {
  //     if (kDebugMode) {
  //       print('Failed to pick image: $e');
  //     }
  //   }
  // }

  List<String> images = [];

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
                  setState(() async{
                    images = await pickAndConvertImages(ImageSource.gallery);
                  });
                  Navigator.of(context).pop();
                },
              ),
              //if(Platform.isAndroid || Platform.isIOS)
                ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('الكاميرا'),
                onTap: () {
                  setState(() async{
                    images = await pickAndConvertImages(ImageSource.camera);
                  });
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

  Future<void> _startScan() async {
    final String? barcode = await scanBarcode();

    if (barcode != null) {
      setState(() {
        _scannedBarcode = barcode;
      });
    }
  }

  Future<List<String>> pickAndConvertImages(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    List<String> base64Images = [];
    List<XFile>? images = [];
    // Allow multiple image selection if supported by your implementation
    switch(source){
      case ImageSource.camera:
        final image = await ImagePicker().pickImage(source: source);
        images.add(image!);
      case ImageSource.gallery:
        images = await _picker.pickMultiImage();
    }

    if (images != null) {
      for (var image in images) {
        File imageFile = File(image.path);
        // Convert to base64
        String base64Image = base64Encode(await imageFile.readAsBytes());
        base64Images.add(base64Image);
      }
    }
    return base64Images;
  }

  @override
  Widget build(BuildContext context) {
    final addNewItemController = Provider.of<AddNewItemController>(context, listen: false);
    FocusScope.of(context).requestFocus(_itemNameFocusNode);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        child: AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          scrollable: true,
          title: const Text(StringManager.addNewItem),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextFormField(
                    focusNode: _itemNameFocusNode,
                    controller: _itemNameController,
                    label: StringManager.itemName,
                    validator: (value) => value!.isEmpty ? StringManager.fieldRequired : null,
                    onEditingComplete: (){
                      _itemNameFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_itemSupplierNameFocusNode);
                    }
                  ),
                  const SizedBox(height: SizeManager.s_8,),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: SizeManager.s_50,
                      child: TypeAheadFormField<SupplierEntity>(
                        textFieldConfiguration: TextFieldConfiguration(
                          focusNode: _itemSupplierNameFocusNode,
                          controller: _itemSupplierNameController,
                          decoration: InputDecoration(
                              labelText: StringManager.supplierName,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                          ),
                          onEditingComplete: (){
                            _itemSupplierNameFocusNode.unfocus();
                            FocusScope.of(context).requestFocus(_sectionNameFocusNode);
                          }
                        ),
                        suggestionsCallback: (pattern) {
                          final supplierController = Provider.of<SupplierController>(context, listen: false);
                          return supplierController.getSuggestions(pattern);
                        },
                        itemBuilder: (context, SupplierEntity suggestion) {
                          return ListTile(
                            title: Text(suggestion.supplierName ?? StringManager.emptyString),
                          );
                        },
                        onSuggestionSelected: (SupplierEntity suggestion) {
                          _itemSupplierNameController.text = suggestion.supplierName ?? StringManager.emptyString;
                          _itemSupplierIdController.text = suggestion.id.toString();
                          _itemSupplierNameFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(_sectionNameFocusNode);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: SizeManager.s_8,),
                  Flexible(
                    flex: ConstManager.c_1,
                    child: SizedBox(
                      height: SizeManager.s_50,
                      child: TypeAheadField<SectionEntity>(
                        textFieldConfiguration: TextFieldConfiguration(
                          focusNode: _sectionNameFocusNode,
                          controller: _sectionNameController,
                          decoration: InputDecoration(
                              labelText: StringManager.sections,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)
                              )
                          ),
                          onEditingComplete: (){
                            _sectionNameFocusNode.unfocus();
                            FocusScope.of(context).requestFocus(_purchasingPriceFocusNode);
                          }
                        ),
                        suggestionsCallback: (pattern) {
                          final supplierController = Provider.of<SectionsController>(context, listen: false);
                          return supplierController.getSuggestions(pattern);
                        },
                        itemBuilder: (context, SectionEntity suggestion) {
                          return ListTile(
                            title: Text(suggestion.sectionName ?? StringManager.emptyString),
                          );
                        },
                        onSuggestionSelected: (SectionEntity suggestion) {
                          _sectionNameController.text = suggestion.sectionName ?? StringManager.emptyString;
                          _sectionIdController.text = suggestion.id.toString();
                          _sectionNameFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(_purchasingPriceFocusNode);
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                    focusNode: _purchasingPriceFocusNode,
                    controller: _purchasingPriceController,
                    decoration: const InputDecoration(labelText: StringManager.itemPurshasingPrice),
                    keyboardType: TextInputType.number,
                    onEditingComplete: (){
                      _purchasingPriceFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_sellingPriceFocusNode);
                    },
                  ),
                  TextFormField(
                    focusNode: _sellingPriceFocusNode,
                    controller: _sellingPriceController,
                    decoration: const InputDecoration(labelText: StringManager.itemSellingPrice),
                    keyboardType: TextInputType.number,
                    onEditingComplete: (){
                      _sellingPriceFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_itemCodeFocusNode);
                    },
                  ),
                  TextFormField(
                    focusNode: _itemCodeFocusNode,
                    controller: _itemCodeController,
                    decoration: const InputDecoration(labelText: StringManager.itemCode),
                    keyboardType: TextInputType.text,
                    onEditingComplete: (){
                      _itemCodeFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(kartonaFocusNode);
                    },
                  ),
                  const SizedBox(height: SizeManager.s_16,),

                  TextFormField(
                    focusNode: kartonaFocusNode,
                    controller: kartonaController,
                    decoration: const InputDecoration(labelText: 'الكرتونه بها كام دسته؟'),
                    keyboardType: TextInputType.number,
                    onEditingComplete: (){
                      kartonaFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(dastaFocusNode);

                    },
                  ),
                  const SizedBox(height: SizeManager.s_16,),

                  TextFormField(
                    focusNode: dastaFocusNode,
                    controller: dastaController,
                    decoration: const InputDecoration(labelText: 'الدسته بها كام قطعه؟'),
                    keyboardType: TextInputType.number,
                    onEditingComplete: (){
                      dastaFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(balanceKartonaFocusNode);
                    },
                  ),
                  const SizedBox(height: SizeManager.s_16,),

                  TextFormField(
                    focusNode: balanceKartonaFocusNode,
                    controller: balanceKartonaController,
                    decoration: const InputDecoration(labelText: 'الرصيد بالكرتونه'),
                    keyboardType: TextInputType.number,
                    onEditingComplete: (){
                      balanceKartonaFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(balanceDastaFocusNode);
                    },
                  ),
                  const SizedBox(height: SizeManager.s_16,),

                  TextFormField(
                    focusNode: balanceDastaFocusNode,
                    controller: balanceDastaController,
                    decoration: const InputDecoration(labelText: 'الرصيد بالدسته'),
                    keyboardType: TextInputType.number,
                    onEditingComplete: (){
                      balanceDastaFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(balanceKetaaFocusNode);
                    },
                  ),
                  const SizedBox(height: SizeManager.s_16,),

                  TextFormField(
                    focusNode: balanceKetaaFocusNode,
                    controller: balanceKetaaController,
                    decoration: const InputDecoration(labelText: 'الرصيد بالقطعه'),
                    keyboardType: TextInputType.number,
                    onEditingComplete: (){
                      balanceKetaaFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_itemImageButtonFocusNode);
                    },
                  ),
                  const SizedBox(height: SizeManager.s_16,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: const Text('معرض الصور'),
                        onPressed: () {
                          setState(() async{
                            images = await pickAndConvertImages(ImageSource.gallery);
                          });
                          //Navigator.of(context).pop();
                        },
                      ),
                      //if(Platform.isAndroid || Platform.isIOS)
                      ElevatedButton(
                        child: const Text('الكاميرا'),
                        onPressed: () {
                          setState(() async{
                            images = await pickAndConvertImages(ImageSource.camera);
                          });
                          //Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),

                  // ElevatedButton(
                  //   focusNode: _itemImageButtonFocusNode,
                  //   onPressed: () => _showPickerDialog(context),
                  //   child: const Text('اختر صوره'),
                  // ),
                  // Container(
                  //   alignment: Alignment.center,
                  //   width: double.infinity,
                  //   height: 200,
                  //   color: Colors.grey[300],
                  //   child: images.isNotEmpty
                  //       ? Image.file(images.first, fit: BoxFit.cover)
                  //       : const Text('Please select an image'),
                  // ),
                  const SizedBox(height: SizeManager.s_16,),

                  if(Platform.isAndroid || Platform.isIOS)
                    Column(
                      children: [
                      BarcodeWidget(
                        height: SizeManager.s_50,
                        barcode: Barcode.code128(),
                        data: _scannedBarcode,
                      ),
                      Text("${StringManager.itemBarCode}${StringManager.colon} $_scannedBarcode"),
                      ElevatedButton(
                        onPressed: _startScan,
                        child: const Text(StringManager.scan),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  AddNewItemParameters addNewItemParameters = AddNewItemParameters(
                      itemName: _itemNameController.text,
                      itemCode: _itemCodeController.text,
                      barcode: _scannedBarcode,
                      sectionId: int.tryParse(_sectionIdController.text),
                      sellingPrice: double.tryParse(_sellingPriceController.text),
                      purchasingPrice: double.tryParse(_purchasingPriceController.text),
                      itemSupplierId: int.tryParse(_itemSupplierIdController.text),
                      images: images,

                      dasta: int.tryParse(dastaController.text),
                      kartona: int.tryParse(kartonaController.text),
                      balanceKetaa: int.tryParse(balanceKartonaController.text),
                      balanceDasta: int.tryParse(balanceDastaController.text),
                      balanceKartona: int.tryParse(balanceKartonaController.text),
                      //itemImageUrl: imageBinary.toString()
                  );
                  await addNewItemController.addNewItem(addNewItemParameters);
                  Provider.of<ItemsController>(context, listen: false).getItems(const NoParameters());
                  if (addNewItemController.addNewItemResult != null) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${addNewItemController.addNewItemErrorMessage}created successfully',),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                          Text(addNewItemController.addNewItemErrorMessage)),
                    );
                  }
                }
              },
              child: Consumer<AddNewItemController>(
                builder: (context, addNewItemController, _){
                  return addNewItemController.addNewItemIsLoading
                      ? const CircularProgressIndicator.adaptive()
                      : const Text(StringManager.add);
                },
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(StringManager.cancel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({validator, focusNode, controller, label, TextInputType inputType = TextInputType.text, onEditingComplete}) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: inputType,
      validator: validator,
      onEditingComplete: onEditingComplete,
    );
  }

}