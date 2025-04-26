import 'dart:convert';
import 'dart:developer';
import 'package:eltawfiq_suppliers/model/company_model.dart';
import 'package:eltawfiq_suppliers/model/group_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
import 'package:eltawfiq_suppliers/model/invoice_model.dart';
import 'package:eltawfiq_suppliers/model/item_model.dart';
import 'package:eltawfiq_suppliers/model/payment_model.dart';
import 'package:eltawfiq_suppliers/model/section_model.dart';
import 'package:eltawfiq_suppliers/model/supplier_model.dart';

class AppDataSource {
  static const baseUrl = '${ApiConstance.baseUrl}/api'; // Replace with your actual API base URL

  Future<int> addItem({required AddNewItemParameters addNewItemParameters}) async {
    final uri = Uri.parse('$baseUrl/auth/AddNewItem');
    final request = http.MultipartRequest('POST', uri);

    request.fields['item_name'] = addNewItemParameters.itemName;
    request.fields['section_id'] = addNewItemParameters.sectionId.toString();
    request.fields['purchasing_price'] = addNewItemParameters.purchasingPrice.toString();
    request.fields['selling_price'] = addNewItemParameters.sellingPrice.toString();
    request.fields['item_supplier_id'] = addNewItemParameters.itemSupplierId.toString();
    request.fields['barcode'] = addNewItemParameters.barcode.toString();
    request.fields['item_code'] = addNewItemParameters.itemCode.toString();

    // // Ensure the file is correctly attached
    // final imageFile = await http.MultipartFile.fromPath(
    //   'item_image',
    //   addNewItemParameters.itemImage.path,
    //   filename: basename(addNewItemParameters.itemImage.path),
    //   contentType: MediaType('image', 'jpeg'), // Adjust the media type if needed
    // );
    // request.files.add(imageFile);

    request.files.add(
      await http.MultipartFile.fromPath('item_image', addNewItemParameters.itemImage.path),
    );


    try {
      final response = await request.send();
      //final responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 201) {
        return response.statusCode;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<ItemModel>> searchItems({required String query, required int userId}) async {
    final url = Uri.parse('$baseUrl/auth/searchItems?query=$query&id=$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var responseBody = response.body;
      List data = json.decode(responseBody)['items'];
      List<ItemModel> items = List.from(
        data.map((e) => ItemModel.fromJson(e),),
      );
      return items;
    } else {
      throw Exception('Failed to load items ${response.statusCode}');
    }
  }


Future<List<SectionModel>> getAllSections()async{
  try{
    final response = await http.get(Uri.parse('$baseUrl/auth/getAllSections'));
    if(response.statusCode == 200){
      var responseBodey = response.body;
      List data = json.decode(responseBodey)['sections'];
      List<SectionModel> sections = List.from(
        data.map((e) => SectionModel.fromJson(e),),
      );
      sections.sort((a,b) => a.order.compareTo(b.order));
      return sections;
    }else{
      throw Exception(response.body);
    }
  }catch(error){
    throw Exception(error);
  }
}

  Future<void> updateSuppliersOrder(List<SupplierModel> suppliers) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/updateSupplierOrder'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'suppliers': suppliers.map((supplier) => {'supplier_id': supplier.supplierId, 'order': suppliers.indexOf(supplier)}).toList(),
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update supplier order');
    }
  }



  Future<void> updateSectionsOrder(List<SectionModel> sections) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/updateSectionOrder'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'sections': sections.map((section) => {'sec_id': section.id, 'order': sections.indexOf(section)}).toList(),
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update section order');
    }
  }

  Future<SectionModel> createSection({required String sectorName, required String sectorImagePath}) async {
    try{
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/auth/addNewSection?section_name=$sectorName'),
      );
      request.files.add(await http.MultipartFile.fromPath('section_image', sectorImagePath));
      final response = await request.send();
      if (response.statusCode == 201) {
        var responseBody =await  response.stream.bytesToString();
        var jsn = jsonDecode(responseBody)['section'];
        if (kDebugMode) {
          print(jsn);
        }
        SectionModel sectionModel = SectionModel.fromJson(jsn);
        return sectionModel;
      } else {
        var responseBody = await response.stream.bytesToString();
        throw Exception(responseBody);
      }
    }catch(error){
      throw Exception(error);
    }

  }

  Future<List<ItemModel>> getItemsForSection({required int sectionId, required int userId})async{
    try{
      final response = await http.get(
        Uri.parse('$baseUrl/auth/getItemsBySectionId?section_id=$sectionId&id=$userId'),
      ).timeout(
          const Duration(seconds: 30),
        onTimeout: () {
          // Handle timeout
          throw Exception('Request timed out');
        },
      );
      if(response.statusCode == 200){
        var responseBody = response.body;
        List data = json.decode(responseBody)['items'];
        List<ItemModel> items = List.from(
          data.map((e) => ItemModel.fromJson(e),),
        );
        items.sort((a, b) => a.itemOrder!.compareTo(b.itemOrder as num));
        return items;
      }else{
        throw Exception(response.body);
      }
    }catch(error){
      throw Exception(error);
    }
  }

  Future<void> updateItemsOrder(List<ItemModel> items) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/updateItemsOrder'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'items': items.map((item) => {'item_id': item.itemId, 'item_order': items.indexOf(item)}).toList(),
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update items order');
    }
  }


  // Future<SupplierModel>createSupplier({
  //   required String supplierName,
  //    String? supplierPhoneNumber,
  //    String? supplierWhatsappNumber,})async
  // {
  //   try{
  //     final response = await http.post(Uri.parse('$baseUrl/auth/createSupplier?supplier_name=$supplierName'
  //         '&supplier_phone_number=$supplierPhoneNumber'
  //         '&supplier_whatsapp_number=$supplierWhatsappNumber'));
  //     if(response.statusCode == 201){
  //       var responseBody = response.body;
  //       var jsn = json.decode(responseBody)['supplier'];
  //       SupplierModel supplierModel = SupplierModel.fromJson(jsn);
  //       return supplierModel;
  //     }else{
  //       throw Exception(json.decode(response.body));
  //     }
  //   }catch(error){
  //     print(error);
  //     throw Exception(error);
  //   }
  // }
  //


  Future<SupplierModel?> createSupplier({
    required SupplierModel supplier,
    required token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/createSupplier'),
        headers:  <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(supplier.toJson()),
      );

      if (response.statusCode == 201) {
        var responseBody = response.body;
        var jsn = json.decode(responseBody)['supplier'];
        return SupplierModel.fromJson(jsn);
      }
      else {
        throw Exception(json.decode(response.body));
      }
    } catch (error) {
      throw Exception(error);
    }
  }


  Future<List<SupplierModel>>getSuppliers({required int id})async{
  try{
    final response = await http.get(Uri.parse('$baseUrl/auth/getAllSuppliers?id=$id'));
    if(response.statusCode == 200){
      var responseBody = response.body;
      log(responseBody);
      List jsn = json.decode(responseBody)['suppliers'];
      List<SupplierModel> suppliers = List.from(
        jsn.map((e) => SupplierModel.fromJson(e),
        ),
      );
      suppliers.sort((a,b) => a.order!.compareTo(b.order as num));
      return suppliers;
    }else{
      throw Exception(json.decode(response.body));
    }
  }catch(e){
    throw Exception(e.toString());
  }
  }

  Future<List<ItemModel>>getSupplierItems({required int id})async{
    try{
      final response = await http.get(Uri.parse('$baseUrl/auth/getSupplierItems?id=$id'));
      if(response.statusCode == 200){
        var responseBody = response.body;
        List jsn = json.decode(responseBody)['items'];
        List<ItemModel> items = List.from(
          jsn.map((e) => ItemModel.fromJson(e),
          ),
        );
        return items;
      }else{
        throw Exception(json.decode(response.body));
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }


  Future<List<InvoiceModel>>getSupplierInvoices({required int id, required int supplierId})async{
    try{
      final response = await http.get(Uri.parse('$baseUrl/auth/getSupplierInvoices?id=$id&supplier_id=$supplierId'));
      if(response.statusCode == 200){
        var responseBody = response.body;
        List jsn = json.decode(responseBody)['invoices'];
        List<InvoiceModel> invoices = List.from(
          jsn.map((e) => InvoiceModel.fromJson(e),
          ),
        );
        return invoices;
      }else{
        throw Exception(json.decode(response.body));
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<List<PaymentModel>>getSupplierPayments({required int supplierId}) async{
    try{
      final response = await http.get(Uri.parse('$baseUrl/auth/getSupplierPayments?supplier_id=$supplierId'));
      if(response.statusCode == 200){
        var responseBody = response.body;
        List jsn = json.decode(responseBody)['data'];
        List<PaymentModel> supplierPayments = List.from(
            jsn.map((e) => PaymentModel.fromJson(e))
        );
        return supplierPayments;
      }else{
        throw Exception(json.decode(response.body));
      }
    }catch(e){
      throw Exception(e.toString());
    }

  }

  Future<PaymentModel> makeSupplierPayment({
    required int supplierId,
    required int payedAmountFromSupplierTotal,
    required int remainedAmountFromSupplierTotal,
  })async {
    try{
      final response = await http.post(
        Uri.parse('$baseUrl/auth/makeSupplierPayment?supplier_id=$supplierId'
            '&payed_amount_from_supplier_total=$payedAmountFromSupplierTotal&remained_amount_from_supplier_total=$remainedAmountFromSupplierTotal'));
    if (response.statusCode == 201) {
      var responseBody = response.body;
      var jsn = json.decode(responseBody)['data'];
      PaymentModel paymentModel = PaymentModel.fromJson(jsn);
      return paymentModel;
    } else {
      throw Exception(json.decode(response.body));
    }
  }catch(e){
    throw Exception(e.toString());
    }
  }

  Future<int> storeInvoice(StoreInvoiceParameters storeInvoiceParameters) async {
    try {
      final uri = Uri.parse('${ApiConstance.baseUrl}/api/auth/store');
      final request = http.MultipartRequest('POST', uri);

      request.fields['inv_supplier_id'] = storeInvoiceParameters.invSupplierId.toString();
      request.fields['created_by_id'] = storeInvoiceParameters.createdById.toString();
      request.fields['total'] = storeInvoiceParameters.total.toString();
      request.fields['payed_amount'] = storeInvoiceParameters.payedAmount.toString();
      request.fields['remained_amount'] = storeInvoiceParameters.remainedAmount.toString();

      for (int i = 0; i < storeInvoiceParameters.items.length; i++) {
        request.fields['items[$i][item_id]'] = storeInvoiceParameters.items[i].itemId.toString();
        request.fields['items[$i][item_quantity]'] = storeInvoiceParameters.items[i].itemQuantity.toString();
        request.fields['items[$i][item_price]'] = storeInvoiceParameters.items[i].itemPrice.toString();
      }

      // for (int i = 0; i < storeInvoiceParameters.items.length; i++) {
      //   print(storeInvoiceParameters.items[i].itemPrice);
      //   print(storeInvoiceParameters.items[i].itemTotal);
      // }



      if (storeInvoiceParameters.imagePath.isNotEmpty ) {
        request.files.add(
          await http.MultipartFile.fromPath('invoice_image', storeInvoiceParameters.imagePath),
        );
      }
      // Send the request
      final response = await request.send();

      // Handle the response
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 201) {
        return response.statusCode;
      } else {
        try {
          // Try to decode the response body as JSON
          final error = json.decode(responseBody);
          log('Error response: ${json.encode(error)}');  // Convert the map to a string for logging
          throw Exception(json.encode(error));  // Convert the map to a string for the exception message
        } catch (e) {
          // If decoding fails, log the raw response body
          log('Raw response: $responseBody');
          throw Exception(responseBody);
        }
      }
    } catch (e) {
      log('Exception: $e');
      throw Exception(e.toString());
    }
  }




  Future<List<CompanyModel>> getAllCompanies(String token) async {
    final response = await http.get(
        Uri.parse('$baseUrl/auth/getAllCompanies'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    );
    if (response.statusCode == 200) {
      var responseBody = response.body;
      List jsn = json.decode(responseBody)['companies'];
      List<CompanyModel> companies = List.from(jsn.map((company) => CompanyModel.fromJson(company)));
      return companies;
    } else {
      throw Exception('Failed to load companies ${response.body.toString()}');
    }
  }




  Future<CompanyModel> getCompany({required String token, required int id}) async {
    final response = await http.get(
        Uri.parse('$baseUrl/auth/getCompany?id=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }
    );
    if (response.statusCode == 200) {
      var responseBody = response.body;
      var jsn = json.decode(responseBody)['company'];
      CompanyModel company = CompanyModel.fromJson(jsn);
      return company;
    } else {
      throw Exception('Failed to load company ${response.body.toString()}');
    }
  }



  Future<CompanyModel> createCompany({required String token, required CompanyModel company}) async {
    final response = await http.post(
        Uri.parse('$baseUrl/auth/createCompany'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      body: json.encode(company.toJson()),
    );
    if (response.statusCode == 201) {
      var responseBody = response.body;
      var jsn = json.decode(responseBody)['company'];
      CompanyModel company = CompanyModel.fromJson(jsn);
      return company;
    } else {
      throw Exception('Failed to load company ${response.body.toString()}');
    }
  }



  Future<List<GroupModel>> getAllGroups(String token) async {
    final response = await http.get(
        Uri.parse('$baseUrl/auth/getAllGroups'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }
    );
    if (response.statusCode == 200) {
      var responseBody = response.body;
      List jsn = json.decode(responseBody)['groups'];
      List<GroupModel> groups = List.from(jsn.map((company) => GroupModel.fromJson(company)));
      return groups;
    } else {
      throw Exception('Failed to load groups ${response.body.toString()}');
    }
  }



  Future<GroupModel> createGroup({required String token, required GroupModel group}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/createGroup'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(group.toJson()),
    );
    if (response.statusCode == 201) {
      var responseBody = response.body;
      var jsn = json.decode(responseBody)['group'];
      GroupModel group = GroupModel.fromJson(jsn);
      return group;
    } else {
      throw Exception('Failed to load group ${response.body.toString()}');
    }
  }





  Future<List<SupplierModel>> searchSuppliers(String query) async {
    final url = Uri.parse('$baseUrl/auth/suppliers/search?query=$query');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var responseBody = response.body;
      List jsn = json.decode(responseBody)['suppliers'];
      List<SupplierModel> suppliers = List.from(jsn.map((supplier) => SupplierModel.fromJson(supplier)));
      return suppliers;
    } else {
      throw Exception('Failed to search supplier ${response.body.toString()}');
    }
  }



}