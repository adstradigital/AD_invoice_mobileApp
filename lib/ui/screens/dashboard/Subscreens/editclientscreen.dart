import 'package:ad_invoice_mobile/controllers/apicontrollers/createclientcontroller.dart';
import 'package:ad_invoice_mobile/controllers/apicontrollers/listclientcontroller.dart';
import 'package:ad_invoice_mobile/ui/screens/auth/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Editclientscreen extends StatelessWidget {
  Editclientscreen({super.key});

 final Listclientcontroller listclientcontroller = Get.find<Listclientcontroller>();
 final Createclientcontroller createclientcontroller = Get.find<Createclientcontroller>();
  final formkey = GlobalKey<FormState>();

  final client=Get.arguments;

  void submitform() {
    if (formkey.currentState!.validate()) {
     
    }
  }

  @override
  Widget build(BuildContext context) {

    print(client);

    createclientcontroller.clientnamecontroller.text=client['name'];
    createclientcontroller.industrycontroller.text=client['industry'];
    createclientcontroller.websitecontroller.text=client['website'];
    createclientcontroller.registercontroller.text=client['registration_number'];
    createclientcontroller.taxcontroller.text=client['tax_id'];
    createclientcontroller.addresscontroller.text=client['address_line1'];
    createclientcontroller.addresscontroller2.text=client['address_line2'];
    createclientcontroller.citycontroller.text=client['city'];
    createclientcontroller.statecontroller.text=client['state'];
    createclientcontroller.countrycontroller.text=client['country'];
    createclientcontroller.postalcontroller.text=client['postal_code'];
    createclientcontroller.phonecontroller.text=client['phone'];
    createclientcontroller.emailcontroller.text=client['email'];
    createclientcontroller.supportemailcontroller.text=client['support_email'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Client",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
        elevation: 2,
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Edit Client Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildTextFormField(
                      controller: createclientcontroller.clientnamecontroller,
                      label: "Client Name *",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Client name is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    _buildTextFormField(
                      controller: createclientcontroller.industrycontroller,
                      label: "Industry *",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Industry is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    _buildTextFormField(
                      controller: createclientcontroller.websitecontroller,
                      label: "Website *",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Website is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    _buildTextFormField(
                      controller: createclientcontroller.registercontroller,
                      label: "Registration Number *",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Registration number is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    _buildTextFormField(
                      controller: createclientcontroller.taxcontroller,
                      label: "Tax ID *",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Tax ID is required";
                        }
                        return null;
                      },
                    ),
                    
                    SizedBox(height: 24),
                    Text(
                      "Edit Address Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildTextFormField(
                      controller: createclientcontroller.addresscontroller,
                      label: "Address Line 1 *",
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Address line 1 is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    _buildTextFormField(
                      controller: createclientcontroller.addresscontroller2,
                      label: "Address Line 2 *",
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Address line 2 is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextFormField(
                            controller: createclientcontroller.citycontroller,
                            label: "City *",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "City is required";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildTextFormField(
                            controller: createclientcontroller.statecontroller,
                            label: "State *",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "State is required";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextFormField(
                            controller: createclientcontroller.countrycontroller,
                            label: "Country *",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Country is required";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildTextFormField(
                            controller: createclientcontroller.postalcontroller,
                            label: "Postal Code *",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Postal code is required";
                              }
                              if (!GetUtils.isNum(value)) {
                                return "Please enter a valid postal code";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    Text(
                      "Edit Contact Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildTextFormField(
                      controller: createclientcontroller.phonecontroller,
                      label: "Phone Number *",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Phone number is required";
                        }
                        if (!GetUtils.isNum(value)) {
                          return "Please enter a valid phone number";
                        }
                        if (value.length != 10) {
                          return "Please enter a 10 digit number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    _buildTextFormField(
                      controller: createclientcontroller.emailcontroller,
                      label: "Email Address *",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        if (!GetUtils.isEmail(value)) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    _buildTextFormField(
                      controller: createclientcontroller.supportemailcontroller,
                      label: "Support Email *",
                      validator: (value) {
                        if (!GetUtils.isEmail(value!)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    
                    SizedBox(height: 24),
                    Text(
                      "Additional Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildTextFormField(
                      controller: createclientcontroller.accountmangercontroller,
                      label: "Account Manager",
                    ),
                    SizedBox(height: 16),
                    _buildTextFormField(
                      controller: createclientcontroller.notescontroller,
                      label: "Notes",
                      maxLines: 3,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Custombutton(
                      label: "Discard",
                      onpressed: () {
                        
                        Get.back();
                      },
                     
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Custombutton(
                      label: "Save Client",
                      onpressed: ()async{
                        final userid=client['id'];
                        await createclientcontroller.updateclient(userid);
                        if(createclientcontroller.issucess.value)
                        {
                          Get.snackbar("User updated", "You can see the changes",backgroundColor: 
                          Colors.green[200],);
                         await listclientcontroller.getclients();
                        }
                        else{
                          Get.snackbar("Error", "Try again",backgroundColor: 
                          Colors.red[200],);
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

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue[700]!),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        alignLabelWithHint: maxLines > 1,
      ),
    );
  }
}