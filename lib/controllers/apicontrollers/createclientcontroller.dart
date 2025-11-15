import 'package:ad_invoice_mobile/Service/create_client_service.dart';
import 'package:ad_invoice_mobile/controllers/apicontrollers/logincontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


class Createclientcontroller extends GetxController{

  final CreateClientService createClientService=Get.find<CreateClientService>();
  final Logincontroller logincontroller=Get.find<Logincontroller>();

  var isloading=false.obs;
  var issucess=false.obs;

  final clientnamecontroller=TextEditingController();
  final industrycontroller=TextEditingController();
  final websitecontroller=TextEditingController();
  final registercontroller=TextEditingController();
  final taxcontroller=TextEditingController();
  final addresscontroller=TextEditingController();
  final addresscontroller2=TextEditingController();
  final citycontroller=TextEditingController();
  final statecontroller=TextEditingController();
  final countrycontroller=TextEditingController();
  final postalcontroller=TextEditingController();
  final phonecontroller=TextEditingController();
  final emailcontroller=TextEditingController();
  final supportemailcontroller=TextEditingController();
  final accountmangercontroller=TextEditingController();
  final notescontroller=TextEditingController();

  Future<void> createclient()async{
    if(isloading.value) return;

    try{
      isloading.value=true;

      final payload={
        "tenant":logincontroller.tenantid.value,
       "name": clientnamecontroller.text.trim(),
        "industry":industrycontroller.text.trim(),
       "website": websitecontroller.text.trim(),
       "registration_number": registercontroller.text.trim(),
       "tax_id":taxcontroller.text.trim(),
       "address_line1": addresscontroller.text.trim(),
       "address_line2":addresscontroller2.text.trim(),
        "city": citycontroller.text.trim(),
       "state": statecontroller.text.trim(),
        "country":countrycontroller.text.trim(),
        "postal_code":postalcontroller.text.trim(),
        "phone":phonecontroller.text.trim(),
        "email": emailcontroller.text.trim(),
        "support_email": supportemailcontroller.text.trim(),
       "account_manager": accountmangercontroller.text.trim(),
       "notes": notescontroller.text.trim(),
      };

      final response=await createClientService.createclient(payload);

       if (response['success'] == null) {
        issucess.value = false;
        } else {
        issucess.value = response['success'] == "Client company created";
          }

      /*Get.snackbar(
        issucess.value?"Client created succesfully":"Error",
        issucess.value?"Congrats":"Couldnt create Client",
        backgroundColor: issucess.value?Colors.green[200]:Colors.red[200],
        icon: issucess.value?Icon(Icons.verified,color: Colors.green,):
        Icon(Icons.error,color: Colors.red,),

      );*/
    }catch(e)
    {
      Get.snackbar("Network error", "$e");

      
    }
    finally{
      isloading.value=false;
    }
  }

  Future<void> updateclient(String userid)async{
      try{
        isloading.value=true;

        final payload={
        "tenant":logincontroller.tenantid.value,
       "name": clientnamecontroller.text.trim(),
        "industry":industrycontroller.text.trim(),
       "website": websitecontroller.text.trim(),
       "registration_number": registercontroller.text.trim(),
       "tax_id":taxcontroller.text.trim(),
       "address_line1": addresscontroller.text.trim(),
       "address_line2":addresscontroller2.text.trim(),
        "city": citycontroller.text.trim(),
       "state": statecontroller.text.trim(),
        "country":countrycontroller.text.trim(),
        "postal_code":postalcontroller.text.trim(),
        "phone":phonecontroller.text.trim(),
        "email": emailcontroller.text.trim(),
        "support_email": supportemailcontroller.text.trim(),
       "account_manager": accountmangercontroller.text.trim(),
       "notes": notescontroller.text.trim(),
        };



        final response=await createClientService.updateclient(payload,userid);
        
        issucess.value=response['success']=='Client company updated'?true:false;
        
      }
      catch(e)
      {
        Get.snackbar("Network error", "$e");
      }
      finally
      {
        isloading.value=false;
      }
  }
  
 
 void clearfield(){
    clientnamecontroller.clear();
    industrycontroller.clear();
   websitecontroller.clear();
       registercontroller.clear();
       taxcontroller.clear();
       addresscontroller.clear();
      citycontroller.clear();
       statecontroller.clear();
      countrycontroller.clear();
        postalcontroller.clear();
        phonecontroller.clear();
       emailcontroller.clear();
      supportemailcontroller.clear();
      accountmangercontroller.clear();
     notescontroller.clear();
  }

  @override
  void onClose() {
  clientnamecontroller.dispose();
    industrycontroller.dispose();
   websitecontroller.dispose();
       registercontroller.dispose();
       taxcontroller.dispose();
       addresscontroller.dispose();
      citycontroller.dispose();
       statecontroller.dispose();
      countrycontroller.dispose();
        postalcontroller.dispose();
        phonecontroller.dispose();
       emailcontroller.dispose();
      supportemailcontroller.dispose();
      accountmangercontroller.dispose();
     notescontroller.dispose();
    super.onClose();
  }
}