import 'package:eltawfiq_suppliers/core/resources/assets_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/const_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/company/companies_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/groups_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/item/items_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/section/sections_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/suppliers_screen.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SuppliersHomeLayout extends StatefulWidget {
  const SuppliersHomeLayout({super.key});

  @override
  State<SuppliersHomeLayout> createState() => _SuppliersHomeLayoutState();
}

class _SuppliersHomeLayoutState extends State<SuppliersHomeLayout> {


  final _controller = SidebarXController(selectedIndex: ConstManager.c_0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Builder(
        builder: (context){
          final isSmallScreen = MediaQuery.of(context).size.width < SizeManager.s_600;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
              backgroundColor: canvasColor,
              title: Text(_getTitleByIndex(_controller.selectedIndex)),
              leading: IconButton(
                onPressed: () {
                  // if (!Platform.isAndroid && !Platform.isIOS) {
                  //   _controller.setExtended(true);
                  // }
                  _key.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
            )
                : null,
            drawer: ExampleSidebarX(controller: _controller),
            body:  Row(
              children: [
                if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                Expanded(
                  child: Center(
                    child: _ScreensExample(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case ConstManager.suppliersScreenIndex:
      return StringManager.suppliers;
    case ConstManager.companiesScreenIndex:
      return StringManager.companies;
    case ConstManager.groupsScreenIndex:
      return StringManager.groups;
    case ConstManager.sectionsScreenIndex:
      return StringManager.sections;
    case ConstManager.itemsScreenIndex:
      return StringManager.items;

    default:
      return 'Not found page';
  }
}








class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })
      : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 0),
        selectedItemTextPadding: const EdgeInsets.only(left: 0),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(ImageManager.logo),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.people_alt,
          label: StringManager.suppliers,
          onTap: () {},
        ),
        SidebarXItem(
          icon: Icons.add_business_rounded,
          label: StringManager.companies,
          onTap: () {},
        ),
        SidebarXItem(
          icon: Icons.groups,
          label: StringManager.groups,
          onTap: () {},
        ),
        SidebarXItem(
          icon: Icons.safety_divider,
          label: StringManager.sections,
          onTap: () {},
        ),
        SidebarXItem(
          icon: Icons.production_quantity_limits,
          label: StringManager.items,
          onTap: () {},
        ),
      ],
    );
  }
}



class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case ConstManager.suppliersScreenIndex:
            return const SuppliersScreen();
          case ConstManager.companiesScreenIndex:
            return const CompaniesScreen();
          case ConstManager.groupsScreenIndex:
            return const GroupsScreen();
          case ConstManager.sectionsScreenIndex:
            return const SectionsScreen();
          case ConstManager.itemsScreenIndex:
            return const ItemsScreen();


            default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}



const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);