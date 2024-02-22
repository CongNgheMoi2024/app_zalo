import 'package:app_zalo/constants/index.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FastContactScreen extends StatefulWidget {
  const FastContactScreen({super.key});

  @override
  State<FastContactScreen> createState() => _FastContactScreenState();
}

class _FastContactScreenState extends State<FastContactScreen> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    getContactPermission();
  }

  Future<void> getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      fetchContacts();
    } else {
      print('Permission is not grantedKKKKKKKKKKKKKKKKK');
      await Permission.contacts.request();
    }
  }

  void fetchContacts() async {
    ContactsService.getContacts().then((value) {
      setState(() {
        contacts = value.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print('contacts: ${contacts}');
    return Scaffold(
      body: SingleChildScrollView(
        child: Wrap(
            children: contacts
                .map((e) => Container(
                      height: 45.sp,
                      width: width,
                      color: Colors.red,
                      child: Row(
                        children: [
                          // ignore: unrelated_type_equality_checks
                          e.avatar != null && e.avatar!.isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(e.avatar!))
                              : Container(),
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(60),
                          //   child: Image.asset(
                          //     'assets/images/user')),
                          Text(e.displayName == null
                              ? "Khoong tenn"
                              : e.displayName!),
                        ],
                      ),
                    ))
                .toList()),
      ),
    );
  }
}
