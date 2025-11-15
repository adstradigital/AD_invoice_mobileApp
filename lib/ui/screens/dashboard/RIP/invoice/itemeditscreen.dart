import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';

class Itemeditscreen extends StatelessWidget {
  Itemeditscreen({super.key});

  final args=Get.arguments as Map<String,dynamic>;
  @override
  Widget build(BuildContext context) {

    final namecontroller=TextEditingController(text: args['name']);
    final pricecontroller=TextEditingController(text: args['item']=='product'?args['price'].toString():args['price'].toString());
    final quantitycontroller=TextEditingController(text: args['category']=='product'?args['quantity'].toString():args['quantity'].toString());
    final categorycontroller=TextEditingController(text: args['type']);
    return Scaffold(
      appBar: AppBar(title: Text("Edit"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
        
              controller: namecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                label: Text("Name"),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                label: args["type"]=='product'?Text("Price"):Text("Rate per hour"),
              ),
              controller: pricecontroller,   
            ),
            SizedBox(height: 10,),
            TextField(
              controller: quantitycontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                label: args['type']=='product'?Text("Quantity"):Text("Workers"),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: categorycontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                label: Text("Category")
              ),
            ),
            SizedBox(height: 10,),
            Custombutton(label: "Edit", onpressed: (){

              final updated=<String,dynamic>{
                'name':namecontroller.text,
                'type':categorycontroller.text,
              };
              if(args['type']=='product')
              {
                updated['price']=int.tryParse(pricecontroller.text)??0;
                updated['quantity']=int.tryParse(quantitycontroller.text);
              }
              else if(args['category']=='service')
              {
                updated['price']=int.tryParse(pricecontroller.text)??0;
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