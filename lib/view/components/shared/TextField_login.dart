import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldLogin extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final bool? obscureText;
  final TextEditingController controller;
  final VoidCallback? onIconTap;
  final String? Function(String?)? validator;

  const TextFieldLogin({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.obscureText,
    required this.controller,
    this.onIconTap,
    this.validator,
  });

  @override
  State<TextFieldLogin> createState() => _TextFieldLoginState();
}

class _TextFieldLoginState extends State<TextFieldLogin> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color myOrange = Color(0xFFD2775B);
    final Color lightOrange = myOrange.withOpacity(0.3);
    const Color brightRedError = Color(0xFFFF0000);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          if (_isFocused)
            BoxShadow(
              color: myOrange.withOpacity(0.5),
              blurRadius: 25,
              spreadRadius: 2,
              offset: const Offset(0, 12),
            ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: widget.obscureText ?? false,
        validator: widget.validator,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          floatingLabelStyle: TextStyle(
            color: _isFocused ? myOrange : Colors.black,
            fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: myOrange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(widget.icon, color: myOrange, size: 20),
            ),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    widget.obscureText!
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: _isFocused ? myOrange : Colors.grey,
                  ),
                  onPressed: widget.onIconTap,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 25,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: lightOrange, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: myOrange, width: 2.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: brightRedError, width: 2.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: brightRedError, width: 3.0),
          ),
          errorStyle: const TextStyle(
            color: brightRedError,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
