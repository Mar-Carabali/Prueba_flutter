import 'package:app_proyecto/navigation.dart';
import 'package:app_proyecto/screens/page/signup_screen.dart';
import 'package:app_proyecto/widgets.dart';
import 'package:flutter/material.dart';
import 'package:app_proyecto/constants.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  LoginScreen({super.key});

  Future<void> userLogin(
    String username,
    String password,
    BuildContext context,
  ) async {
    const url = "https://fakestoreapi.com/auth/login";
    final response = await http.post(
      Uri.parse(url),
      body: {'username': username, 'password': password},
    );

    if (!context.mounted) return;

    if (response.statusCode == 200) {
      print("Login exitoso: \${response.body}");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NavigationMenu()),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (_) => const AlertDialog(
              title: Text("Error"),
              content: Text("Usuario o contraseña incorrectos."),
            ),
      );
    }
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
              decoration: BoxDecoration(
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
                Text("Inicia aquí", style: h2),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    "Bienvenido a tu tienda virtual",
                    style: h2.copyWith(fontSize: 18, color: black),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 100),
                CustomTextfield(hint: "Usuario ", textController: email),
                const SizedBox(height: 25),
                CustomTextfield(
                  hint: "Contraseña ",
                  isPassword: true,
                  textController: password,
                ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Recordar Contraseña",
                    style: body.copyWith(
                      fontSize: 16,
                      color: primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: "Inicia sesión",
                  onPressed: () {
                    userLogin("johnd", "m38rmF\$", context);
                  },
                  isLarge: true,
                ),
                const SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Crear cuenta",
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
                    Social(iconPath: "assets/smedia1.png"),
                    SizedBox(width: 10),
                    Social(iconPath: "assets/smedia2.png"),
                    SizedBox(width: 10),
                    Social(iconPath: "assets/smedia3.png"),
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
