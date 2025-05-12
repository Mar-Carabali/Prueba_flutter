import 'package:app_proyecto/screens/page/login_screen.dart';
import 'package:app_proyecto/screens/page/signup_screen.dart';
import 'package:app_proyecto/widgets.dart';
import 'package:flutter/material.dart';
import 'package:app_proyecto/constants.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                SizedBox(height: 60),
                Image.asset(
                  "assets/carrito2.png",
                  fit: BoxFit.cover,
                  height: 350,
                  width: 350,
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "InComercy ",
                    style: h1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text("Mas que un comercio !", textAlign: TextAlign.center),
                SizedBox(height: 50),
                Row(
                  children: [
                    CustomButton(
                      text: "Inicio",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 20),
                    CustomButton(
                      text: "Registro",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                    ),
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
