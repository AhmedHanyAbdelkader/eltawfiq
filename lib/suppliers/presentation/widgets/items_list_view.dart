import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eltawfiq_suppliers/authentication/data/data_source/local_data_source/shred_prefs_helper.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/delete_item_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/items_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/item/items_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemsListView extends StatefulWidget {
  const ItemsListView({super.key, required this.items, required this.role});
  final List<ItemEntity>? items;
  final String role;

  @override
  State<ItemsListView> createState() => _ItemsListViewState();
}

class _ItemsListViewState extends State<ItemsListView> {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final item = widget.items![index];
        return ItemsListTile(item: item,role: widget.role,);
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: widget.items!.length,
    );
  }
}


class ItemsListTile extends StatefulWidget {
  const ItemsListTile({super.key, required this.item, required this.role});
  final ItemEntity item;
  final String role;

  @override
  State<ItemsListTile> createState() => _ItemsListTileState();
}

class _ItemsListTileState extends State<ItemsListTile> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.item.name?? ''),
      subtitle: Text('سعر البيع : ${widget.item.sellingPrice.toString()?? ''}'),
      leading:
      //item.images!.isNotEmpty?
      Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: CachedNetworkImage(
          width: 50,
          height: 50,
          imageUrl: (widget.item.images != null && widget.item.images!.isNotEmpty)
              ? widget.item.images!.first!
              : 'https://placehold.co/400', // Placeholder URL
          placeholder: (context, url) {
            if (widget.item.images != null && widget.item.images!.isNotEmpty) {
              print(widget.item.images != null && widget.item.images!.isNotEmpty);
            } else {
              print("No image available");
            }
            return const SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator());
          },
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),

      //: const SizedBox(
      //   width: 150,
      //   height: 150,
      //     child: Icon(
      //       Icons.image,  // Replace with your desired placeholder icon or widget
      //       size: 40,
      //       color: Colors.grey, // Customize the color
      //     )
      // ),
      //Text(item.id.toString()),
      onTap: (){
        RouteGenerator.navigationTo(AppRoutes.itemDetailsScreenRoute, arguments: widget.item);
      },
      onLongPress: widget.role == 'admin' ?  () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('حذف الصنف'),
              content: Text('${widget.item.toString()}هل تريد حذف الصنف : '),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: ()async{
                    final deleteItemController = Provider.of<DeleteItemController>(context, listen: false);
                    await deleteItemController.deleteItem(widget.item.id!);
                    Provider.of<ItemsController>(context, listen: false).getItems(const NoParameters());
                    if (deleteItemController.deleteItemResult != null) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${deleteItemController.deleteItemErrorMessage}deleted successfully',
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(deleteItemController.deleteItemErrorMessage)),
                      );
                    }
                  },
                  child: Consumer<DeleteItemController>(
                    builder: (context, deleteItemController, _){
                      if(deleteItemController.deleteItemIsLoading){
                        return const CircularProgressIndicator.adaptive();
                      }else{
                        return const Text('حذف');
                      }
                    },
                  ),
                ),
              ],
            );
          },
        );
      } : null,
      trailing: widget.role == 'admin' ? IconButton(
        icon: const Icon(Icons.edit),
        onPressed: (){
          showDialog(
            context: context,
            builder: (context) => EditItemDialog(item: widget.item),
          );
        },
      ) : null,
    );
  }
}
