import 'package:ad_invoice_mobile/controllers/apicontrollers/logincontroller.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';

class CreateClientService extends GetConnect {
  final Logincontroller logincontroller=Get.find<Logincontroller>();

  @override
  void onInit() {
    httpClient.baseUrl="http://127.0.0.1:8000/api/";
    httpClient.timeout=Duration(seconds: 30);
    super.onInit();
  }

  Future<dynamic> createclient(Map<String,dynamic> data)async
  {
    try{
      var response=await post("clients/create/", data,headers:{
        'Authorization':'Bearer ${logincontroller.accesstoken.value}'
      });
    return response.body;
    }catch(e)
    {
      throw 'Unable to create client $e';
    }
  }

  Future<dynamic> updateclient(Map<String,dynamic> data,String userid)async{

    try{
      var response=await put("clients/update/$userid/", data,headers: {
         'Authorization':'Bearer ${logincontroller.accesstoken.value}'
      });
      return response.body;
    }
    catch(e)
    {
      throw e;
    }
  }
  
}