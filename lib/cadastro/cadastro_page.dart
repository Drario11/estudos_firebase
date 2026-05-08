import 'package:flutter/material.dart';
import 'campo_input.dart'; // Importa o campo que está na mesma pasta
import 'cadastro_service.dart'; // Importa o serviço que está na mesma pasta

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _service = CadastroService();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _tel = TextEditingController();
  final _end = TextEditingController();

  void realizarCadastro() {
    _service
        .salvarNoFirebase(
          nome: _nome.text,
          email: _email.text,
          telefone: _tel.text,
          endereco: _end.text,
        )
        .then((_) {
          _nome.clear();
          _email.clear();
          _tel.clear();
          _end.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cadastrado com sucesso!')),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro - Pasta Única')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CampoInput(controller: _nome, rotulo: 'Nome', icone: Icons.person),
            CampoInput(
              controller: _email,
              rotulo: 'E-mail',
              icone: Icons.email,
            ),
            CampoInput(
              controller: _tel,
              rotulo: 'Telefone',
              icone: Icons.phone,
            ),
            CampoInput(controller: _end, rotulo: 'Endereço', icone: Icons.map),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: realizarCadastro,
              child: const Text('SALVAR CLIENTE'),
            ),
          ],
        ),
      ),
    );
  }
}
