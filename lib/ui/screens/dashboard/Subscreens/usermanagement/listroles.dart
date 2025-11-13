import 'package:ad_invoice_mobile/controllers/apicontrollers/rolecontroller.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/Subscreens/usermanagement/createrolepage.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/Subscreens/usermanagement/editrole.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Listroles extends StatelessWidget {
  Listroles({super.key});

  final Rolecontroller rolecontroller = Get.find<Rolecontroller>();

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "User Management",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        elevation: 2,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Text(
              "Manage Roles",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 8),
            Divider(thickness: 1, color: Colors.grey[300]),

            // 🔹 Role List
            Expanded(
              child: SizedBox(
                height: screenheight / 2 * 1.3,
                child: Obx(() => rolecontroller.roles.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shield_moon_rounded,
                                color: Colors.grey[400], size: 60),
                            const SizedBox(height: 10),
                            Text(
                              "No roles available",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: rolecontroller.roles.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final role = rolecontroller.roles[index];
                          return Card(
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              onLongPress: () {
                                Get.defaultDialog(
                                  title: "Delete Role",
                                  middleText:
                                      "Are you sure you want to delete this role? This action cannot be undone.",
                                  textConfirm: "Yes, Delete",
                                  textCancel: "Cancel",
                                  confirmTextColor: Colors.white,
                                  buttonColor: Colors.red,
                                  onConfirm: () async {
                                    Get.back();
                                    await rolecontroller.deletero(role['id']);
                                  },
                                  onCancel: () {
                                    Get.back();
                                  },
                                );
                              },
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.blue[100],
                                child: Icon(Icons.shield,
                                    color: Colors.blue[700], size: 22),
                              ),
                              title: Text(
                                "${role['name']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              subtitle: Text(
                                "${role['description'] ?? 'No description'}",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.settings,
                                    color: Colors.black87),
                                onPressed: () {
                                  Get.to(() => Editrole(), arguments: role);
                                },
                              ),
                            ),
                          );
                        },
                      )),
              ),
            ),

            const SizedBox(height: 12),
            Divider(thickness: 1, color: Colors.grey[300]),
            const SizedBox(height: 10),

            // 🔹 Bottom Buttons
            Column(
              children: [
                SizedBox(
                  width: 220,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.to(Createrolepage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      padding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.add_moderator, color: Colors.white),
                    label: const Text(
                      "Create New Role",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 220,
                  child: Custombutton(
                    label: "Back",
                    onpressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}