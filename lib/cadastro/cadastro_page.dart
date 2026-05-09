import 'package:flutter/material.dart';
import 'campo_input.dart';
import 'cadastro_service.dart';
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
  // 1. NOVO CONTROLADOR PARA SENHA
  final _senha = TextEditingController();

  void realizarCadastro() {
    _service
        .salvarNoFirebase(
          nome: _nome.text,
          email: _email.text,
          telefone: _tel.text,
          endereco: _end.text,
          // 2. PASSANDO A SENHA PARA O SERVICE
          senha: _senha.text,
        )
        .then((_) {
          _nome.clear();
          _email.clear();
          _tel.clear();
          _end.clear();
          _senha.clear(); // Limpa a senha também
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cadastrado com sucesso!')),
          );
        })
        .catchError((error) {
          // É importante tratar erros de autenticação (ex: senha curta)
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Erro: ${error.toString()}')));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Clientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.format_list_bulleted),
            tooltip: 'Ver Clientes',
            onPressed: () {
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

            // 3. NOVO CAMPO DE ENTRADA PARA SENHA
            CampoInput(
              controller: _senha,
              rotulo: 'Senha',
              icone: Icons.lock,
              // Dica: No futuro, podemos adicionar 'obscureText: true' no CampoInput
              // para esconder os caracteres da senha.
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: realizarCadastro,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('SALVAR CLIENTE'),
            ),
          ],
        ),
      ),
    );
  }
}
