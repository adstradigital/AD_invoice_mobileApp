
import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/RIP/invoice/emergency_invoice.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/RIP/invoice/invoicefirstscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/RIP/invoice/itemeditscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/RIP/invoice/previewscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Invoicesecondscreen extends StatefulWidget {
  const Invoicesecondscreen({super.key});

  @override
  State<Invoicesecondscreen> createState() => _InvoicesecondscreenState();
}

class _InvoicesecondscreenState extends State<Invoicesecondscreen> {

late List<Map<String,dynamic>> items;
    late Map<String,dynamic> client;
    

    @override
    void initState(){
      super.initState();
      final args=Get.arguments;
       items=List<Map<String,dynamic>>.from(args['items']??[]);
      client=Map<String,dynamic>.from(args['clients']);
    }
  
  @override
  Widget build(BuildContext context) {

    final screenheight=MediaQuery.of(context).size.height;
    //final screenwidth=MediaQuery.of(context).size.width;

    


    void delete(int index)
    {
      final updateditems=List<Map<String,dynamic>>.from(items);
      
      if(index>=0 && index<items.length)
      {updateditems.removeAt(index);
      Get.back();
      }
      {
        setState(() {
        items=updateditems;
      }
     
      );
      }
    }


   
    return Scaffold(
      appBar: AppBar(
        title: Text("invoice"),
        backgroundColor: Colors.blue,
      ),
      body:items.isEmpty?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox,size: 64,color: Colors.grey,),
            Text("NO ITEMS SELECTED!",style: TextStyle(fontSize: 20,color: Colors.red[300]),),
            SizedBox(height: 10,),
            Text("Please select items",style: TextStyle(color: Colors.grey),),
            SizedBox(height: 5,),

            Custombutton(label: "Go Back", onpressed: (){
              Get.to(()=>Invoicefirstscreen());
            })

          ],
        ),
      ):
      
      Column(
        children: [
          Center(child: Text("Hold item to delete!",style: TextStyle(fontSize: 12,color: Colors.red),)),
             Expanded(
               child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(items.isNotEmpty)...[
                      Text("Products/Services",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        ListView.builder(
                          key: Key("key:${items.length}"),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        
                        itemBuilder: (context,index)
                      {
                        if(index>=items.length) return SizedBox.shrink();
                        final item=items[index];
                        final isproduct=item['type']=='product';
                        return Card(
                          elevation: 6,
                          child: ListTile(
                            isThreeLine: true,
                            title: Text(item['name']),
                            subtitle: isproduct?Text("Price:${item['price']}\nQuantity:${item['quantity']}\n${item['type']}"):
                            Text("Rate:${item['price']}\nWorkers:${item['quantity']}\n${item['type']}"),
                            trailing: IconButton(onPressed: () async{
                                final updated=await Get.to(()=>Itemeditscreen(),arguments: item 
                                );
                                if(updated!=null)
                                { 
                                 setState(() {  
                                   items[index].addAll(updated);
                                 });
                                }
                            }, icon: Icon(Icons.edit,color: Colors.blue,)),
                            onLongPress: (){
                              final currentindex=index;
                              Get.defaultDialog(
                                title: "Delete item",
                                middleText: "Are you sure want to delete?",
                                textConfirm: "Delete",
                                textCancel: "Cancel",
                                buttonColor: Colors.red[400],
                                confirmTextColor: Colors.white,
                                onConfirm: (){
                                  
                                  delete(currentindex);
                                  Get.snackbar("Item deleted", "${item['name']} has been deleted!",duration: Duration(seconds: 1));
                                  //Get.back();
                                  
                                  
                                  
                                },
                                onCancel: () {},
                              );
                            },

                          ),
                        );
                      })
                    ],
 
                  ],
   
                )
              ),
             ),

          Divider(
            thickness: 2,
            color: Colors.grey[400],
          ),
          Container(
            height: screenheight/7,
            color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Choose from templates "),
                for(int i=1;i<=2;i++)...[
                 
                  GestureDetector(
                    onTap: (){
                      
                      Get.to(Previewscreen(),arguments: {'template':i,'items':items,'client':client});
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/template$i.jpeg"),
                        fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                  ),
                  if(i<2)SizedBox(width: 5,)
                ]
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
            Custombutton(label: "Back", onpressed: (){
              Get.back();
            }),
      
       ],
      ),
      
    );
    
  }
}