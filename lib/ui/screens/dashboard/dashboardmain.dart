
import 'package:ad_invoice_mobile/controllers/apicontrollers/rolecontroller.dart';
import 'package:ad_invoice_mobile/controllers/dashboardcontroller.dart';
import 'package:ad_invoice_mobile/controllers/apicontrollers/notificationandsupportcontroller.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/registerscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/RIP/invoice/invoicefirstscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/RIP/propsals/proposalfirstscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/RIP/receipt/receiptfirstscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/Subscreens/addnewclientscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/clientscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/homescreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/Subscreens/reportscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/itemscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/settingscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/widgets/notificaionpanel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Dashboardmain extends StatelessWidget {
  Dashboardmain({super.key});

      final Dashboardcontroller dashboardcontroller = Get.find<Dashboardcontroller>();
    final Notificationandsupportcontroller notificationcontroller = Get.find<Notificationandsupportcontroller>();
    final Rolecontroller rolecontroller = Get.find<Rolecontroller>();

  @override
  Widget build(BuildContext context) {


    final List<Widget> screens = [
      Homescreen(),
      Clientscreen(),
      Itemscreen(),
      Settingscreen(),
    ];

    final bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    
    return Scaffold(
      appBar: AppBar(
  automaticallyImplyLeading: false,
  title: Row(
    children: [
      // Profile with circular background
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () {
            Get.to(() => Addnewclientscreen());
          },
          icon: Icon(Icons.person_outline, size: 18),
          tooltip: "Profile",
          padding: EdgeInsets.zero,
        ),
      ),
      SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back!",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            Text(
              "User Dashboard",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey[900],
              ),
            ),
          ],
        ),
      ),
    ],
  ),
  backgroundColor: Colors.white,
  elevation: 2,
  shadowColor: Colors.black12,
  actions: [
    // Notifications with badge
    Stack(
      children: [
        IconButton(
          onPressed: () {
            notificationcontroller.togglepanel();
            notificationcontroller.getnoti();
          },
          icon: Icon(Icons.notifications_outlined, size: 22),
          tooltip: "Notifications",
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    ),
    
    // More options
    PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, size: 22),
      onSelected: (value) {
        _handleMenuSelection(value, context);
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "invoices",
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.description, size: 16, color: Colors.blue[700]),
              ),
              SizedBox(width: 12),
              Text("Invoices", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        PopupMenuItem(
          value: "clients",
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.people, size: 16, color: Colors.green[700]),
              ),
              SizedBox(width: 12),
              Text("Clients", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        PopupMenuItem(
          value: "reports",
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.analytics, size: 16, color: Colors.orange[700]),
              ),
              SizedBox(width: 12),
              Text("Reports", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        PopupMenuItem(
          value: "items",
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.inventory_2, size: 16, color: Colors.purple[700]),
              ),
              SizedBox(width: 12),
              Text("Items", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ],
    ),
  ],
),
      
      body: 
      Stack(
        children: [
          Obx(() => screens[dashboardcontroller.selectedindex.value]),
          Notificaionpanel(),
        ],
      ),

      bottomNavigationBar: Obx(() => Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[200]!)),
        ),
        child: BottomNavigationBar(
          currentIndex: dashboardcontroller.selectedindex.value,
          onTap: dashboardcontroller.changetab,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue[700],
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: "Clients",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.inventory_2),
              label: "Items",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      )),

     floatingActionButton: Obx(()=>SpeedDial(
  backgroundColor: Colors.transparent,
  foregroundColor: Colors.blue[700],
  overlayColor: Colors.black54,
  buttonSize: Size(48, 48),
  icon: Icons.add,
  activeIcon: Icons.close,
  visible: true,
  curve: Curves.bounceIn,
  childMargin: EdgeInsets.all(8),
  childrenButtonSize: Size(44, 44),
  spacing: 8,
  children:[
    rolecontroller.hasPermission('create_invoice')
        ? SpeedDialChild( 
            backgroundColor: Colors.blue[700]!.withOpacity(0.9),
            foregroundColor: Colors.white,
            label: "New Invoice",
            onTap: () => Get.to(() => Invoicefirstscreen()),
            child: Icon(Icons.description, size: 18),
          )
        : SpeedDialChild(
            backgroundColor: Colors.grey[400],
            foregroundColor: Colors.white,
            label: "No permission for Invoice",
            onTap: () {
              Get.snackbar(
                "Access Denied",
                "You don't have permission to create an invoice",
                backgroundColor: Colors.red[50],
                colorText: Colors.red[700],
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Icon(Icons.block, size: 18),
          ),

    rolecontroller.hasPermission('create_proposal')
        ? SpeedDialChild(
            backgroundColor: Colors.blue[700]!.withOpacity(0.9),
            foregroundColor: Colors.white,
            label: "New Proposal",
            onTap: () => Get.to(() => Proposalfirstscreen()),
            child: Icon(Icons.receipt, size: 18),
          )
        : SpeedDialChild(
            backgroundColor: Colors.grey[400],
            foregroundColor: Colors.white,
            label: "No permission for Proposal",
            onTap: () {
              Get.snackbar(
                "Access Denied",
                "You don't have permission to create a proposal",
               backgroundColor: Colors.red[50],
                colorText: Colors.red[700],
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Icon(Icons.block, size: 18),
          ),

    rolecontroller.hasPermission('create_receipt')
        ? SpeedDialChild(
            backgroundColor: Colors.blue[700]!.withOpacity(0.9),
            foregroundColor: Colors.white,
            label: "New Receipt",
            onTap: () => Get.to(() => Receiptfirstscreen()),
            child: Icon(Icons.payment, size: 18),
          )
        : SpeedDialChild(
            backgroundColor: Colors.grey[400],
            foregroundColor: Colors.white,
            label: "No permission for Receipt",
            onTap: () {
              Get.snackbar(
                "Access Denied",
                "You don't have permission to create a receipt",
                backgroundColor: Colors.red[50],
                colorText: Colors.red[700],
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Icon(Icons.block, size: 18),
          ),
  ],
),)
    );
  }

  void _handleMenuSelection(String value, BuildContext context) {
    switch (value) {
      case "invoices":
        if( rolecontroller.hasPermission('create_invoice'))
        {
          Get.to(()=>Invoicefirstscreen());
        }
        else{
          Get.snackbar(
                "Access Denied",
                "You don't have permission to create or view an invoice",
                 backgroundColor: Colors.red[50],
                colorText: Colors.red[700],
                snackPosition: SnackPosition.BOTTOM,
              );
        }
        
        break;
      case "clients":
        if(rolecontroller.hasPermission('view_client'))
        {
          Get.to(() => Clientscreen());
        }
        else{
          Get.snackbar("Access denied", "No permission to view clients", backgroundColor: Colors.red[50],
                colorText: Colors.red[700],
                snackPosition: SnackPosition.BOTTOM,);
        }
        break;
      case "reports":
        Get.to(() => Reportscreen());
        break;
      case "items":
        if(rolecontroller.hasPermission('list_product_service'))
        {
          Get.to(() => Itemscreen());
        }
        else{
           Get.snackbar("Access denied", "No permission to view items",  backgroundColor: Colors.red[50],
                colorText: Colors.red[700],
                snackPosition: SnackPosition.BOTTOM,);
        }
        break;
    }
  }
}