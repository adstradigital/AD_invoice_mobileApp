
import 'package:ad_invoice_mobile/ui/screens/dashboard/RIP/invoice/invoicefirstscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/RIP/propsals/proposalpreviewscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class Proposalthirdscreen extends StatelessWidget {
  const Proposalthirdscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenheight=MediaQuery.of(context).size.height;
    final screenwidth=MediaQuery.of(context).size.width;
    final args=Get.arguments as Map<String,dynamic>;
    final List<Map<String,dynamic>> items=List<Map<String,dynamic>>.from(args['items']);
    return Scaffold(
      appBar: AppBar(title: Text("Proposals",style: TextStyle(fontWeight: FontWeight.bold),),
      backgroundColor: Colors.blue,
      
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          SizedBox(
            height: screenheight*0.82,
            child: Proposalpreviewscreen(printbutton: false,),
          ),
          Divider(thickness: 2,color: Colors.grey,),
          Container(
            alignment: Alignment.center,
              height: screenheight*0.8,
              constraints: BoxConstraints(maxWidth: screenwidth*0.8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 3),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context,index)
                {     
                    final item=items[index];
                    return Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 3,
                      child: ListTile(
                        leading: Icon(Icons.insert_comment_rounded),
                        tileColor: Colors.blue[50],
                        isThreeLine: true,
                        title: Text("${item['name']}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                        subtitle: Text("${item['description']}",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                      ),
                    );
                })
                
           ),

          SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(onPressed: (){

                  Get.to(()=>Invoicefirstscreen(),arguments: Get.arguments);
                }, label: Text("Download"),icon: Icon(Icons.download,color: Colors.green,size: 30,), ),
                SizedBox(width: 5,),
                ElevatedButton.icon(label: Text("Print"),onPressed: (){},icon: Icon(Icons.print,color: Colors.blue,size: 30,),),
                 SizedBox(width: 5,),
                ElevatedButton.icon(onPressed: (){}, label: Text("Mail"),icon: Icon(Icons.mail,color: Colors.red,size: 30,),)
              ],
            )
          ],
        ),
      ),
    );
  }
}