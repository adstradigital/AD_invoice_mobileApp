import 'package:ad_invoice_mobile/controllers/apicontrollers/registrationcontroller.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/loginscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/messagescreen.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/widgets/customforfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Forgotscreen extends StatelessWidget {
  Forgotscreen({super.key});

  

  final Registrationcontroller registrationcontroller=Get.find<Registrationcontroller>();
  

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);

    Widget forgotForm = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Logo
        Image.asset(
          'assets/logo.png',
          width: isMobile ? 50 : 80,
          height: isMobile ? 70 : 100,
        ),

        const SizedBox(height: 20),

        /// Title
        Center(
          child: Text(
            "Verify",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 20 : 26,
              color: Colors.grey,
            ),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "Enter mobile to verify",
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: isMobile ? 14 : 16),
        ),

        const SizedBox(height: 20),
        /// Mobile + OTP row
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Customforfield(
                controller: registrationcontroller.otpphonecontroller,
                hinttext: "Enter your mobile",
                prefixicon: Icons.phone_android,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Custombutton(label: "OTP", onpressed: ()async {

                await registrationcontroller.sendot();
                   if(registrationcontroller.issuccess.value)
      {
        Get.snackbar("Otp has send", "Please check your messages",backgroundColor: Colors.green[200],
        icon: Icon(Icons.verified),
        );
        
      }
      else{
        Get.snackbar("Error sending otp", "Try again");
      }
              }),
            ),
          ],
        ),

        const SizedBox(height: 20),

        /// Mobile OTP input
       TextFormField(
        onChanged: (value) => {
          registrationcontroller.enteredotp.value=value
        },
controller: registrationcontroller.otpverifycontroller,
decoration: InputDecoration(
  fillColor: Colors.grey[350],
  filled: true,
  hintText: "Enter otp",
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  
),
       ),

        const SizedBox(height: 40),

        /// Submit button
      Obx(() {
  bool isMatch = registrationcontroller.enteredotp.value.trim().isNotEmpty &&
               registrationcontroller.enteredotp.value.trim() ==
               registrationcontroller.otpvalue.value.trim();

  return isMatch
      ? SizedBox(
          width: double.infinity,
          child: Custombutton(
            label: "Submit",
            onpressed: () {
           
           Get.to(Loginscreen());
           registrationcontroller.otpphonecontroller.clear();
           registrationcontroller.otpphonecontroller.clear();
              
            },
          ),
        )
      : SizedBox(
  width: double.infinity,
  child: Opacity(
    opacity: 0.2, 
    child: ElevatedButton(
      
      onPressed: null, // DISABLED
      style: ElevatedButton.styleFrom(
        
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        "Submit",
        style: TextStyle(fontSize: 16),
      ),
    ),
  ),
);
})
      ],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          /// Background image
          Positioned.fill(
            child: Image.asset(
              "assets/finance.jpg",
              fit: BoxFit.fill,
            ),
          ),

          /// Form
          Align(
            alignment: const Alignment(0, -0.6),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: isMobile
                  ? forgotForm
                  : Center(
                      child: Card(
                        color: Colors.black.withOpacity(0.5),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),

      /// Footer
      bottomNavigationBar: Container(
        height: 100,
        color: Colors.transparent,
        child: Center(
          child: Text(
            "© 2025 ADSTRA DIGITAL",
            style: TextStyle(
              color: const Color.fromARGB(255, 43, 40, 40),
              fontSize: isMobile ? 12 : 14,
            ),
          ),
        ),
      ),
    );
  }
}
