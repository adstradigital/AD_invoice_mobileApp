import 'package:ad_invoice_mobile/controllers/proposalsecondscreencontroller.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/RIP/invoice/invoicesecondscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmergencyInvoice extends StatelessWidget {
  const EmergencyInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    final Proposalsecondscreencontroller proposalsecondscreencontroller=Get.find<Proposalsecondscreencontroller>();
    final screenheight=MediaQuery.of(context).size.height;

    final namecontroller=TextEditingController();
    final phonecontroller=TextEditingController();
    final locationcontroller=TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Invoice"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enter Client Details",style: TextStyle(fontWeight: FontWeight.bold,),),
                    SizedBox(height: 10,),
                    TextField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        labelText:"Client name" ,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 12,),
                    TextField(
                      controller: phonecontroller,
                      decoration: InputDecoration(
                        labelText:"Company" ,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 12,),
                    TextField(
                      controller: locationcontroller,
                      decoration: InputDecoration(
                        labelText:"Location" ,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 12,),
                    Text("Available Items",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    Obx(()=>SizedBox(
                      height: screenheight*0.4,
                      child: ListView.builder(
                        
                        itemCount: proposalsecondscreencontroller.filteredproduct.length,
                        itemBuilder: (context,index)
                      {
                        final item=proposalsecondscreencontroller.filteredproduct[index];
                        return Card(
                          elevation: 6,
                          child: Obx((){
                            if(proposalsecondscreencontroller.isloading.value==false)
                            {
                              Center(child: CircularProgressIndicator(color: Colors.blue,));
                            }
                            final isselected=proposalsecondscreencontroller.selecteditemindex.contains(index);
                            return ListTile(
                              onTap: ()=> proposalsecondscreencontroller.selections(index),
                              
                            title: Text(item['name']),
                            subtitle: item['type']=='product'?Text("Price :${item['price']}\nCategory :${item['type']}"):
                            Text("Rate :${item['price']}\nCategory :${item['type']}"),
                            tileColor: isselected?Colors.blue[300]:Colors.grey[300],
                            trailing: isselected?Icon(Icons.check_outlined,color: Colors.green,):Icon(Icons.circle_outlined),
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),  
                          );
                          }) 
                        );
                      })
                    )),
            SizedBox(height: 15),        
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
             Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Custombutton(label: "Back", onpressed: (){}),
                        SizedBox(width: 10,),
                        Custombutton(label: "Next", onpressed: (){
                          final client={
                            'name':namecontroller.text,
                            'Location':locationcontroller.text,
                            'Company':phonecontroller.text,
                          };

                          var selecteditems=proposalsecondscreencontroller.selecteditemindex.map((i)=>proposalsecondscreencontroller.items[i]).toList();
                       Get.to(()=>Invoicesecondscreen(),arguments: {
                            'items':selecteditems,
                            'clients':client
                          });
                        }),
                      ],
                    ),
          ],
        ),
      ),
    );
    
  }
}