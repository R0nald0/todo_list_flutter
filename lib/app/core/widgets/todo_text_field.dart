import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TodoTextField extends StatelessWidget {
  final String label;
  final bool obscuretext ;
  final IconButton? suffixIcon;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController ? controller;
  final FormFieldValidator <String>? validator;
  final FocusNode? focosNode;

   TodoTextField({
    Key? key,
    required this.label,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.obscuretext =false,
    this.focosNode
    }) :
     assert(obscuretext == true ? suffixIcon == null : true,
     'obscure text não poder enviado em conjunto com o suffixIcon'
     ) ,
     obscureTextVN = ValueNotifier(obscuretext),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (context,obscureTextValue,child) {
        return TextFormField(
          focusNode:focosNode ,
          keyboardType: TextInputType.text,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
          labelText: label, 
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)) ,
          borderSide: BorderSide(color: Colors.red)
        ),
        isDense: true,
        suffixIcon: suffixIcon ??
                   (obscuretext == true ? IconButton(
                                     onPressed: (){
                                       obscureTextVN.value = !obscureTextValue;
                                     }, 
                                     icon: FaIcon(
                                      !obscureTextValue 
                                          ? FontAwesomeIcons.eyeSlash
                                          : FontAwesomeIcons.eye

                                      ) )
                                     : null
        )
          ),
          obscureText:obscureTextValue ,
        );
      }
    );
  }
}