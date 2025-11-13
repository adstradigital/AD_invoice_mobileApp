import 'package:ad_invoice_mobile/controllers/apicontrollers/logincontroller.dart';
import 'package:get/get.dart';

class Loginservice extends GetConnect{

  @override
  void onInit() {
    httpClient.baseUrl="http://127.0.0.1:8000/api/";
    httpClient.timeout=Duration(seconds: 30);
    super.onInit();
  }

  Future<dynamic> loginuser(Map<String,dynamic> data)async
  {
      try{
        final response=await post('users/signin/', data);
        if(response.statusCode==200)
        {
          final data=response.body;
        }
      return response.body;
      }catch(e)
      {
          throw 'Login Failed : $e';
      }
  }

}