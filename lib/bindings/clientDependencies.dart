import 'package:ad_invoice_mobile/Service/clientlistservice.dart';
import 'package:ad_invoice_mobile/Service/create_client_service.dart';
import 'package:ad_invoice_mobile/controllers/apicontrollers/createclientcontroller.dart';
import 'package:ad_invoice_mobile/controllers/apicontrollers/listclientcontroller.dart';
import 'package:ad_invoice_mobile/controllers/userscontroller.dart';
import 'package:get/get.dart';

class Clientdependencies {

  static void init(){
    Get.lazyPut(()=>CreateClientService(),fenix: true);
    Get.lazyPut(()=>Clientlistservice(),fenix: true);
    Get.lazyPut(()=>Createclientcontroller(),fenix: true);
    Get.lazyPut(()=>Listclientcontroller(),fenix: true);
    Get.lazyPut(()=>Userscontroller(),fenix: true);
  }
}