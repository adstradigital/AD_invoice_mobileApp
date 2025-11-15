import 'package:ad_invoice_mobile/controllers/proposalsecondscreencontroller.dart';

import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/RIP/propsals/product_serviceedit.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/RIP/propsals/proposalpreviewscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/RIP/propsals/proposalthirdscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Proposalsecondscreen extends StatelessWidget {
  const Proposalsecondscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Proposalsecondscreencontroller proposalsecondscreencontroller = Get.put(Proposalsecondscreencontroller());
    Map<String, dynamic> user = Get.arguments;
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Products/Services",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search and select items",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: screenwidth / 2 * 1.2,
              child: TextFormField(
                onChanged: (value) {
                  proposalsecondscreencontroller.filtering(value);
                },
                decoration: InputDecoration(
                  hintText: "Search product or service...",
                  suffixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue[700]!),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Obx(() {
                  if (proposalsecondscreencontroller.items.isEmpty) {
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
                            "No products or services found",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Try adjusting your search or add items first",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: proposalsecondscreencontroller.items.length,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      final product = proposalsecondscreencontroller.items[index];
                      return Obx(() {
                        final isselected = proposalsecondscreencontroller.selecteditemindex.contains(index);
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: isselected ? Colors.blue[700]! : Colors.grey[200]!,
                              width: isselected ? 2 : 1,
                            ),
                          ),
                          child: ListTile(
                            onTap: () => proposalsecondscreencontroller.selections(index),
                            tileColor: isselected ? Colors.blue[50] : Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: product['type'] == 'service' ? Colors.orange[100] : Colors.green[100],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                product['type'] == 'service' ? Icons.build : Icons.inventory_2,
                                color: product['type'] == 'service' ? Colors.orange[700] : Colors.green[700],
                                size: 20,
                              ),
                            ),
                            title: Text(
                              product['name'] ?? 'Unnamed Item',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                if (product['price'] != null && product['price'].isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      product['price'],
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                if (product['description'] != null && product['description'].isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      product['description'],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 13,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: product['type'] == 'service' ? Colors.orange[50] : Colors.green[50],
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: product['type'] == 'service' ? Colors.orange[200]! : Colors.green[200]!,
                                    ),
                                  ),
                                  child: Text(
                                    product['type'] == 'service' ? 'SERVICE' : 'PRODUCT',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: product['type'] == 'service' ? Colors.orange[700] : Colors.green[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    final updated = await Get.to(() => ProductServiceedit(), arguments: product);
                                    if (updated != null) {
                                      proposalsecondscreencontroller.updated(product, updated);
                                    }
                                  },
                                  icon: Icon(Icons.edit, color: Colors.blue[600], size: 20),
                                  tooltip: "Edit",
                                ),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isselected ? Colors.blue[700] : Colors.transparent,
                                    border: Border.all(
                                      color: isselected ? Colors.blue[700]! : Colors.grey[400]!,
                                      width: 2,
                                    ),
                                  ),
                                  child: isselected
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Custombutton(
                      label: "Clear Selection",
                      onpressed: () {
                        proposalsecondscreencontroller.selecteditemindex.clear();
                      },
                     
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Custombutton(
                      label: "Continue",
                      onpressed: () {
                        var selecteditems = proposalsecondscreencontroller.selecteditemindex
                            .map((i) => proposalsecondscreencontroller.items[i])
                            .toList();
                            
                        if (selecteditems.isNotEmpty) {
                          Get.to(() => Proposalpreviewscreen(), arguments: {
                            'items': selecteditems,
                            'clients': user,
                          });
                        } else {
                          Get.snackbar(
                            "Selection Required",
                            "Please select at least one item to continue",
                            backgroundColor: Colors.orange[700],
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.all(16),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}