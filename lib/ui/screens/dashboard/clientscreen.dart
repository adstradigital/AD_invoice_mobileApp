import 'package:ad_invoice_mobile/controllers/apicontrollers/listclientcontroller.dart';
import 'package:ad_invoice_mobile/controllers/apicontrollers/rolecontroller.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/Subscreens/addnewclientscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/Subscreens/clientfulldetails.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/Subscreens/editclientscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Clientscreen extends StatelessWidget {
  Clientscreen({super.key});

  final Listclientcontroller listclientcontroller = Get.find<Listclientcontroller>();
    final Rolecontroller rolecontroller = Get.find<Rolecontroller>();

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    
    return Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Clients",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              Obx(() => Text(
                "${listclientcontroller.sortedclients.length} clients",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              )),
            ],
          ),
        ),

        // Clients List or Empty State
        Expanded(
          child: Obx(() => listclientcontroller.sortedclients.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 64,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "No Clients Found",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Get started by adding your first client",
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: listclientcontroller.sortedclients.length,
                  itemBuilder: (context, index) {
                    final client = listclientcontroller.sortedclients[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Card(
                        elevation: 2,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue[100],
                            child: Icon(
                              Icons.person,
                              color: Colors.blue[700],
                              size: 20,
                            ),
                          ),
                          title: Text(
                            client["name"]!,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                client["email"] ?? "No email",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                client["phone"] ?? "No phone",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          trailing: rolecontroller.hasPermission('update_client')
                              ?IconButton(
                            onPressed: () {
                              Get.to(() => Editclientscreen(),arguments: client);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue[600],
                              size: 20,
                            ),
                          ):
                          Icon(Icons.edit_off, color: Colors.grey[500], size: 20),
                          onTap: () {
                           if(rolecontroller.hasPermission('view_client'))
                           {
                             Get.to(() => Clientfulldetails(), arguments: client);
                           }
                           else{
                            Get.snackbar("Permission Denied", "No permission to view client details",
                            backgroundColor: Colors.red[50],
                            colorText: Colors.red[700],);
                           }
                          },
                        ),
                      ),
                    );
                  },
                ),
          ),
        ),

        // Add Client Button
      rolecontroller.hasPermission('create_client')
  ? Container(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: Custombutton(
          label: "Add New Client",
          onpressed: () {
            Get.to(() => Addnewclientscreen());
          },
        ),
      ),
    )
  : Container(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: Opacity( 
          opacity: 0.5,
          child: Custombutton(
            label: "No Permission",
            onpressed: () {
              Get.snackbar(
                "Permission Denied",
                "You don’t have permission to add clients.",
                backgroundColor: Colors.red[50],
                colorText: Colors.red[700],
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
        ),
      ),
    )
     
      ],
    );
  }
}