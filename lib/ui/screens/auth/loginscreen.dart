import 'package:ad_invoice_mobile/controllers/apicontrollers/logincontroller.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/forgotscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/registerscreen.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:ad_invoice_mobile/ui/screens/dashboard/dashboardmain.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;

class Loginscreen extends StatelessWidget {
  final Logincontroller logincontroller = Get.find<Logincontroller>();
  Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = responsive.ResponsiveBreakpoints.of(context)
        .smallerThan(responsive.TABLET);

    Widget loginForm = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo
        Image.asset(
          'assets/logo.png',
          width: isMobile ? 100 : 160,
          height: 120,
          fit: BoxFit.contain,
        ),

        const SizedBox(height: 16),

        // Welcome Text
        Text(
          "Welcome back business partner",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color: Colors.grey[300],
            fontSize: isMobile ? 15 : 18,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 32),

        // Login Title
        Text(
          "Login to Your Account",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: isMobile ? 20 : 24,
          ),
        ),

        const SizedBox(height: 32),

        // Username Field
        TextField(
          controller: logincontroller.usernamecontroller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Username",
            prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Password Field
        TextField(
          controller: logincontroller.passwordcontroller,
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Password",
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),

        const SizedBox(height: 32),

        // Login Button
        Custombutton(
          label: "Sign In",
          onpressed: () async {
            await logincontroller.login();
            if (logincontroller.accesstoken.value.isNotEmpty) {
              Get.to(() => Dashboardmain());
            }
          },
        ),

        const SizedBox(height: 16),

        // Loading Indicator
        Obx(
          () => logincontroller.isloading.value
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : const SizedBox.shrink(),
        ),

        const SizedBox(height: 24),

        // Forgot Password
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Forgotscreen()),
            );
          },
          child: Text(
            "Forgot Username or Password?",
            style: TextStyle(
              color: Colors.blue[300],
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Register Link
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Registerscreen()),
            );
          },
          child: Text(
            "New here? Create new account",
            style: TextStyle(
              color: Colors.blue[300],
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/background.jpeg",
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.6),
              colorBlendMode: BlendMode.darken,
            ),
          ),

          // Login Form
          Align(
            alignment: const Alignment(0, -0.7),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: isMobile
                  ? loginForm
                  : Center(
                      child: Card(
                        color: Colors.black.withOpacity(0.7),
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          width: responsive.ResponsiveValue<double>(
                            context,
                            defaultValue: MediaQuery.of(context).size.width * 0.8,
                            conditionalValues: [
                              responsive.Condition.smallerThan(
                                name: responsive.TABLET,
                                value: MediaQuery.of(context).size.width * 0.9,
                              ),
                              responsive.Condition.largerThan(
                                name: responsive.DESKTOP,
                                value: 600,
                              ),
                            ],
                          ).value,
                          child: loginForm,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.transparent,
        child: Center(
          child: Text(
            "© 2025 ADSTRA DIGITAL",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}