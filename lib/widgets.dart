import 'package:app_proyecto/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.isTransparent = false,
    required this.text,
    this.isLarge = false,
    this.onPressed,
  });

  final bool isTransparent;
  final bool isLarge;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: isLarge ? double.infinity : 160,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isTransparent ? Colors.transparent : primary,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: h2.copyWith(
            color: isTransparent ? black : white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

//boton redes sociales

class Social extends StatelessWidget {
  const Social({super.key, required this.iconPath});
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(iconPath),
    );
  }
}

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.hint,
    this.isPassword = false,
    final TextEditingController? textController,
  });

  final String hint;
  final bool isPassword;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 183, 222, 240),
        filled: true,
        hintText: widget.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
                : null,
      ),
    );
  }
}
