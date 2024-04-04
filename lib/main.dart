import 'package:flutter/material.dart';
import 'package:nepal_express/app/modules/admin_home/views/admin_home_view.dart';
import 'package:nepal_express/app/modules/agency/views/agency_view.dart';
import 'package:nepal_express/app/modules/profile/views/profile_view.dart';
import 'package:nepal_express/app/modules/users/views/users_view.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'app/routes/app_pages.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/routes/app_pages.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:get/get.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Memory.init();
  var token = Memory.getToken();
  var role = Memory.getRole();
  var isAgency = role == 'agency';
  var isAdmin = role == 'admin';
  runApp(
        KhaltiScope(
      publicKey: "test_public_key_beaee0cc73514d76a4e015ad0dfc5caa",
      builder: (context, navigatorKey) => GetMaterialApp(
        navigatorKey: navigatorKey,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ne', 'NP'),
        ],
        localizationsDelegates: const [
          KhaltiLocalizations.delegate,
        ],
        theme: ThemeData(
          primarySwatch: primaryColor,
          useMaterial3: false,
        ),

        debugShowCheckedModeBanner: false,
        title: "Nepal Express",
        initialRoute: token == null
            ? Routes.LOGIN
            : isAgency
                ? Routes.TRAVEL_AGENCY_MAIN
                : isAdmin
                    ? Routes.ADMIN_HOME
                    : Routes.MAIN,
        getPages: AppPages.routes,
        defaultTransition: Transition.cupertino,

      ),
    ),
  );
}