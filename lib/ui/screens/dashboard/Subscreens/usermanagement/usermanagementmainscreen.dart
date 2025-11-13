import 'package:ad_invoice_mobile/controllers/apicontrollers/rolecontroller.dart';
import 'package:ad_invoice_mobile/controllers/apicontrollers/usermanagementcontroller.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/Subscreens/usermanagement/listroles.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/Subscreens/usermanagement/usermanagementeditscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/Subscreens/usermanagement/usermanagementsecondscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Usermanagementmainscreen extends StatelessWidget {
  Usermanagementmainscreen({super.key});

  final Usermanagementcontroller usermanagementcontroller = Get.find<Usermanagementcontroller>();
  final Rolecontroller rolecontroller = Get.find<Rolecontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Management",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Manage Users",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 4),
                    Obx(() => Text(
                      "${usermanagementcontroller.users.length} users",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    )),
                  ],
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Get.to(() => Listroles());
                  },
                  icon: Icon(Icons.admin_panel_settings, size: 18),
                  label: Text("Manage Roles"),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue[700]!),
                    foregroundColor: Colors.blue[700],
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ),

          // Users List
          Expanded(
            child: Obx(() => usermanagementcontroller.users.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 16),
                        Text(
                          "No Users Found",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Add your first user to get started",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: usermanagementcontroller.users.length,
                    itemBuilder: (context, index) {
                      final user = usermanagementcontroller.users[index];
                      final roleName = user['roles'] != null && user['roles'].isNotEmpty 
                          ? user['roles'][0]['name'] ?? 'No Role'
                          : 'No Role';
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Card(
                          elevation: 2,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue[50],
                              radius: 20,
                              child: Icon(
                                Icons.person,
                                color: Colors.blue[700],
                                size: 18,
                              ),
                            ),
                            title: Text(
                              user['username'] ?? 'Unnamed User',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getRoleColor(roleName),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    roleName,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    rolecontroller.selectedRoleIds.value =
                                        (user['roles'] as List)
                                            .map((r) => r['id'].toString())
                                            .toList();
                                    Get.to(() => Usermanagementeditscreen(), arguments: user);
                                  },
                                  icon: Icon(Icons.edit, color: Colors.blue[600], size: 20),
                                  tooltip: "Edit User",
                                ),
                                IconButton(
                                  onPressed: () {
                                    Get.dialog(
                                      AlertDialog(
                                        title: Text(
                                          "Delete User",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        content: Text("Are you sure you want to delete ${user['username']}? This action cannot be undone."),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Get.back(),
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await usermanagementcontroller.deleteus(user['id']);
                                              Get.back();
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.delete_outline, color: Colors.red[400], size: 20),
                                  tooltip: "Delete User",
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )),
          ),

          // Add User Button
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  rolecontroller.selectedRoleIds.clear();
                  Get.to(() => Usermanagementsecondscreen());
                },
                icon: Icon(Icons.person_add, size: 20),
                label: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "Add New User",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(String roleName) {
    switch (roleName.toLowerCase()) {
      case 'admin':
        return Colors.red[400]!;
      case 'super admin':
        return Colors.purple[400]!;
      case 'user':
        return Colors.green[400]!;
      case 'editor':
        return Colors.orange[400]!;
      default:
        return Colors.grey[400]!;
    }
  }
}