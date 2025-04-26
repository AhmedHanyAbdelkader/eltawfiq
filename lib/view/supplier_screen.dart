import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/core/app/functions.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({super.key});

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {

  TextEditingController payedController = TextEditingController();
  TextEditingController remainedController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> launchMapUrl(String locationLink) async {
    final url = locationLink;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchEmailApp({required String toEmail, String? subject, String? body,}) async {
    final emailLaunchUri = 'mailto:$toEmail?';
    final List<String> queryParams = [];

    if (subject != null) {
      queryParams.add('subject=${Uri.encodeComponent(subject)}');
    }

    if (body != null) {
      queryParams.add('body=${Uri.encodeComponent(body)}');
    }

    final String queryString = queryParams.join('&');
    final String uri = emailLaunchUri + queryString;

    try {
      await launch(uri);
    } catch (e) {
      if (kDebugMode) {
        print('Error launching email: $e');
      }
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    final supplier = Provider.of<AppStateProvider>(context, listen: false).currentSupplier;
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.supplierInfos),
        actions: [
          IconButton(
            onPressed: (){
              RouteGenerator.navigationTo(
                  AppRoutes.editSupplierScreenRoute,
                arguments: supplier
              );
            },
            icon: const Icon(Icons.edit_note),
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText.rich(
                TextSpan(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    text: StringManager.supplierName,
                    children: [
                      TextSpan(text: StringManager.colon, children: [
                        TextSpan(
                          text: supplier!.supplierName,
                        )
                      ])
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              SelectableText.rich(
                TextSpan(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    text: StringManager.position,
                    children: [
                      TextSpan(text: StringManager.colon, children: [
                        TextSpan(
                          text: supplier.supplierPosition,
                        )
                      ])
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              SelectableText.rich(
                TextSpan(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    text: StringManager.supplierCompanyName,
                    children: [
                      TextSpan(
                          text: StringManager.colon,
                          children: [
                        TextSpan(
                          text: supplier.company?.companyName ?? '',
                        )
                      ])
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              SelectableText.rich(
                TextSpan(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    text: StringManager.supplierGroupName,
                    children: [
                      TextSpan(
                          text: StringManager.colon,
                          children: [
                        TextSpan(
                          text: supplier.group?.groupName ?? '',
                        )
                      ])
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              SelectableText.rich(
                TextSpan(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    text: StringManager.supplierSection,
                    children: [
                      TextSpan(
                          text: StringManager.colon,
                          children: [
                        TextSpan(
                          text: supplier.section?.name ?? '',
                        )
                      ])
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              SelectableText.rich(
                TextSpan(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    text: StringManager.supplierCompanyAddress,
                    children: [
                      TextSpan(text: StringManager.colon, children: [
                        TextSpan(
                          text: supplier.address ?? '',
                        )
                      ])
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      launchMapUrl(supplier.mapLocation ?? '');
                    },
                    icon: const Icon(Icons.location_on, size: 35,color: Colors.green,),
                  ),
                  IconButton(
                    onPressed: () {
                      String formattedWhatsappNumber = formatPhoneNumber(supplier.supplierWhatsappNumber!);
                      launchWhatsAppUri(whatsappNumber: formattedWhatsappNumber);
                    },
                    icon: const Icon(
                      Icons.chat,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      launchEmailApp(
                          toEmail: supplier.email ?? '', subject: '', body: '');
                    },
                    icon: const Icon(Icons.mark_email_unread, size: 35, color: Colors.purpleAccent,),
                  ),
                  IconButton(
                    onPressed: () async {
                      // final Uri fbUri = Uri.parse(url);
                      // final String? profileId = fbUri.queryParameters['id'];
                        try {
                          if (!await launchUrl(Uri.parse(supplier.facebook ?? ''), mode: LaunchMode.externalApplication)) {
                            throw Exception('Could not launch');
                          }
                        } catch (e) {
                          if (kDebugMode) {
                            print(e);
                          }
                        }
                    },
                    icon: const Icon(Icons.facebook, size: 35,color: Colors.blue,),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [SelectableText.rich(
                  TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    text: StringManager.supplierFullName,
                    children: [
                      TextSpan(
                        text: StringManager.colon,
                        children: [
                          TextSpan(
                            text: supplier.supplierFullName ?? '',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                  const SizedBox(
                    height: 20,
                  ),
                  SelectableText.rich(
                    TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      text: StringManager.supplierPostalCode,
                      children: [
                        TextSpan(
                          text: StringManager.colon,
                          children: [
                            TextSpan(
                              text: supplier.supplierPostalCode ?? '',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ...supplier.bankInfo?.map((bankInfo) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'بنك : ${bankInfo['bank_name']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'حساب رقم : ${bankInfo['bank_account']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20), // Space between each bank info
                      ],
                    );
                  }).toList() ?? [], // If bankInfos is null, return an empty list
                ],
              ),
            ),
          ),
        ),


              const SizedBox(height: 30,),
              supplier.supplierPhoneNumbers != null
                  ? PhoneNumbersWidget(phoneNumbers: supplier.supplierPhoneNumbers)
                  : const SizedBox(),

              const SizedBox(
                height: 20,
              ),
              SelectableText.rich(
                TextSpan(
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    text: StringManager.supplierWhatsAppNumber,
                    children: [
                      TextSpan(text: StringManager.colon, children: [
                        TextSpan(
                          text: supplier.supplierWhatsappNumber,
                        )
                      ])
                    ]),
              ),
              const SizedBox(
                height: 50,
              ),
              SelectableText.rich(
                TextSpan(
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    text: StringManager.suppliernotes,
                    children: [
                      TextSpan(text: StringManager.colon, children: [
                        TextSpan(
                          mouseCursor: SystemMouseCursors.click,
                          text: supplier.notes ?? '',
                        )
                      ])
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      RouteGenerator.navigationTo(
                          AppRoutes.supplierItemsScreenRoute);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.circular(15)),
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 180,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.production_quantity_limits,
                            color: Colors.white,
                            size: 60,
                          ),
                          Text(
                            StringManager.supplierProducts,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      RouteGenerator.navigationTo(
                          AppRoutes.supplierInvoicesScreenRoute);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.circular(15)),
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 180,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inventory_outlined,
                            color: Colors.white,
                            size: 60,
                          ),
                          Text(
                            StringManager.supplierInvoice,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              ///this is the start of comment
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('الاجمالي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Text(supplier.supplierTotal.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ],
              ),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('المدفوع', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Text(supplier.supplierPayed.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ],
              ),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('المتبقي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Text(supplier.supplierRemained.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ],
              ),
              const SizedBox(height: 50,),
              Center(
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: MaterialButton(
                      onPressed: (){
                        showDialog(context: context, builder: (context){
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: AlertDialog.adaptive(
                              title: const Center(child: Text('إنشاء مدفوعة')),
                              content: SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 25,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text('الاجمالي',),
                                          Text(supplier.supplierTotal.toString(), ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text('المدفوع',),
                                          Text(supplier.supplierPayed.toString(),),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text('المتبقي', ),
                                          Text(supplier.supplierRemained.toString(),),
                                        ],
                                      ),
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
                                          remainedController.text = (double.parse(supplier.supplierTotal!) -  (double.parse(newPayedAmount) + double.parse(supplier.supplierPayed!)) ).toString();
                                        },
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder()
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                      const Text('المتبقي'),
                                      TextFormField(
                                        controller: remainedController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder()
                                        ),
                                      ),
                                      const SizedBox(height: 20,),

                                    ],
                                  ),
                                ),
                              ),
                              actionsAlignment: MainAxisAlignment.spaceAround,
                              actions: [
                                Consumer<AppStateProvider>(
                                  builder: (context, makePaymentStateProvider, _){
                                    if(makePaymentStateProvider.maketSupplierPaymentsIsLoading == true){
                                      return const Center(child: CircularProgressIndicator.adaptive(),);
                                    }
                                    else if(makePaymentStateProvider.makeSupplierPaymentsResult != null){
                                      Future.microtask((){
                                        // Provider.of<AppStateProvider>(context, listen: false).getSuppliers(
                                        //   id:Provider.of<AuthStateProvider>(context, listen: false).loginResult!.user!.id!,
                                        // );
                                        Navigator.pop(context); // Close current dialog
                                        RouteGenerator.navigationReplacementTo(AppRoutes.suppliersScreenRoute);
                                      });
                                    }
                                    else if(makePaymentStateProvider.makeSupplierPaymentsErrorMessage.isNotEmpty){
                                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(makePaymentStateProvider.makeSupplierPaymentsErrorMessage),
                                          ),
                                        );
                                      });
                                    }
                                      return ElevatedButton(
                                        onPressed: (){
                                          if(_formKey.currentState!.validate()){
                                            // makePaymentStateProvider.makeSupplierPayments(
                                            //     supplierId: supplier.supplierId,
                                            //     payedAmountFromSupplierTotal: int.parse(payedController.text),
                                            //     remainedAmountFromSupplierTotal: double.parse(remainedController.text).toInt(),
                                            // );
                                          }
                                        },
                                        child: const Text('دفع'),
                                      );
                                  },
                                ),
                                ElevatedButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('إلغاء'),
                                ),
                              ],
                            ),
                          );
                        });
                      },
                    padding: const EdgeInsets.all(8),
                      child: const Text('دفع مبلغ', style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),),
                  ),
                ),
              ),
              const SizedBox(height: 25,),
              TextButton(
                  onPressed: (){
                    if(Provider.of<AppStateProvider>(context, listen: false).getSupplierPaymentsResult != null){
                      Provider.of<AppStateProvider>(context, listen: false).getSupplierPaymentsResult!.clear();
                    }
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      showDragHandle: true,
                      isDismissible: true,
                      builder: (BuildContext _){
                        Future.delayed(Duration.zero, (){
                          Provider.of<AppStateProvider>(context, listen: false).getSupplierPayments(
                            supplierId : supplier.supplierId!,
                          );
                        });
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: Consumer<AppStateProvider>(
                            builder: (context , getSupplierPaymentsStateProvider, _){
                              if(getSupplierPaymentsStateProvider.getSupplierPaymentsIsLoading == true){
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              }
                              if(getSupplierPaymentsStateProvider.getSupplierPaymentsErrorMessage.isNotEmpty){
                                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(StringManager.error),
                                      content: Text(getSupplierPaymentsStateProvider.getSupplierPaymentsErrorMessage),
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
                              }
                              if(getSupplierPaymentsStateProvider.getSupplierPaymentsResult != null){
                                return Column(
                                  children: [
                                    const Text('سجل المدفوعات',style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    const SizedBox(height: 30,),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.8,
                                      child: ListView.separated(
                                        itemCount: getSupplierPaymentsStateProvider.getSupplierPaymentsResult!.length,
                                          shrinkWrap: true,
                                          physics: const BouncingScrollPhysics(),
                                          itemBuilder: (context, index){
                                            return ListTile(
                                              leading: Text((index+1).toString()),
                                              title: Text(' المدفوع : ${getSupplierPaymentsStateProvider.getSupplierPaymentsResult![index].payedAmountFromSupplierTotal}'),
                                              subtitle: Text(' المتبقي : ${ getSupplierPaymentsStateProvider.getSupplierPaymentsResult![index].remainedAmountFromSupplierTotal}'),
                                              trailing: Text(' بتاريخ : ${ getSupplierPaymentsStateProvider.getSupplierPaymentsResult![index].paymentDate}'),
                                            );
                                          },
                                        separatorBuilder: (context, index){
                                          return const Divider();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }else{
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              }
                            },
                          ),
                        );
                    },
                    );
                  },
                  child: const Text('سجل المدفوعات'),
              ),
              ///this is the end of comment
            ],
          ),
        ),
      ),
    );
  }
}



class PhoneNumbersWidget extends StatelessWidget {
  const PhoneNumbersWidget({super.key, this.phoneNumbers});
  final List<dynamic>? phoneNumbers;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ارقام الموبيل'),
          ],
        ),

        for(int i =0; i < phoneNumbers!.length ; i++)
          Column(
            children: [
              SelectableText.rich(
                  TextSpan(
                      text: phoneNumbers![i],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )
                  )
              ),
              const SizedBox(height: 10,),
            ],
          ),

      ],
    );
  }
}


