import 'package:ad_invoice_mobile/Service/loginservice.dart';
import 'package:ad_invoice_mobile/Service/permissionservice.dart';
import 'package:ad_invoice_mobile/controllers/apicontrollers/rolecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Logincontroller extends GetxController{

  final Loginservice loginservice=Get.find<Loginservice>();
 
 

  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  var isloading=false.obs;
  var accesstoken=''.obs;
  var userid=0.obs;
  var tenantid=0.obs;
  var role=''.obs;
  
  

  Future<void> login()async{
      if(isloading.value) return;

      try{

        isloading.value=true;
        var payload={
          'username':"pending_johndoe@gmail.com",
          'password':"12345",
        };
        final response=await loginservice.loginuser(payload);

        role.value=response['role'];
        
       

        
      
        

        if(response['access']!=null)
        {
          accesstoken.value=response['access'];
          userid.value=response['user_id'];
          tenantid.value=response['tenant_id'];
        
    
        }


        if(usernamecontroller.text.isEmpty || passwordcontroller.text.isEmpty)
        {
          Get.snackbar("Empty fields", "Please enter valid credentials");

        }
        else{
          Get.snackbar(
          response['success']=="Login successful"?"Succesfully logged in":"Login failed",
          response['role']=="admin"?"Signed in as ${response['role']}":"Sorry,Could not signin",
          backgroundColor: response['success']=='Login successful'?Colors.green[200]:Colors.red[200],
          icon: response['success']=="Login successful"?Icon(Icons.thumb_up,color: Colors.green,):Icon(Icons.error,color: Colors.red,),
          showProgressIndicator: true,
          );
        }
      }
      catch(e)
      {
        Get.snackbar("Error", e.toString());
       
      }
      finally{
        isloading.value=false;
      }
  
  }


  @override
  void onClose() {
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    super.onClose();
  }

  void clearfield(){
    usernamecontroller.clear();
    passwordcontroller.clear();
  }

  
}