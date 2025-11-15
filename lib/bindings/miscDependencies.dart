import 'package:ad_invoice_mobile/controllers/apicontrollers/notificationandsupportcontroller.dart';
import 'package:ad_invoice_mobile/controllers/dashboardcontroller.dart';
import 'package:ad_invoice_mobile/controllers/dropdowncontroller.dart';

import 'package:get/get.dart';

class Miscdependencies {

  static void init(){

  Get.put(Dropdowncontroller());
  Get.put(Notificationandsupportcontroller(),permanent: true);
  Get.put(Dashboardcontroller());
  }
}