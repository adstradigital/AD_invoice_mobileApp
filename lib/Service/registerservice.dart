import 'package:ad_invoice_mobile/controllers/apicontrollers/logincontroller.dart';
import 'package:get/get.dart';
class Registerservice extends GetConnect{


final Logincontroller logincontroller=Get.find<Logincontroller>();
  @override
  void onInit(){
    httpClient.baseUrl="http://127.0.0.1:8000/api/";
    httpClient.timeout=Duration(seconds: 30);
  }

  Future<dynamic> registeruser(Map<String,dynamic> data) async
  {
    try{
      
        final response=await post("users/register/", data);
        return response.body;
    }catch (e)
    {
      //print('Detailed error: $e');
      //print('Error type: ${e.runtimeType}');
      throw 'Registration Failed :$e';
    }

  }

  Future<dynamic> sendotp(Map<String,dynamic> data)async{
    try{
      final response=await post("sms/send-signup-otp/", data,);
      return response.body;
    }
    catch(e)
    {
      Get.snackbar("Error sending otp", "$e");
    }
  }
  
}
