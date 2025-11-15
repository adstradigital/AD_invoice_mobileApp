import 'package:ad_invoice_mobile/Service/registerservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Registrationcontroller extends GetxController{

  final Registerservice registerservice=Get.find<Registerservice>();


  var appid=0.obs;
  var isloading=false.obs;
  var isunderage=false.obs;
  var issuccess=false.obs;
  var otpvalue=''.obs;
  var enteredotp=''.obs;
  

  final firstnamecontroller=TextEditingController();
  final lastnamecontroller=TextEditingController();
  final emailcontroller=TextEditingController();
  final phonecontroller=TextEditingController();
  final addresscontroller=TextEditingController();
  final dobcontroller=TextEditingController();
  final companycontroller=TextEditingController();

  final otpphonecontroller=TextEditingController();
  final otpverifycontroller=TextEditingController();

  Future<void> register()async{
    if(isloading.value) return;

    try{
      isloading.value=true;

      final email=emailcontroller.text.trim();
      final phone=phonecontroller.text.trim();
      

      final emailreg=RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
      if(!emailreg.hasMatch(email))
      {
        Get.snackbar("Invalid Email", "Please Enter a valid email");
        return;
      }

      if(phone.isEmpty || !RegExp(r'^\d+$').hasMatch(phone))
      {
        Get.snackbar("Invalid phone Number", "Phone must only contain Digits");
        return;
      }
      else if(phone.length<8 || phone.length>15)
      {
        Get.snackbar("Invalid phone number", "Phone must be between 10 digit");
        return;
      }
      
      final payload={
        "first_name": firstnamecontroller.text.trim(),
        "last_name": lastnamecontroller.text.trim(),
        "email": email,
        "phone": phone,
        "address": addresscontroller.text.trim(),
        "date_of_birth": dobcontroller.text.trim(),
        "company_name": companycontroller.text.trim(),
        "password":"12345"
        
        
      };
     
        final response=await registerservice.registeruser(payload);

        //appid.value=response['application_id'] ??0;

       

        Get.snackbar(
          response['status']=='pending'?"Verfication pending":"Success",
          response['warning'] ??"Registration completed",
          backgroundColor: response['status'] == 'pending'?Colors.red :Colors.green,
          colorText: Colors.white,
        );

        clearfields();
          }catch(e)
    {
      Get.snackbar("error", e.toString());
     
    }finally{
      isloading.value=false;
    }

  }

  Future<void> pickdate() async{

    final DateTime? picked=await showDatePicker(context: Get.context!, firstDate: DateTime(1950), lastDate: DateTime.now(),initialDate: DateTime.now());

    if(picked!=null){
      final age=calculateage(picked);
      isunderage.value=age<18;
      if(isunderage.value)
      {
        Get.snackbar("Age Warning", "You must be 18 or older to register",icon: Icon(Icons.warning),backgroundColor: Colors.orange[200]);
        
      }
      dobcontroller.text="${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  Future<void> sendot()async{

    try{
      isloading.value=true;

      final payload={
        "phone":otpphonecontroller.text.trim(),
      };

     

      final response=await registerservice.sendotp(payload);
     

     

      otpvalue.value=response['debug_otp'];

      issuccess.value = response['success']
        .toString()
        .toLowerCase()
        .contains("otp sent successfully");


   
    }
    catch(e)
    {
      Get.snackbar("Error sending otp", "$e");
    }
    finally{
      isloading.value=false;
    }
  }

  @override
  void onClose() {
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    emailcontroller.dispose();
    phonecontroller.dispose();
    addresscontroller.dispose();
    dobcontroller.dispose();
    companycontroller.dispose();
    super.onClose();
  }

  void clearfields(){
    firstnamecontroller.clear();
    lastnamecontroller.clear();
    emailcontroller.clear();
    phonecontroller.clear();
    addresscontroller.clear();
    dobcontroller.clear();
    companycontroller.clear();
  }

  int calculateage(DateTime date){

    final now=DateTime.now();
    var age=now.year - date.year;

    if(now.month < date.month || now.month == date.month && now.day < date.day)
    {
      age--;
    }
    return age;
  }
}