import 'package:flutter/material.dart';
import 'package:app_proyecto/constants.dart';
import 'package:app_proyecto/screens/page/login_screen.dart';
import 'package:app_proyecto/widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -330,
            right: -330,
            child: Container(
              height: 635,
              width: 635,
              decoration: const BoxDecoration(
                color: lightBlue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -153,
            bottom: -120,
            child: Transform.rotate(
              angle: -0.47281,
              child: Container(
                height: 372,
                width: 372,
                decoration: BoxDecoration(
                  border: Border.all(color: lightBlue, width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Text("Crear cuenta", style: h2),
                const SizedBox(height: 10),
                Text(
                  "Elije los mejores precios ",
                  style: body.copyWith(fontSize: 16, color: black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                CustomTextfield(
                  hint: "Correo",
                  textController: emailController,
                ),
                const SizedBox(height: 20),
                CustomTextfield(
                  hint: "Contraseña",
                  textController: passwordController,
                ),
                const SizedBox(height: 20),
                CustomTextfield(
                  hint: "Confirmar Contraseña",
                  textController: confirmPasswordController,
                ),
                const SizedBox(height: 45),
                CustomButton(
                  text: "Registrar",
                  onPressed: () {
                    print("Correo: ${emailController.text}");
                  },
                  isLarge: true,
                ),
                const SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    "Ya tienes una cuenta",
                    style: body.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  "o ingresa con",
                  style: body.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: primary,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Social(iconPath: "assets/"),
                    SizedBox(width: 10),
                    Social(iconPath: "assets/"),
                    SizedBox(width: 10),
                    Social(iconPath: "assets/"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
