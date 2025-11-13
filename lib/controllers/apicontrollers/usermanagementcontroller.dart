import 'package:ad_invoice_mobile/Service/usermanagementservice.dart';
import 'package:ad_invoice_mobile/controllers/apicontrollers/rolecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Usermanagementcontroller extends GetxController{

  final Rolecontroller rolecontroller=Get.find<Rolecontroller>();

  @override
  void onInit() {
    getus();
    super.onInit();
  }

  var isloading=false.obs;
  var issuccess=false.obs;
  var users=[].obs;
  var isactive=false.obs;
  final Usermanagementservice usermanagementservice=Get.put(Usermanagementservice());
  final TextEditingController usernamecontroller=TextEditingController();
    final TextEditingController emailcontroller=TextEditingController();
    final TextEditingController passwordcontroller=TextEditingController();
    final TextEditingController firstnamecontroller=TextEditingController();
    final TextEditingController lastnamecontroller=TextEditingController();


    final TextEditingController usernameeditcontroller=TextEditingController();
    final TextEditingController emaileditcontroller=TextEditingController();
    final TextEditingController passwordeditcontroller=TextEditingController();
    final TextEditingController firsteditcontroller=TextEditingController();
    final TextEditingController lasteditcontroller=TextEditingController();


  Future<void> createus()async{

    try{
      isloading.value=true;
      final payload={
        "username": usernamecontroller.text,
        "email": emailcontroller.text,
        "password": passwordcontroller.text,
        "first_name":firstnamecontroller.text,
        "last_name": lastnamecontroller.text,
        "role_ids": rolecontroller.selectedRoleIds.map((id) => int.parse(id)).toList(),

      };


      final response=await usermanagementservice.createuser(payload);

   
     

      issuccess.value=response['message']=="User created successfully"?true:false;
      

      Get.snackbar(issuccess.value?"Success":"Failed", issuccess.value?"User created successfully":"${response['error']}",
      backgroundColor: issuccess.value?Colors.green[200]:Colors.red[200]);
      
    }
    catch(e)
    {
      Get.snackbar("Sorry", "$e");
    }
    finally{
      isloading.value=false;
    }
  }
  
  Future<void> getus()async{
    try{
      isloading.value=true;

      final response=await usermanagementservice.getuser();

      users.value=response['results'];


      //userid.value=users['id'];
      
  
    }
    catch(e)
    {
      Get.snackbar("failed to load users", "$e");
      
    }
    finally{
      isloading.value=false;
    }
  }

  Future<void> deleteus(int userid)async{
    try{
      isloading.value=true;

    
      final response=await usermanagementservice.deleteuser(userid);

      //tenent id issue here,not resolved
  

    }
    catch(e)
    {
      Get.snackbar("Error", "$e");
    }
    finally{
      isloading.value=false;
    }
  }

  Future<void> updateus(int userid)async{
    try{
      isloading.value=true;
      
      final payload={
         "username": usernameeditcontroller.text.trim(),
  "email": emaileditcontroller.text.trim(),
  "first_name": firsteditcontroller.text.trim(),
  "last_name": lasteditcontroller.text.trim(),
  "is_active": isactive.value,
  "role_ids": rolecontroller.selectedRoleIds.map((id) => int.parse(id)).toList(),
      };

      final response=await usermanagementservice.updateuser(payload,userid);

    

    
      
     
      issuccess.value=response['username']==usernameeditcontroller.text?true:false;

       if (issuccess.value) {
    
      await getus(); 
      
      Get.snackbar(
        "User updated", 
        "Changes made successfully",
        backgroundColor: Colors.green[200],
        duration: Duration(seconds: 2)
      );
    } else {
      Get.snackbar(
        "Couldn't update user", 
        "Couldn't make changes",
        backgroundColor: Colors.red[200],
        duration: Duration(seconds: 2),
      );
    }
    }
    catch(e)
    {
      Get.snackbar("error", "$e");
    }
    finally{
      isloading.value=true;
    }
  }

  void clearfield(){
    usernamecontroller.clear();
    emailcontroller.clear();
    passwordcontroller.clear();
    firstnamecontroller.clear();
    lastnamecontroller.clear();

  }
}