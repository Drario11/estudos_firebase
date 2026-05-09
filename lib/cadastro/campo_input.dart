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
    // Verificamos se o rótulo é "Senha" para ativar a proteção de texto
    // Isso evita que você precise criar um componente só para senha.
    bool eCampoSenha = rotulo.toLowerCase() == 'senha';

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        // Se for senha, o obscureText será true e esconderá os caracteres
        obscureText: eCampoSenha,
        decoration: InputDecoration(
          labelText: rotulo,
          prefixIcon: Icon(icone),
          border: const OutlineInputBorder(),
          // Se for senha, podemos adicionar um ícone de cadeado ou olho no final
          suffixIcon: eCampoSenha ? const Icon(Icons.visibility_off) : null,
        ),
      ),
    );
  }
}
