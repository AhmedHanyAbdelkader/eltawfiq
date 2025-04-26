import 'dart:convert';
import 'dart:io';
import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/payment/add_new_supplier_payment_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/payment/add_new_supplier_payment_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/payment/get_supplier_payments_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/suppliers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class AddSupplierPaymentDialog extends StatefulWidget {
  const AddSupplierPaymentDialog({super.key, this.supplier});
  final SupplierEntity? supplier;
  @override
  State<AddSupplierPaymentDialog> createState() => _AddSupplierPaymentDialogState();
}

class _AddSupplierPaymentDialogState extends State<AddSupplierPaymentDialog> {


  final TextEditingController _supplierIdController = TextEditingController();
  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _payedController = TextEditingController();
  final TextEditingController _remainedController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _supplierNameFocusNode = FocusNode();
  final _payedFocusNode = FocusNode();
  final _remainedFocusNode = FocusNode();
  final _dateButtonFocusNode = FocusNode();
  final _addPaymentButtonFocusNode = FocusNode();

  DateTime? currentDate = DateTime.now();
  String formattedDate = '';


  @override
  void initState() {
    super.initState();
    _payedController.addListener(_updateRemainingAmount);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      formattedDate = intl.DateFormat('yyyy-MM-dd').format(currentDate!);
      FocusScope.of(context).requestFocus(_payedFocusNode);
      Provider.of<SupplierController>(context, listen: false).getSuppliers(const NoParameters());
      _supplierIdController.text = widget.supplier!.id.toString();
      _supplierNameController.text = widget.supplier!.supplierName.toString();
    });
  }

  void _updateRemainingAmount() {
    double paid = double.tryParse(_payedController.text) ?? 0.0;
    double remain = (widget.supplier?.supplierRemained ?? 0.0) - paid;
    _remainedController.text = remain.toString();
  }

  @override
  void dispose() {
    _supplierIdController.dispose();
    _supplierNameController.dispose();
    _payedController.dispose();
    _remainedController.dispose();

    _supplierNameFocusNode.dispose();
    _payedFocusNode.dispose();
    _remainedFocusNode.dispose();
    _dateButtonFocusNode.dispose();
    _addPaymentButtonFocusNode.dispose();
    super.dispose();
  }

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

  Future<List<String>> pickAndConvertImages(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    List<String> base64Images = [];

    List<XFile>? images = [];
    // Allow multiple image selection if supported by your implementation
    switch(source){
      case ImageSource.camera:
        final image = await ImagePicker().pickImage(source: source,);
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
    final addNewSupplierPaymentController = Provider.of<AddNewSupplierPaymentController>(context, listen: false);
    return AlertDialog.adaptive(
      title: const Text('مدفوعه جديده'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                focusNode: _payedFocusNode,
                controller: _payedController,
                decoration: const InputDecoration(labelText: 'مدفوع'),
                validator: (value) => value!.isEmpty ? 'يجب ادخال المبلغ المدفوع ' : null,
                onEditingComplete: (){
                  _payedFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(_remainedFocusNode);
                },
              ),
              TextFormField(
                focusNode: _remainedFocusNode,
                controller: _remainedController,
                decoration: const InputDecoration(labelText: 'المتبقي'),
                validator: (value) => value!.isEmpty ? 'يجب ادخال البلغ المتبقي ' : null,
                onEditingComplete: (){
                  _remainedFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(_supplierNameFocusNode);
                },
              ),
              const SizedBox(height: SizeManager.s_16,),
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: 40,
                  child: TypeAheadField<SupplierEntity>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _supplierNameController,
                      focusNode: _supplierNameFocusNode,
                      decoration: InputDecoration(
                          labelText: 'الاسم',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                      onEditingComplete: () {
                        _supplierNameFocusNode.unfocus();
                        FocusScope.of(context).requestFocus(_dateButtonFocusNode);
                      },
                    ),
        
                    suggestionsCallback: (pattern) {
                      final supplierController = Provider.of<SupplierController>(context, listen: false);
                      return supplierController.getSuggestions(pattern);
                    },
                    itemBuilder: (context, SupplierEntity suggestion) {
                      return ListTile(
                        title: Text(suggestion.supplierName ?? ''),
                      );
                    },
                    onSuggestionSelected: (SupplierEntity suggestion) {
                      _supplierNameController.text = suggestion.supplierName ?? '';
                      _supplierIdController.text = suggestion.id.toString();
                      _supplierNameFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_dateButtonFocusNode);
                    },
        
        
                  ),
                ),
              ),
              const SizedBox(height: SizeManager.s_16,),
              MaterialButton(
                focusNode: _dateButtonFocusNode,
                height: SizeManager.s_50,
                minWidth: SizeManager.s_250,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: const BorderSide(color: Colors.black)
                ),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  setState(() {
                    currentDate = pickedDate;
                    formattedDate = intl.DateFormat('yyyy-MM-dd').format(currentDate!);
                  });
                  FocusScope.of(context).requestFocus(_addPaymentButtonFocusNode);
                },
                child: Text('التاريخ $formattedDate'),
              ),
              const SizedBox(height: SizeManager.s_16,),
              ElevatedButton(
                //focusNode: _itemImageButtonFocusNode,
                onPressed: () => _showPickerDialog(context),
                child: const Text('اختر صوره'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(StringManager.cancel),
        ),
        ElevatedButton(
          focusNode: _addPaymentButtonFocusNode,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await addNewSupplierPaymentController.addNewSupplierPayment(
                AddNewSupplierPaymentParameters(
                  supplierId: int.tryParse(_supplierIdController.text),
                  payed: double.tryParse(_payedController.text),
                  remained: double.tryParse(_remainedController.text),
                  paymentImage: images.first,
                  date: formattedDate,
                  type: widget.supplier!.isSup == true ? 'out' : 'in',
                ),
              );
              Provider.of<GetSupplierPaymentsPaymentsController>(context, listen: false).getSupplierPayments(widget.supplier!.id!);
              if (addNewSupplierPaymentController.addNewSupplierPaymentResult != null) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${addNewSupplierPaymentController.addNewSupplierPaymentErrorMessage}created successfully',
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                      Text(addNewSupplierPaymentController.addNewSupplierPaymentErrorMessage)),
                );
              }
            }
          },
          child: Consumer<AddNewSupplierPaymentController>(
            builder: (context, addPaymentController, _){
              return addPaymentController.addNewSupplierPaymentIsLoading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text(StringManager.add);
            },
          ),
        ),
      ],
    );
  }
}