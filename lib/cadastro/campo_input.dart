import 'package:flutter/material.dart';

class CampoInput extends StatelessWidget {
  final TextEditingController controller;
  final String rotulo;
  final IconData icone;

  const CampoInput({
    super.key,
    required this.controller,
    required this.rotulo,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: rotulo,
          prefixIcon: Icon(icone),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
