
import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class ProductServiceedit extends StatelessWidget {

  
  ProductServiceedit({super.key});

  final Map<String,dynamic>? product=Get.arguments;



  @override
  Widget build(BuildContext context) {
    final namecontroller=TextEditingController(text: product!['name']);
    final pricecontroller= TextEditingController(text: product!['type']=='product'?product!['price'].toString():
    
  product!['price'].toString());
    final quantitycontroller=TextEditingController(text: product!['type']=='product'?product!['quantity'].toString():
    product!['quantity'].toString());
    final categorycontroller=TextEditingController(text: product!['type']);

    if(product==null)
    {
      return Scaffold(
        body: Text("No data received"),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          
          children: [
            SizedBox(height: 10,),
            TextField(
              controller: namecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: pricecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                label: product!['type']=='product'?Text("Price"):Text("Rate per hour"),
                ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: quantitycontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                label: product!['type']=='product'?Text("Quantity"):Text("Workers"),
                ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: categorycontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                label: Text("Category",style: TextStyle(fontWeight: FontWeight.bold),)),
            ),
            SizedBox(height: 10,),
            Custombutton(label: "Edit", onpressed: (){

              final updated=<String,dynamic>{
                'name':namecontroller.text,
                'Category':categorycontroller.text,

              };

              if(product!['type']=='product')
              {
                 updated['price']=int.tryParse(pricecontroller.text) ?? 0;
                updated['quantity']=int.tryParse(quantitycontroller.text)??0;
              }

              else if(product!['type']=='service')
              {
                updated["price"]=int.tryParse(pricecontroller.text)??0;
                updated['quantity']=int.tryParse(quantitycontroller.text)??0;
              }
              
              Get.back(result: updated);
            })
          ],
          
        ),
      ),
    );
  }
}