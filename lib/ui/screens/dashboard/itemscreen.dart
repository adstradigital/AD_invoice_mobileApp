import 'package:ad_invoice_mobile/controllers/apicontrollers/productlistcontroller.dart';
import 'package:ad_invoice_mobile/controllers/apicontrollers/rolecontroller.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/Subscreens/addnewproductscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/Subscreens/addnewservicescreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/Subscreens/product_servicefulldetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Itemscreen extends StatelessWidget {
  const Itemscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Productlistcontroller productlistcontroller = Get.find<Productlistcontroller>();
    final Rolecontroller rolecontroller = Get.find<Rolecontroller>();
    final screenheight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Items Management",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          
          backgroundColor: Colors.white,
          elevation: 1,
          bottom: TabBar(
            labelColor: Colors.blue[700],
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: Colors.blue[700],
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            tabs: [
              Tab(text: "Products"),
              Tab(text: "Services"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Products Tab
            Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product List",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        "Total: ${productlistcontroller.products.where((item) => item['type'] == 'product'.toLowerCase()).length}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
               rolecontroller.hasPermission('list_product_service') 
    ? Expanded(
        child: Obx(() {
          final products = productlistcontroller.products
              .where((item) => item['type'] == 'product'.toLowerCase())
              .toList();

          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No Products Found",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Add your first product to get started",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  onTap: () {
                    Get.to(() => ProductServicefulldetails(), arguments: product);
                  },
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shopping_bag,
                      color: Colors.blue[700],
                      size: 20,
                    ),
                  ),
                  title: Text(
                    product['name'] ?? 'Unnamed Product',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  subtitle: product['description'] != null &&
                          product['description'].isNotEmpty
                      ? Text(
                          product['description'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey[500],
                  ),
                ),
              );
            },
          );
        }),
      )
    : Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                "Access Denied",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "You don’t have permission to view products.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
                rolecontroller.hasPermission('create_product_service')
    ? Container(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 200,
          child: Custombutton(
            label: "Add New product",
            onpressed: () {
              Get.to(() => Addnewservicescreen());
            },
          ),
        ),
      )
    : Container(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 200,
          child: Opacity(
            opacity: 0.6, // 👈 faded appearance for disabled state
            child: Custombutton(
              label: "No Permission",
              onpressed: () {
                Get.snackbar(
                  "Access Denied",
                  "You don’t have permission to create a new Product.",
                  backgroundColor: Colors.red[50],
                colorText: Colors.red[700],
                snackPosition: SnackPosition.BOTTOM,
                );
              },
            ),
          ),
        ),
      ),
              ],
            ),

            // Services Tab
            Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Service List",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        "Total: ${productlistcontroller.products.where((item) => item['type'] == 'service').length}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
               rolecontroller.hasPermission('list_product_service') 
    ? Expanded(
        child: Obx(() {
          final products = productlistcontroller.products
              .where((item) => item['type'] == 'service'.toLowerCase())
              .toList();

          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No Service Found",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Add your first service to get started",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  onTap: () {
                    Get.to(() => ProductServicefulldetails(), arguments: product);
                  },
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shopping_bag,
                      color: Colors.blue[700],
                      size: 20,
                    ),
                  ),
                  title: Text(
                    product['name'] ?? 'Unnamed Service',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  subtitle: product['description'] != null &&
                          product['description'].isNotEmpty
                      ? Text(
                          product['description'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey[500],
                  ),
                ),
              );
            },
          );
        }),
      )
    : Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                "Access Denied",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "You don’t have permission to view services.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
               rolecontroller.hasPermission('create_product_service')
    ? Container(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 200,
          child: Custombutton(
            label: "Add New Service",
            onpressed: () {
              Get.to(() => Addnewservicescreen());
            },
          ),
        ),
      )
    : Container(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 200,
          child: Opacity(
            opacity: 0.6, // 
            child: Custombutton(
              label: "No Permission",
              onpressed: () {
                Get.snackbar(
                  "Access Denied",
                  "You don’t have permission to create a new service.",
                 backgroundColor: Colors.red[50],
                colorText: Colors.red[700],
                snackPosition: SnackPosition.BOTTOM,
                );
              },
            ),
          ),
        ),
      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}