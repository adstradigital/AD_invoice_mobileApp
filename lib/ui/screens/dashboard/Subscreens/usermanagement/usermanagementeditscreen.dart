import 'package:ad_invoice_mobile/controllers/apicontrollers/rolecontroller.dart';
import 'package:ad_invoice_mobile/controllers/apicontrollers/usermanagementcontroller.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Usermanagementeditscreen extends StatelessWidget {


  
   Usermanagementeditscreen({super.key});
  
  final Usermanagementcontroller usermanagementcontroller=Get.find<Usermanagementcontroller>();
  final Rolecontroller rolecontroller = Get.find<Rolecontroller>();
  final formkey = GlobalKey<FormState>();

  
  
  @override
  Widget build(BuildContext context) {

    
    final args=Get.arguments;
    final user=args;

    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
   usermanagementcontroller.usernameeditcontroller.text=user['username'];
   usermanagementcontroller.emaileditcontroller.text=user['email'];
   usermanagementcontroller.passwordeditcontroller.text="Enter new password";
   usermanagementcontroller.firsteditcontroller.text=user['first_name'];
   usermanagementcontroller.lasteditcontroller.text=user['last_name'];
   rolecontroller.selectedRoleIdsedit.value = user['roles']
    .map<String>((role) => role['id'].toString())
    .toList();
    
    
     return Scaffold(
      appBar: AppBar(
        title: Text("Edit User"),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: screenheight / 2 * 1.2,
                width: screenwidth,
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    TextFormField(
                      controller: usermanagementcontroller.usernameeditcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "User name is required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: Text("User name"),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: usermanagementcontroller.emaileditcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "email required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: Text("Email"),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: usermanagementcontroller.passwordeditcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: Text("Password"),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: usermanagementcontroller.firsteditcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: Text("Firstname"),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: usermanagementcontroller.lasteditcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: Text("Lastname"),
                      ),
                    ),
                    SizedBox(height: 20),
                    
                
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Roles *",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        
                    
                        Obx(() => rolecontroller.selectedRoleIdsedit.isNotEmpty
                            ? Card(
                                color: Colors.blue[50],
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      Icon(Icons.check_circle, color: Colors.blue, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        "${rolecontroller.selectedRoleIdsedit.length} roles selected",
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800]),
                                      ),
                                      Spacer(),
                                      TextButton(
                                        onPressed: () => rolecontroller.clearroleSelections(),
                                        child: Text("Clear", style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox()
                        ),
                        SizedBox(height: 8),
                        
                       
                        Container(
                          height: 200, 
                          child: Obx(() {
                            if (rolecontroller.roles.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.people_alt, size: 64, color: Colors.grey),
                                    SizedBox(height: 16),
                                    Text(
                                      "No roles available",
                                      style: TextStyle(color: Colors.grey, fontSize: 16),
                                    ),
                                  ],
                                ),
                              );
                            }
                            
                            return ListView.builder(
                              itemCount: rolecontroller.roles.length,
                              itemBuilder: (context, index) {
                                final role = rolecontroller.roles[index];
                                
                                
                                return Card(
                                  
                                  elevation: 2,
                                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  //color: isSelected ? Colors.blue[50] : Colors.white,
                                  child: Obx((){
                                    final isSelected = rolecontroller.selectedRoleIdsedit.contains(role['id'].toString());
                                    return ListTile(
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: isSelected ? Colors.blue[100] : Colors.grey[100],
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                                        color: isSelected ? Colors.blue : Colors.grey,
                                      ),
                                    ),
                                    title: Text(
                                      role['name'] ?? 'Unnamed Role',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: isSelected ? Colors.blue[800] : Colors.black,
                                      ),
                                    ),
                                    subtitle: role['description'] != null 
                                        ? Text(
                                            role['description'],
                                            style: TextStyle(
                                              color: isSelected ? Colors.blue[600] : Colors.grey[600],
                                            ),
                                          )
                                        : null,
                                    onTap: () {
                                      rolecontroller.selectedRoleIdsedit.value = [role['id'].toString()];
                                    },
                                  );
                                  })
                                );
                              },
                            );
                          }),
                        ),
                        
                       
                        Obx(() => rolecontroller.selectedRoleIdsedit.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Please select a role",
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              )
                            : SizedBox()
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Custombutton(
                  label: "Discard", 
                  onpressed: () {
                    rolecontroller.clearSelections(); 
                    Get.back();
                  }
                ),
                SizedBox(width: 20),
                Custombutton(
                  label: "Save", 
                  onpressed: () async {
                   
                    if (!formkey.currentState!.validate()) {
                      Get.snackbar("Error", "Please fill all required fields");
                      return;
                    }
                    
                    if (rolecontroller.selectedRoleIdsedit.isEmpty) {
                      Get.snackbar("Error", "Please select at least one role");
                      return;
                    }
                    
                    await usermanagementcontroller.updateus(user['id']);
                    if (usermanagementcontroller.issuccess.value) {
                      usermanagementcontroller.clearfield();
                      rolecontroller.clearSelections(); 
                      usermanagementcontroller.getus();
                    } else {
                      Get.snackbar("Sorry", "Please try again");
                    }
                  }
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}