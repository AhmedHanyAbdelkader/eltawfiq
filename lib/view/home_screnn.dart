import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


late AppStateProvider _appStateProvider;

  @override
  void didChangeDependencies() {
    _appStateProvider = sl<AppStateProvider>()..getSections();
    super.didChangeDependencies();
  }

  Future<void> _refreshSections()async{
    await _appStateProvider.getSections();
}

  @override
  Widget build(BuildContext context) {
    //final _authProvider = Provider.of<AuthStateProvider>(context,listen: false);
    final appProvider = Provider.of<AppStateProvider>(context,listen: false);
    return  ChangeNotifierProvider.value(
      value: _appStateProvider,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('الصفحة الرئيسية'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: (){
                  RouteGenerator.navigationTo(AppRoutes.searchScreenRoute);
                },
              )
              // Consumer<AuthStateProvider>(
              //     builder: (context, authProfile, _){
              //       if(authProfile.loginResult != null){
              //         return SizedBox(
              //           height: 10,
              //           width: 10,
              //           child: CachedNetworkImage(
              //             imageUrl:
              //             //'https://ui-avatars.com/api/?name=tt&color=7F9CF5&background=EBF4FF',
              //             authProfile.loginResult!.user!.profilePhotoUrl!,
              //             //_authProvider.loginResult!.user!.profilePhotoPath!,
              //             width: 5,
              //             height: 5,
              //             placeholder: (context, url) => CircularProgressIndicator(),
              //             errorWidget: (context, url, error) => Icon(Icons.error),
              //           ),
              //         );
              //       }else{
              //         return SizedBox(width: 10,height: 10,);
              //       }
              // }),
            ],
          ),
          drawer: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const DrawerHeader(
                    child: UserAccountsDrawerHeader(
                        accountName: Text(''
                            //_authProvider.loginResult!.user!.name!
                        ),
                        accountEmail: Text(''
                            //_authProvider.loginResult!.user!.email!
                        ),
                    ),
                ),
               // _authProvider.loginResult!.user!.roleId == 1?
              TextButton(
                  onPressed: (){
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      RouteGenerator.navigationTo(AppRoutes.suppliersScreenRoute);
                    });
                  },
                  child: const Text(StringManager.suppliers),
                ),
                   // : const SizedBox(),

                // _authProvider.loginResult!.user!.roleId == 1
                //     ? TextButton(
                //   onPressed: (){
                //     WidgetsBinding.instance.addPostFrameCallback((_) {
                //       RouteGenerator.navigationTo(AppRoutes.companiesScreenRoute);
                //     });
                //   },
                //   child: const Text(StringManager.companies),
                // )
                //     : const SizedBox(),


                // _authProvider.loginResult!.user!.roleId == 1
                //     ? TextButton(
                //   onPressed: (){
                //     WidgetsBinding.instance.addPostFrameCallback((_) {
                //       RouteGenerator.navigationTo(AppRoutes.groupsScreenRoute);
                //     });
                //   },
                //   child: const Text(StringManager.groups),
                // )
                //     : const SizedBox(),


                //_authProvider.loginResult!.user!.roleId == 1 ?
                TextButton(
                  onPressed: (){
                    RouteGenerator.navigationTo(AppRoutes.signupScreenRoute);
                  },
                  child: const Text('تسجيل مستخدم جديد'),
                ),
                    //: const SizedBox(),
                // Consumer<AuthStateProvider>(
                //   builder: (context, _logOutStateProvider, _){
                //     return _logOutStateProvider.loginIsLoading != true ? TextButton(
                //       onPressed: ()async {
                //         await _logOutStateProvider.logOut(
                //          // token: _authProvider.loginResult!.token!,
                //         );
                //         if(_logOutStateProvider.logOutResult == 200){
                //           Navigator.of(context).pushReplacement(
                //             MaterialPageRoute(builder: (context)=> const LoginScreen(),),
                //           );
                //           //RouteGenerator.navigationReplacementTo(AppRoutes.loginScreenRoute);
                //         }
                //         if(_logOutStateProvider.logOutErrorMessage.isNotEmpty){
                //           showDialog(
                //             context: context,
                //             builder: (context) => AlertDialog(
                //               title: const Text(StringManager.error),
                //               content: Text(_logOutStateProvider.logOutErrorMessage),
                //               actions: [
                //                 TextButton(
                //                   onPressed: () {
                //                     Navigator.pop(context);
                //                   },
                //                   child: const Text(StringManager.ok),
                //                 ),
                //               ],
                //             ),
                //           );
                //         }
                //       },
                //       child: const Text('تسجيل  الخروج'),
                //     ) : const CircularProgressIndicator.adaptive();
                //   },
                // ),
                const Spacer(),
                const Text('version 1.0.0'),
                const Text('developed by Ahmed Hany'),
                const SizedBox(height: 5,)
              ],
            ),
          ),
          //floatingActionButton:Provider.of<AuthStateProvider>(context,listen: false).loginResult!.user!.roleId == 1 ?
          floatingActionButton: FloatingActionButton(
            tooltip: StringManager.addNewSection,
            onPressed: (){
              //RouteGenerator.navigationTo(AppRoutes.addNewSectionScreenRoute);
            },
            child: const Icon(Icons.add,),
          ) ,
              //: null ,
          body: RefreshIndicator(
            onRefresh: _refreshSections,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer<AppStateProvider>(
                  builder: (context, sectionsStateProvider, _){
                    if(sectionsStateProvider.getSectionsIsLoading){
                      return const Center(child:  CircularProgressIndicator.adaptive());
                    }else if(sectionsStateProvider.getSectionsErrorMessage.isNotEmpty){
                      return Center(child: Text(sectionsStateProvider.getSectionsErrorMessage),);
                    }else if(sectionsStateProvider.getSectionsResult != null){
                      return Expanded(
                        child: ReorderableGridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                          //childAspectRatio: 2/3,
                          children: List.generate(
                            sectionsStateProvider.getSectionsResult!.length,
                            (index) {
                              final section = sectionsStateProvider.getSectionsResult![index];
                              return InkWell(
                                key: ValueKey(section.id),
                                onTap: (){
                                  appProvider.changeCurrentSection(newSection: sectionsStateProvider.getSectionsResult![index]);
                                  RouteGenerator.navigationTo(AppRoutes.sectionItemsScreenRoute);
                                },
                                child: GridTile(
                                  key: ValueKey(section.id),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          // CachedNetworkImage(
                                          //   imageUrl: ApiConstance.getImage(section.imgUrl),
                                          //   placeholder: (context, url) => const CircularProgressIndicator(),
                                          //   errorWidget: (context, url, error) => const Icon(Icons.error),
                                          //   height: 160,
                                          //   width: 150,
                                          //   fit: BoxFit.cover,
                                          // ),
                                          //Text(section.name),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: 40,
                                              color: Colors.black54,
                                              child: Center(
                                                child: Text(
                                                  sectionsStateProvider.getSectionsResult![index].name,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          onReorder: (oldIndex, newIndex) {
                                          setState(() {
                                          final section = sectionsStateProvider.getSectionsResult!.removeAt(oldIndex);
                                          sectionsStateProvider.getSectionsResult!.insert(newIndex, section);
                                          });
                                          _appStateProvider.saveSectionsOrder(sectionsStateProvider.getSectionsResult!);
                                          },
                                          ),
                      );
                    }else{
                      return const Center(child: CircularProgressIndicator.adaptive());
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}









