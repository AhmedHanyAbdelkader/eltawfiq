import 'dart:io';

import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/item_operations_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

class ItemOperationsScreen extends StatefulWidget {
  const ItemOperationsScreen({super.key, required this.itemEntity});
  final ItemEntity itemEntity;

  @override
  State<ItemOperationsScreen> createState() => _ItemOperationsScreenState();
}

class _ItemOperationsScreenState extends State<ItemOperationsScreen> {

  DateTime? currentDate = DateTime.now();
  String formattedDate = '';

  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });

      if (_startDate != null && _endDate != null) {

      }
    }
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemOperationsController>(context, listen: false).getItemOperations(widget.itemEntity.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('حركة الصنف : ${widget.itemEntity.name ?? widget.itemEntity.name}'),
          automaticallyImplyLeading: true,
        ),
        body: Column(
          children: [
            if(Platform.isWindows) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _selectDate(context, true),
                    child: Text(_startDate == null ? 'تاريخ البداية' : 'بداية من : ${intl.DateFormat('yyyy-MM-dd').format(_startDate!)}'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => _selectDate(context, false),
                    child: Text(_endDate == null ? 'تاريخ النهاية' : 'انتهاء ب ${intl.DateFormat('yyyy-MM-dd').format(_endDate!)}'),
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(side: const BorderSide()),
                    onPressed: () {
                      if (_startDate != null && _endDate != null) {
                        // Map<String, dynamic> parameters = {
                        //   "startDate": intl.DateFormat('yyyy-MM-dd').format(_startDate!).toString(),
                        //   "endDate": intl.DateFormat('yyyy-MM-dd').format(_endDate!).toString(),
                        //   "itemid": widget.itemEntity.id!,
                        // };
                        //Provider.of<ItemOperationsControllers>(context, listen: false).getItemOperationsByDate(parameters);
                      }
                    },
                    child: const Text('بحث'),
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                    onPressed: () {
                      Provider.of<ItemOperationsController>(context, listen: false).getItemOperations(widget.itemEntity.id!);
                    },
                    icon: const Icon(Icons.filter_alt_off),
                  ),
                ],
              ),
            if(Platform.isAndroid || Platform.isIOS) Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDate(context, true),
                      child: Text(_startDate == null ? 'تاريخ البداية' : 'بداية من : ${intl.DateFormat('yyyy-MM-dd').format(_startDate!)}'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () => _selectDate(context, false),
                      child: Text(_endDate == null ? 'تاريخ النهاية' : 'انتهاء ب ${intl.DateFormat('yyyy-MM-dd').format(_endDate!)}'),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(side: const BorderSide()),
                      onPressed: () {
                        if (_startDate != null && _endDate != null) {
                          // Map<String, dynamic> parameters = {
                          //   "startDate": intl.DateFormat('yyyy-MM-dd').format(_startDate!).toString(),
                          //   "endDate": intl.DateFormat('yyyy-MM-dd').format(_endDate!).toString(),
                          //   "itemid": widget.itemEntity.id!,
                          // };
                          //Provider.of<ItemOperationsControllers>(context, listen: false).getItemOperationsByDate(parameters);
                        }
                      },
                      child: const Text('بحث'),
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    Provider.of<ItemOperationsController>(context, listen: false)
                        .getItemOperations(widget.itemEntity.id!);
                  },
                  icon: const Icon(Icons.filter_alt_off),
                ),
              ],
            ),

            Expanded(
              child: Consumer<ItemOperationsController>(
                builder: (context, itemOperationsControllers, _) {
                  if (itemOperationsControllers.getItemOperationsIsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (itemOperationsControllers.getItemOperationsErrorMessage.isNotEmpty) {
                    return Center(
                      child: Text(itemOperationsControllers.getItemOperationsErrorMessage),
                    );
                  } else if (itemOperationsControllers.gettingItemOperations == null ||
                      itemOperationsControllers.gettingItemOperations!.isEmpty) {
                    return const Center(
                      child: Text('No operations available'),
                    );
                  } else {
                    return Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: DataTable(
                                  border: TableBorder.all(),
                                  columns: const [
                                    DataColumn(label: Text('تاريخ الحركه الصنف', textAlign: TextAlign.center)),
                                    DataColumn(label: Text('رقم الاذن', textAlign: TextAlign.center)),
                                    DataColumn(label: Text('من مورد', textAlign: TextAlign.center)),
                                    DataColumn(label: Text('مرتجع الي مورد', textAlign: TextAlign.center)),
                                    DataColumn(label: Text('مرتجع من عميل', textAlign: TextAlign.center)),
                                    DataColumn(label: Text('الي عميل', textAlign: TextAlign.center)),
                                    DataColumn(label: Text('اجمالي الحركه', textAlign: TextAlign.center)),
                                  ],
                                  rows: _buildRows(itemOperationsControllers),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildRows(ItemOperationsController controllers) {
    final rows = <DataRow>[];
    double runningTotal = 0;

    for (var item in controllers.gettingItemOperations!) {
      final fromSupplier = item.type == 'from supplier' ? item.itemQuantity!.toInt() : 0;
      final toSupplier = item.type == 'to supplier' ? - item.itemQuantity!.toInt() : 0;
      final fromClient = item.type == 'from client' ? item.itemQuantity!.toInt() : 0;
      final toClient = item.type == 'to client' ? - item.itemQuantity!.toInt() : 0;

      runningTotal += fromSupplier + toSupplier + fromClient + toClient;

      rows.add(DataRow(cells: [
        DataCell(Text(intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(item.permDate!)), textAlign: TextAlign.center),
        ),
        DataCell(
            onTap: (){
              RouteGenerator.navigationTo(AppRoutes.supplierInvoiceDetailsScreenRoute, arguments: item.invoiceId);
            },
            Text(item.invoiceId.toString(), textAlign: TextAlign.center)),
        DataCell(Text(item.type == 'from supplier' ? item.itemQuantity.toString() : '-', textAlign: TextAlign.center)),
        DataCell(Text(item.type == 'to supplier' ? item.itemQuantity.toString() : '-', textAlign: TextAlign.center)),
        DataCell(Text(item.type == 'from client' ? item.itemQuantity.toString() : '-', textAlign: TextAlign.center)),
        DataCell(Text(item.type == 'to client' ? item.itemQuantity.toString() : '-', textAlign: TextAlign.center)),
        DataCell(Text(runningTotal.toString(), textAlign: TextAlign.center)),
      ]));
    }

    // Add the footer row
    final totalFromSupplier = controllers.gettingItemOperations!
        .where((item) => item.type == 'from supplier')
        .fold(0, (sum, item) => sum + item.itemQuantity!.toInt());

    final totalToSupplier = controllers.gettingItemOperations!
        .where((item) => item.type == 'to supplier')
        .fold(0, (sum, item) => sum + item.itemQuantity!.toInt());

    final totalFromHall = controllers.gettingItemOperations!
        .where((item) => item.type == 'from client')
        .fold(0, (sum, item) => sum + item.itemQuantity!.toInt());

    final totalToHall = controllers.gettingItemOperations!
        .where((item) => item.type == 'to client')
        .fold(0, (sum, item) => sum + item.itemQuantity!.toInt());

    final totalOfTotals = totalFromSupplier - totalToSupplier + totalFromHall - totalToHall;


    rows.add(DataRow(
        cells: [
      const DataCell(Text('الاجماليات',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),)),
      const DataCell(Text('-',textAlign: TextAlign.center,)),
      DataCell(Text(
        totalFromSupplier.toString(),
        textAlign: TextAlign.center
    ,style: const TextStyle(fontWeight: FontWeight.bold),
      )),
      DataCell(Text(
        totalToSupplier.toString(),
        textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),
      )),
      DataCell(Text(
        totalFromHall.toString(),
        textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),
      )),
      DataCell(Text(
        totalToHall.toString(),
        textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),
      )),
      DataCell(Text(totalOfTotals.toString(),textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),),),
    ]));

    return rows;
  }
}