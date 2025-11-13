
import 'package:ad_invoice_mobile/Service/permissionservice.dart';
import 'package:ad_invoice_mobile/bindings/authDependencies.dart';
import 'package:ad_invoice_mobile/bindings/clientDependencies.dart';
import 'package:ad_invoice_mobile/bindings/miscDependencies.dart';
import 'package:ad_invoice_mobile/bindings/productDependencies.dart';
import 'package:ad_invoice_mobile/bindings/proposaldependencies.dart';
import 'package:ad_invoice_mobile/bindings/usermanagementDependencies.dart';

import 'package:ad_invoice_mobile/controllers/dropdowncontroller.dart';
import 'package:ad_invoice_mobile/controllers/radiobuttoncontroller.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  Get.put(Dropdowncontroller());
  Get.put(Radiobuttoncontroller());
 Get.lazyPut(() => PermissionService());

  Usermanagementdependencies.init();
  Proposaldependencies.init();
  Clientdependencies.init();
  Productdependencies.init();
  Authdependencies.init();
  Miscdependencies.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      builder: (context, child) => ResponsiveBreakpoints.builder(
  child: child!,
  breakpoints: [
    const Breakpoint(start: 0, end: 600, name: MOBILE),     // mobile up to 600
    const Breakpoint(start: 601, end: 1024, name: TABLET),  // tablet up to 1024
    const Breakpoint(start: 1025, end: double.infinity, name: DESKTOP),
  ],
  
),

      home:Loginscreen(),
    );
  }
}



