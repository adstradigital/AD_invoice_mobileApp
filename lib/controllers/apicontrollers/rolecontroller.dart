import 'package:ad_invoice_mobile/Service/roleservice.dart';
import 'package:ad_invoice_mobile/controllers/apicontrollers/logincontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Rolecontroller extends GetxController{
  final Roleservice roleservice = Get.find<Roleservice>();

  @override
  void onInit() {
    listro();
    getpermi();
    setCurrentRole();
    super.onInit();
  }

 
  var issuccess=false.obs;
  var roles=[].obs;
  var isloading=false.obs;
  var permission=[].obs;
   var selectedPermissionIds = <String>[].obs;
   var selectedRoleIds = <String>[].obs;
   var selectedRoleIdsedit=<String>[].obs;
  var currentUserRole = ''.obs;

   void setCurrentRole() {
    final Logincontroller logincontroller=Get.find<Logincontroller>();
    currentUserRole.value =logincontroller.role.value ;
  }

  bool hasPermission(String permissionCode) {
    try {
      // Find the role that matches the current user's role name
      final role = roles.firstWhere(
        (r) => r['name'] == currentUserRole.value,

        
        orElse: () => null,
      );

      if (role == null) return false;

      final rolePermissions = role['permissions'] as List;

      
      return rolePermissions.any((p) => p['code'] == permissionCode);
      
    } 
    catch (e) {
      return false;
    }
  }

  


    void toggleRole(String roleId) {
    if (selectedRoleIds.contains(roleId)) {
      selectedRoleIds.remove(roleId);
    } else {
      selectedRoleIds.add(roleId);
    }
    
  }

  bool isRoleSelected(String roleId) {
    return selectedRoleIds.contains(roleId);
  }

  void toggleRoleEdit(String roleId) {
  if (selectedRoleIdsedit.contains(roleId)) {
    selectedRoleIdsedit.remove(roleId);
  } else {
    selectedRoleIdsedit.add(roleId);
  }
}

bool isRoleSelectedEdit(String roleId) {
  return selectedRoleIdsedit.contains(roleId);
}
  
 
  void clearroleSelections() {
    selectedRoleIds.clear();
  }
  
  
 
  int get selectedroleCount => selectedRoleIds.length;
  
 
  List<dynamic> get selectedRoles {
    return roles.where((role) => selectedRoleIds.contains(role['id'].toString())).toList();
  }
   


   void togglePermission(String permissionId) {
    if (selectedPermissionIds.contains(permissionId)) {
      selectedPermissionIds.remove(permissionId);
    } else {
      selectedPermissionIds.add(permissionId);
    }
  }

   bool isPermissionSelected(String permissionId) {
    return selectedPermissionIds.contains(permissionId);
  }

  void clearSelections() {
    selectedPermissionIds.clear();
  }
  
  int get selectedCount => selectedPermissionIds.length;

  final TextEditingController namecontroller=TextEditingController();
  final TextEditingController descriptioncontroller=TextEditingController();

  final TextEditingController nameeditcontroller=TextEditingController();
  final TextEditingController descriptioneditcontroller=TextEditingController();


  Future<void> createro()async{

    try{
      isloading.value=true;
      final permissionIds = selectedPermissionIds.map((id) => int.parse(id)).toList();

      final payload={
        
      "name": namecontroller.text.trim().toLowerCase(),
      "description": descriptioncontroller.text.trim(),
       "permission_ids": permissionIds,

      };

      final response=await roleservice.createrole(payload);
  
      issuccess.value=response['name']==namecontroller.text?true:false;

     
      
      if(issuccess.value)
      {
        await listro();
        Get.snackbar("Role added", "You can now assign this role to user",backgroundColor: Colors.green[200],duration: Duration(seconds: 2));
        clearfields();
      }
      else{
        Get.snackbar("Role not created", "Try again",backgroundColor: Colors.red[200],duration: Duration(seconds: 2));
      }
      
    }
    catch(e)
    {
      Get.snackbar("Error", "$e");
    }
    finally{
      isloading.value=false;
    }
  }

  Future<void> listro()async{
    try{
      isloading.value=true;

      final response=await roleservice.listrole();
      roles.value=response;

    }
    catch(e)
    {
      Get.snackbar("Error in listing", "$e");
    }
    finally{
      isloading.value=false;
    }
  }

  Future<void> deletero(int roleid)async{

    try{
      isloading.value=true;

      final response=await roleservice.deleterole(roleid);
      
      issuccess.value=response['message']=='Deleted'?true:false;

      if(issuccess.value)
      {
        Get.snackbar("Role deleted", "Role no longer can be used",backgroundColor: Colors.green[200]);
       listro();
       
      }
      else{
        Get.snackbar("role could not be deleted", "try again");
      }
    }
    catch(e)
    {
      Get.snackbar("Error", "$e");
    }
    finally{
      isloading.value=false;
    }
  }

  Future<void> updatero(int roleid)async{

      try{
        isloading.value=true;

        final payload={
          "name": namecontroller.text.trim(),
      "description": descriptioncontroller.text.trim(),
       "permission_ids": selectedPermissionIds.map((id) => int.parse(id)).toList(),

        };
       
 
        final response=await roleservice.updaterole(payload, roleid);

  

        issuccess.value=response['name']==namecontroller.text?true:false;

        if(issuccess.value)
        {
          listro();
          Get.back();
          Get.snackbar("Role Updated Successfully", "Changes made",backgroundColor: Colors.green[200]);
          clearfields();
        }
        else{
          Get.snackbar("Couldnt update role", "try again",backgroundColor: Colors.red[200]);
        }
      }
      catch(e)
      {
        Get.snackbar("Error in updating role", "$e");
      }
      finally{
        isloading.value=false;
      }
  }

  Future<void> getpermi()async{

    try{
      isloading.value=true;

      final response=await roleservice.getpermissions();
      permission.value=response;
    
    }
    catch(e)
    {
      Get.snackbar("Error", "$e");

    }
    finally{
      isloading.value=false;
    }
  }

  void clearfields(){
    namecontroller.clear();
    descriptioncontroller.clear();
  }
}