import 'package:ad_invoice_mobile/Service/roleservice.dart';
import 'package:ad_invoice_mobile/Service/usermanagementservice.dart';
import 'package:ad_invoice_mobile/controllers/apicontrollers/rolecontroller.dart';
import 'package:ad_invoice_mobile/controllers/apicontrollers/usermanagementcontroller.dart';
import 'package:get/get.dart';

class Usermanagementdependencies {


  static void init(){
      Get.lazyPut(()=>Roleservice(),fenix: true);
       Get.lazyPut(()=>Rolecontroller(),fenix: true);
      Get.lazyPut(()=>Usermanagementservice(),fenix: true);
      Get.lazyPut(()=>Usermanagementcontroller(),fenix: true);
     
  
  }
}