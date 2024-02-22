import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FastContactScreen extends StatefulWidget {
  const FastContactScreen({super.key});

  @override
  State<FastContactScreen> createState() => _FastContactScreenState();
}

class _FastContactScreenState extends State<FastContactScreen> {
  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    if (await Permission.contacts.isGranted) {
      print('Permission is granted');
    } else {
      print('Permission is not grantedKKKKKKKKKKKKKKKKK');
      await Permission.contacts.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: ListView.builder(
        //   itemCount: contacts.length,
        //   itemBuilder: (context, index) {
        //     return ListTile(
        //       title: Text(contacts[index].displayName),
        //       subtitle: Text(contacts[index].phoneNumber),
        //     );
        //   },
        // ),
        );
  }
}
