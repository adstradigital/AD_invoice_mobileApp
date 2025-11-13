import 'package:ad_invoice_mobile/controllers/apicontrollers/rolecontroller.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/Subscreens/usermanagement/permissionlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Editrole extends StatelessWidget {
  final Rolecontroller rolecontroller=Get.find<Rolecontroller>();
   Editrole({super.key});

  @override
  Widget build(BuildContext context) {
    final args=Get.arguments;
    final role=args;

    rolecontroller.nameeditcontroller.text=role['name'];
    rolecontroller.descriptioneditcontroller.text=role['description'];
      rolecontroller.selectedPermissionIds.value = 
      (role['permissions'] as List)
          .map<String>((perm) => perm['id'].toString())
          .toList();
    
    return Scaffold(
  appBar: AppBar(
    title: Text("Edit Role"),
    backgroundColor: Colors.blue,
  ),
  body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
   
          Text(
            "Role Name",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: rolecontroller.nameeditcontroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Enter role name",
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          
          SizedBox(height: 20),
          
        
          Text(
            "Description", 
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: rolecontroller.descriptioneditcontroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Enter role description",
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            maxLines: 3,
          ),
          
          SizedBox(height: 20),
          
    
          Row(
            children: [
              Text(
                "Permissions",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Obx(() => Text(
                "(${rolecontroller.permission.length} available)",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              )),

            InkWell(
              onTap: (){
                final permission=rolecontroller.permission;
                Get.to(()=>Permissionlist(),arguments: permission);
              },
              child: Text("(See permissions)",style: TextStyle(fontSize: 14, color: Colors.blue[300],fontWeight: FontWeight.bold),),
            ),
          
            ],
          ),
          SizedBox(height: 8),
          
         
          Expanded(
  child: Obx(() => rolecontroller.permission.isEmpty
      ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.list_alt, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                "No permissions available",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        )
      : ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: rolecontroller.permission.length,
          itemBuilder: (context, index) {
            final permi = rolecontroller.permission[index];
            final permId = permi['id'].toString();

            // 🔹 Wrap inside a smaller Obx for reactivity
            return Obx(() {
              final isSelected =
                  rolecontroller.selectedPermissionIds.contains(permId);

              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(
                    isSelected
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: isSelected ? Colors.green : Colors.grey,
                    size: 28,
                  ),
                  title: Text(
                    "${permi['code']}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    rolecontroller.togglePermission(permId);
                  },
                ),
              );
            });
          },
        ),
  ),
),
          
          SizedBox(height: 20),
          
         Obx((){
              final count=rolecontroller.selectedPermissionIds.length;

              return Text(
                count<1?
                "No permission selected":"${rolecontroller.selectedPermissionIds.length} permissions selected",
                 style: TextStyle(fontWeight: FontWeight.bold, color:count<1? Colors.red[800]:Colors.blue[800]),
               );
         }),
         
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Custombutton(
                label: "Save Changes", 
                onpressed: () async {
              
                  if (rolecontroller.nameeditcontroller.text.isEmpty || 
                      rolecontroller.descriptioneditcontroller.text.isEmpty) {
                    Get.snackbar(
                      "Missing Fields",
                      "Please fill all required fields",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  
                  await rolecontroller.updatero(args);
                  
                  if (rolecontroller.issuccess.value) {
                    Get.back();
                    Get.snackbar(
                      "Success", 
                      "Role updated successfully",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  }
                },
              ),
            ),
          ),
           
        ],
      ),
    ),
  ),
);

  }
}