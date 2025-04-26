import 'dart:developer';

import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class ClientsContactsScreen extends StatefulWidget {
  const ClientsContactsScreen({super.key});

  @override
  State<ClientsContactsScreen> createState() => _ClientsContactsScreenState();
}

class _ClientsContactsScreenState extends State<ClientsContactsScreen> {


  List<Contact> contacts = [];

  Future<void> _getContacts() async {
    var status = await Permission.contacts.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      if (await Permission.contacts.request().isGranted) {
         await FlutterContacts.getContacts(withProperties: true, withPhoto: true).then((value){
          setState(() {
            contacts = value;
          });
        });
        log(contacts.toString());
      } else {
        if (kDebugMode) {
          print('Contact permission denied');
        }
      }
    } else {
     await FlutterContacts.getContacts(withProperties: true, withPhoto: true).then((value){
        setState(() {
          contacts = value;
        });
      });
    }
  }

  final TextEditingController _searchController = TextEditingController();
  List<Contact> _filteredContacts = [];


  @override
  void initState() {
    super.initState();
    loadContacts();
    _searchController.addListener(_filterContacts);
  }

  loadContacts() async {
    await _getContacts().then((value) {
      setState(() {
        _filteredContacts = contacts;
      });
    });
  }

  void _filterContacts() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContacts = contacts.where((contact) {
        String name = contact.displayName.toLowerCase();
        String phone = contact.phones.isNotEmpty ? contact.phones.first.normalizedNumber : '';
        String email = contact.emails.isNotEmpty ? contact.emails.first.address : '';
        String address = contact.addresses.isNotEmpty ? contact.addresses.first.street +  contact.addresses.first.city + contact.addresses.first.state + contact.addresses.first.country: '';
        String company = contact.emails.isNotEmpty ? contact.organizations.first.company : '';
        String notes = contact.notes.isNotEmpty ? contact.notes.first.note : '';

        return name.contains(query) || phone.contains(query) || email.contains(query) || address.contains(query)
            || company.contains(query) || notes.contains(query);
      }).toList();
    });
  }



  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('أرقامك'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'ابحث باسم أو رقم أو بريد إلكتروني',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  prefixIcon: const Icon(Icons.search),
                  suffix: IconButton(
                    icon: const Icon(Icons.delete_forever),
                    onPressed: (){
                      _searchController.clear();
                    },
                  )
                ),
              ),
            ),
          ),
        ),
        body: _filteredContacts.isNotEmpty
            ? ListView.separated(
          itemCount: _filteredContacts.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                RouteGenerator.navigationTo(
                  AppRoutes.addClientFromContctsRoute,
                  arguments: _filteredContacts[index],
                );
              },
              child: ListTile(
                title: Text(_filteredContacts[index].displayName),
                subtitle: Text(_filteredContacts[index].phones.isNotEmpty
                    ? _filteredContacts[index].phones.first.normalizedNumber.toString()
                    : 'No phone number'),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(_filteredContacts[index].emails.isNotEmpty
                        ? _filteredContacts[index].emails.first.address
                        : ''),
                    Text(_filteredContacts[index].organizations.isNotEmpty
                        ? _filteredContacts[index].organizations.first.company
                        : ''),
                  ],
                ),
              ),
            );
          },
        )
            : const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}