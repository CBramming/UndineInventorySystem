import 'package:flutter/material.dart';
import 'package:undineinventorysystem/screens/login_screen.dart';

class PersonDropdownMenu extends StatelessWidget {
  const PersonDropdownMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        if (result == 'logout') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false,
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.exit_to_app, color: Colors.black54),
              SizedBox(width: 8),
              Text('Logout'),
            ],
          ),
        ),
      ],
      icon: const Icon(Icons.person_2_outlined, size: 34, color: Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      elevation: 2.0,
    );
  }
}
