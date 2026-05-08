import 'package:flutter/material.dart';
import 'campo_input.dart';
import 'cadastro_service.dart';
// 1. IMPORTANTE: Importe o arquivo da lista que está dentro da pasta lista
import 'lista/lista_page.dart';

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
      appBar: AppBar(
        title: const Text('Cadastro - Pasta Única'),
        // 2. ADICIONANDO O BOTÃO NO APPBAR
        actions: [
          IconButton(
            icon: const Icon(Icons.format_list_bulleted), // Ícone de lista
            tooltip: 'Ver Clientes',
            onPressed: () {
              // Comando para navegar para a página de lista
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListaPage()),
              );
            },
          ),
        ],
      ),
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
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(
                  double.infinity,
                  50,
                ), // Botão ocupa largura total
              ),
              child: const Text('SALVAR CLIENTE'),
            ),
          ],
        ),
      ),
    );
  }
}
