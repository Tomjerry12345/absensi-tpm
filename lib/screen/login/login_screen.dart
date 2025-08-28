import 'package:absensi/components/input_field_component.dart';
import 'package:absensi/components/loading_button.dart';
import 'package:absensi/screen/login/login_controller.dart';
import 'package:absensi/utils/space_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const FlutterLogo(size: 72),
                V(16),
                Text(
                  'Masuk',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                V(4),
                Text(
                  'Gunakan email dan password',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                V(24),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      InputFieldComponent(
                        controller: controller.emailCtrl,
                        label: 'Email',
                        icon: Icons.email_outlined,
                        validator: controller.validateEmail,
                        autofillHints: const [AutofillHints.username],
                      ),
                      const SizedBox(height: 12),
                      Obx(() => InputFieldComponent(
                            controller: controller.passwordCtrl,
                            label: 'Password',
                            icon: Icons.lock_outline,
                            validator: controller.validatePassword,
                            obscureText: controller.obscure.value,
                            onToggleVisibility: controller.toggleObscure,
                            autofillHints: const [AutofillHints.password],
                          )),
                      V(16),
                      Center(
                        child: Obx(() => LoadingButton(
                              isLoading: controller.isLoading.value,
                              onPressed: controller.login,
                              icon: const Icon(Icons.login),
                              label: const Text('Login'),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
