import 'dart:developer';

import 'package:evalys_main/global/theme/colors.dart';
import 'package:evalys_main/global/utils/image_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Image.asset(
                    appLogo,
                    height: 100,
                  ),
                  Text(
                    "Sign Up",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  FormBuilder(
                    key: homeController.signUpKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: FormBuilderTextField(
                            name: 'lastName',
                            decoration: const InputDecoration(
                              hintText: 'Last Name',
                              prefixIcon: Icon(Icons.person),
                              filled: true,
                              fillColor: AppColors.secondary,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0 * 1.5, vertical: 16.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                            onSaved: (phone) {
                              // Save it
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.fileName(),
                            ]),
                          ),
                        ),
                        FormBuilderTextField(
                          name: 'firstName',
                          decoration: const InputDecoration(
                            hintText: 'First Name',
                            prefixIcon: Icon(Icons.person),
                            filled: true,
                            fillColor: AppColors.secondary,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                          onSaved: (phone) {
                            // Save it
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.fileName(),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: FormBuilderTextField(
                            name: 'phone',
                            decoration: const InputDecoration(
                              hintText: 'Phone Number',
                              prefixIcon: Icon(Icons.phone),
                              filled: true,
                              fillColor: AppColors.secondary,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0 * 1.5, vertical: 16.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            onSaved: (phone) {
                              // Save it
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.phoneNumber(),
                            ]),
                          ),
                        ),
                        FormBuilderTextField(
                          name: 'email',
                          decoration: const InputDecoration(
                            hintText: 'Email Address',
                            prefixIcon: Icon(Icons.email),
                            filled: true,
                            fillColor: AppColors.secondary,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (phone) {
                            // Save it
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: FormBuilderTextField(
                            name: 'password',
                            obscureText: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Password',
                              filled: true,
                              fillColor: AppColors.secondary,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0 * 1.5, vertical: 16.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                            onSaved: (passaword) {
                              // Save it
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(6),
                            ]),
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.01),
                        Obx(() {
                          return ElevatedButton(
                            onPressed: homeController.isSignUpLoading.value
                                ? null
                                : () {
                                    homeController.signUpKey.currentState!
                                        .save();
                                    if (homeController.signUpKey.currentState!
                                        .saveAndValidate()) {
                                      homeController.signUpWithEmailPassword(
                                        email: homeController.signUpKey
                                            .currentState!.value['email'],
                                        password: homeController.signUpKey
                                            .currentState!.value['password'],
                                        phone: homeController.signUpKey
                                            .currentState!.value['phone'],
                                        firstName: homeController.signUpKey
                                            .currentState!.value['firstName'],
                                        lastName: homeController.signUpKey
                                            .currentState!.value['lastName'],
                                      );

                                      log("${homeController.signUpKey.currentState!.value}");
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: const Color(0xFF00BF6D),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 48),
                              shape: const StadiumBorder(),
                            ),
                            child: homeController.isSignUpLoading.value
                                ? const CupertinoActivityIndicator()
                                : const Text("Sign Up"),
                          );
                        }),
                        const SizedBox(height: 30.0),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text.rich(
                            const TextSpan(
                              text: " Have an account? ",
                              children: [
                                TextSpan(
                                  text: "Sign In",
                                  style: TextStyle(color: Color(0xFF00BF6D)),
                                ),
                              ],
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(0.64),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
