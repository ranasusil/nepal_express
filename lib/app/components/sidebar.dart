import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:nepal_express/app/routes/app_pages.dart';

SideBar sidebar(BuildContext context) {
  return SideBar(
    backgroundColor: const Color(0xFFEEEEEE), // Background color of the sidebar
    activeBackgroundColor:
        Colors.black26, // Background color of the active item
    borderColor: const Color(0xFFE7E7E7), // Border color of the sidebar
    iconColor: const Color.fromARGB(221, 0, 0, 0), // Color of the icons
    activeIconColor: const Color.fromARGB(
        255, 255, 255, 255), // Color of the icons when active
    textStyle: const TextStyle(
      // Text style of the items
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 13,
    ),
    activeTextStyle: const TextStyle(
      // Text style of the items when active
      color: Colors.white,
      fontSize: 13,
    ),
    header: Container(
      height: 120, // Adjust height as needed
      width: double.infinity,
      color: const Color(0xFFEEEEEE),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Image.asset('images/newlogo.png'), // Update with your logo path
    ),
    footer: Container(
      height: 50,
      width: double.infinity,
      color: const Color(0xFFEEEEEE),
      child: const Center(
        child: Text(
          '© Copyright Nepal Express 2024',
          style: TextStyle(
            color: Color.fromARGB(255, 70, 70, 70),
          ),
        ),
      ),
    ),
    items: const [
      AdminMenuItem(title: 'Dashboard', route: '/admin-home', icon: Icons.home),
      AdminMenuItem(title: 'Users', icon: Icons.people, route: '/users'),
      AdminMenuItem(title: 'Agencies', icon: Icons.business,route: '/agency'),
      AdminMenuItem(title: 'Buses', icon: Icons.train, route: '/all-buses'),
      AdminMenuItem(title: 'Trips', icon: Icons.map, route: '/trips'),
      AdminMenuItem(title: 'Feedbacks', icon: Icons.mail_outline, route: '/feedbacks'),
      AdminMenuItem(
          title: 'Profile', route: '/admin-profile', icon: Icons.person),
    ],
    selectedRoute: ModalRoute.of(context)?.settings.name ??
        '/', // Update with the current route
    onSelected: (item) {
      if (item.route != null) {
        Navigator.of(context).pushNamed(item.route!);
      }
    },
  );
}
