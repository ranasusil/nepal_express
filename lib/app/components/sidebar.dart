import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:nepal_express/app/routes/app_pages.dart';

SideBar sidebar(BuildContext context) {
  return SideBar(
    items: const [
      AdminMenuItem(title: 'Dashboard', route: '/admin-home', icon: Icons.home),
      AdminMenuItem(title: 'Users', icon: Icons.people, route: '/users'),
      AdminMenuItem(title: 'Agencies', icon: Icons.business, children: [
        AdminMenuItem(title: 'View Agency', route: '/agency'),
        AdminMenuItem(title: 'Add Agency'),
      ]),
      AdminMenuItem(title: 'Buses', icon: Icons.train, route: '/all-buses'),
      AdminMenuItem(
          title: 'Profile', route: '/admin-profile', icon: Icons.person),
    ],
    selectedRoute: '/',
    onSelected: (item) {
      if (item.route != null) {
        Navigator.of(context).pushNamed(item.route!);
      }
    },
  );
}
