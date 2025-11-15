import 'package:ad_invoice_mobile/controllers/apicontrollers/registrationcontroller.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/loginscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;

class Registerscreen extends StatelessWidget {
  const Registerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Registrationcontroller registrationcontroller =
        Get.put(Registrationcontroller());

    final bool isMobile =
        responsive.ResponsiveBreakpoints.of(context).smallerThan(responsive.TABLET);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),

      body: Stack(
        children: [
          /// Background
          Positioned.fill(
            child: Image.asset(
              "assets/finance.jpg",
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.35),
              colorBlendMode: BlendMode.darken,
            ),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isMobile ? 380 : 450,
                ),

                /// Main Card
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Logo
                      Image.asset(
                        'assets/logo.png',
                        width: 120,
                        height: 120,
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "We are excited for a new partnership",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[200],
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 25),

                      Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.7,
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// Form Fields
                      _buildField(
                        controller: registrationcontroller.firstnamecontroller,
                        hint: "Enter your First Name",
                      ),

                      _buildField(
                        controller: registrationcontroller.lastnamecontroller,
                        hint: "Enter your Last Name",
                      ),

                      _buildField(
                        controller: registrationcontroller.emailcontroller,
                        hint: "Enter your Email",
                      ),

                      _buildField(
                        controller: registrationcontroller.phonecontroller,
                        hint: "Enter your Phone",
                      ),

                      _buildField(
                        controller: registrationcontroller.addresscontroller,
                        hint: "Enter your Address",
                      ),

                      TextField(
                        onTap: () => registrationcontroller.pickdate(),
                        controller: registrationcontroller.dobcontroller,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter DOB",
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          suffixIcon: const Icon(Icons.calendar_month, color: Colors.blue),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      _buildField(
                        controller: registrationcontroller.companycontroller,
                        hint: "Enter your Company Name",
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        child: Custombutton(
                          label: "Next",
                          onpressed: () {
                            registrationcontroller.isunderage.value
                                ? Get.snackbar(
                                    "Could not register",
                                    "You are under 18",
                                    icon: const Icon(Icons.error),
                                    backgroundColor: Colors.red[300],
                                  )
                                : registrationcontroller.register();
                          },
                        ),
                      ),

                      const SizedBox(height: 15),

                      Obx(() => registrationcontroller.isloading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const SizedBox.shrink()),

                      const SizedBox(height: 15),

                      GestureDetector(
                        onTap: () =>
                            Navigator.push(context, MaterialPageRoute(builder: (_) => Loginscreen())),
                        child: const Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        height: 50,
        color: Colors.transparent,
        child: Center(
          child: Text(
            "© 2025 ADSTRA DIGITAL",
            style: TextStyle(
              color: Colors.white70,
              fontSize: isMobile ? 12 : 14,
            ),
          ),
        ),
      ),
    );
  }

  /// Simple clean form-field wrapper (using existing widgets)
  Widget _buildField({required TextEditingController controller, required String hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[300]),
          filled: true,
          fillColor: Colors.white.withOpacity(0.12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
