import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:eltawfiq_suppliers/authentication/data/data_source/local_data_source/shred_prefs_helper.dart';
import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/item_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({super.key, required this.item});
  final ItemEntity? item;

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final itemDetailsController = Provider.of<ItemDetailsController>(context, listen: false);
      itemDetailsController.getItemDetails(widget.item!.id!);
    });
  }


  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  late String? role;
  getUserRole()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper(prefs);
    Map? token = await sharedPreferencesHelper.getToken();
    setState(() {
      role = token?['role'];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.itemDetails),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed: (){
                RouteGenerator.navigationTo(AppRoutes.itemOperationsScreen,
                arguments: widget.item);
              },
              icon: const Icon(Icons.zoom_in_sharp)),
        ],
      ),
      body: Consumer<ItemDetailsController>(
        builder: (context, itemDetailsController, _) {
          final item = itemDetailsController.gettingItemDetails; // Assuming the controller has an item property
          if (item == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Platform.isAndroid
              ? SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(item.images!.isNotEmpty)
                  SizedBox(
                    height: 350,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 350,
                        autoPlay: true,
                        animateToClosest: true,
                        enlargeCenterPage: true,
                      ),
                      items: item.images?.map((image) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: CachedMemoryImage(
                                uniqueKey: image ?? '',
                                errorWidget: const Text('Error'),
                                base64: image,
                                height: 350,
                                width: MediaQuery.of(context).size.width * 0.4,
                                fit: BoxFit.cover,
                                placeholder: const Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                const SizedBox(height: 16.0),
                Text(
                  item.name ?? 'Unknown Item',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'كود: ${item.itemCode ?? 'N/A'}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 8.0),
                Center(
                  child: BarcodeWidget(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: SizeManager.s_50,
                    barcode: Barcode.code128(),
                    data: item.barcode ?? '',
                  ),
                ),
                const SizedBox(height: 8.0),
                Center(
                    child: Text('الكرتونه تحتوي علي ${item.kartona}دسته ، والدسته تحتوي علي ${item.dasta}قطعه')),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    role == 'admin' ? Flexible(
                      child: Card(
                        elevation: 4.0,
                        child: ListTile(
                          title: const Text('سعر الشراء'),
                          subtitle: Text('\EG${item.purchasingPrice?.toStringAsFixed(2) ?? 'N/A'}'),
                        ),
                      ),
                    ) : const SizedBox(),
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: Card(
                        elevation: 4.0,
                        child: ListTile(
                          title: const Text('سعر البيع'),
                          subtitle: Text('EG${item.sellingPrice?.toStringAsFixed(2) ?? 'N/A'}'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Card(
                  elevation: 4.0,
                  child: ListTile(
                    title: const Text('رصيد متاح'),
                    subtitle: Text('${item.balanceKartona} كرتونه ، ${item.balanceDasta} دسته ، ${item.balanceKetaa} قطعه'),
                  ),
                ),
                if (item.section != null) ...[
                  const SizedBox(height: 16.0),
                  Card(
                    elevation: 4.0,
                    child: ListTile(
                      title: const Text('التصنيف'),
                      subtitle: Text(item.section!.sectionName ?? 'N/A'),
                    ),
                  ),
                ],
              ]
            ),
          )
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16.0),
                          Text(
                            item.name ?? 'Unknown Item',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'كود: ${item.itemCode ?? 'N/A'}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(height: 8.0),
                          Center(
                            child: BarcodeWidget(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: SizeManager.s_50,
                              barcode: Barcode.code128(),
                              data: item.barcode ?? '',
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Center(
                              child: Text('الكرتونه تحتوي علي ${item.kartona}دسته ، والدسته تحتوي علي ${item.dasta}قطعه')),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              role == 'admin' ? Flexible(
                                child: Card(
                                  elevation: 4.0,
                                  child: ListTile(
                                    title: const Text('سعر الشراء'),
                                    subtitle: Text('\EG${item.purchasingPrice?.toStringAsFixed(2) ?? 'N/A'}'),
                                  ),
                                ),
                              ) : const SizedBox(),
                              const SizedBox(width: 8.0),
                              Flexible(
                                child: Card(
                                  elevation: 4.0,
                                  child: ListTile(
                                    title: const Text('سعر البيع'),
                                    subtitle: Text('EG${item.sellingPrice?.toStringAsFixed(2) ?? 'N/A'}'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Card(
                            elevation: 4.0,
                            child: ListTile(
                              title: const Text('رصيد متاح'),
                              subtitle: Text('${item.balanceKartona} كرتونه ، ${item.balanceDasta} دسته ، ${item.balanceKetaa} قطعه'),
                            ),
                          ),
                          if (item.section != null) ...[
                            const SizedBox(height: 16.0),
                            Card(
                              elevation: 4.0,
                              child: ListTile(
                                title: const Text('التصنيف'),
                                subtitle: Text(item.section!.sectionName ?? 'N/A'),
                              ),
                            ),
                          ],
                        ]
                    ),
                  ),
                  if(item.images!.isNotEmpty)
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 350,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 350,
                            autoPlay: true,
                            animateToClosest: true,
                            enlargeCenterPage: false,
                          ),
                          items: item.images?.map((image) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: CachedMemoryImage(
                                    uniqueKey: image ?? '',
                                    errorWidget: const Text('Error'),
                                    base64: image,
                                    height: 350,
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    fit: BoxFit.cover,
                                    placeholder: const Center(
                                      child: Icon(
                                        Icons.image,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
