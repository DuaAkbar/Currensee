import 'package:curren_see/controllers/contact_controller.dart';
import 'package:curren_see/services/navigation_services.dart';
import 'package:curren_see/widgets/contactpage/contact_inputfield.dart';
import 'package:curren_see/widgets/contactpage/contact_message.dart';
import 'package:curren_see/widgets/contactpage/contact_support.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class ContactPage extends StatefulWidget {
  ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactController contactcontroller = Get.put(ContactController());

  NavigationServices navigationServices = Get.find<NavigationServices>();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact Us",
          style: TextStyle(
            fontSize: 35,
            fontFamily: 'DancingScript',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offNamed("/");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Color(0xFFF9F0F2),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),

              // Contact Form ====================
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Form(
                  key: _key,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ContactInputfield(
                          hint: "Name",
                          icon: Icons.person,
                          textEditingController:
                              contactcontroller.nameController,
                          validator:
                              ValidationBuilder()
                                  .minLength(3)
                                  .maxLength(10)
                                  .build(),
                        ),
                        SizedBox(height: 15),
                        ContactInputfield(
                          hint: "Email",
                          icon: Icons.email,
                          textEditingController:
                              contactcontroller.emailController,
                          validator: ValidationBuilder().email().build(),
                        ),
                        SizedBox(height: 15),
                        ContactInputfield(
                          hint: "Subject",
                          icon: Icons.subject,
                          textEditingController:
                              contactcontroller.subjectController,
                          validator:
                              ValidationBuilder()
                                  .minLength(3)
                                  .maxLength(10)
                                  .build(),
                        ),
                        SizedBox(height: 15),
                        ContactMsgfield(
                          icon: Icons.message,
                          textEditingController:
                              contactcontroller.messageController,
                          validator:
                              ValidationBuilder()
                                  .minLength(10)
                                  .maxLength(50)
                                  .build(),
                        ),
                        SizedBox(height: 20),
                        Obx(
                          () =>
                              contactcontroller.errorMessage.value.isNotEmpty
                                  ? Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      contactcontroller.errorMessage.value,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                  : SizedBox(),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFFADADD), Color(0xFFE75480)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              onPressed:
                                  contactcontroller.isLoading.value
                                      ? null
                                      : () async {
                                        await contactcontroller
                                            .submitContactForm();
                                        if (contactcontroller
                                            .errorMessage
                                            .value
                                            .isEmpty) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Thanks! We\'ll get back to you soon.',
                                              ),
                                            ),
                                          );
                                        }
                                      },
                              child:
                                  contactcontroller.isLoading.value
                                      ? CircularProgressIndicator(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                      )
                                      : Text(
                                        'Send Message',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Support Options ===================
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          await contactcontroller
                              .openGmail(); // or launchPhone()
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to open: $e')),
                          );
                        }
                      },
                      child: ContactSupportCard(
                        icon: Icons.email,
                        title: 'Email Support',
                        value: 'support@currensee.app',
                      ),
                    ),
                  ),

                  SizedBox(width: 15),

                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          await contactcontroller
                              .launchPhone(); // or launchPhone()
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to open: $e')),
                          );
                        }
                      },
                      child: ContactSupportCard(
                        icon: Icons.phone,
                        title: 'Call Us',
                        value: '+92 XXX XXX XXXX',
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),

              // FAQ Preview ==========================
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFFADADD).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Need Quick Help?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE75480),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Check our FAQs for instant answers to common questions',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 15),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFFE75480)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Get.toNamed("/faq");
                      },
                      child: Text(
                        'Go to Help Center',
                        style: TextStyle(color: Color(0xFFE75480)),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),
              //  footer =============
              Center(
                child: Text(
                  'We usually respond within 24 hours',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
