import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  // Garante que o Flutter carregue os componentes antes de iniciar o Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa a conexão com o seu projeto específico do Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Cadastro Dario',
      debugShowCheckedModeBanner: false, // Remove a faixa de debug no canto
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Usa o visual mais moderno do Google
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // CONTROLADORES: Servem para pegar o texto que você digita na tela
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telController = TextEditingController();
  final _endController = TextEditingController();

  // FUNÇÃO DE CADASTRO: Aqui é onde a mágica das "3 colunas" acontece
  void cadastrarCliente() {
    // 1. Acessamos a instância do Firestore
    // 2. Definimos a Coleção (Gaveta) chamada 'clientes'
    // 3. Usamos .add para criar um Documento (Pasta) com os campos abaixo
    FirebaseFirestore.instance
        .collection('clientes')
        .add({
          'nome': _nomeController.text,
          'email': _emailController.text,
          'telefone': _telController.text,
          'endereco': _endController.text,
          'data_cadastro': DateTime.now(), // Salva o dia e hora exatos
        })
        .then((value) {
          // Se der certo, limpamos os campos para o próximo cadastro
          _nomeController.clear();
          _emailController.clear();
          _telController.clear();
          _endController.clear();

          // Mostra um aviso de sucesso na parte de baixo da tela
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cliente salvo no Firebase com sucesso!'),
            ),
          );
        })
        .catchError((error) {
          // Caso ocorra algum erro (ex: falta de internet ou regra bloqueada)
          print("Erro ao salvar: $error");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Clientes WaaS'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // SingleChildScrollView evita erro de layout quando o teclado do celular sobe
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Novo Cadastro',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // CAMPOS DE ENTRADA (Inputs)
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Cliente',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _telController,
              decoration: const InputDecoration(
                labelText: 'Telefone/WhatsApp',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _endController,
              decoration: const InputDecoration(
                labelText: 'Endereço Completo',
                border: OutlineInputBorder(),
              ),
              maxLines: 2, // Permite digitar um endereço longo
            ),

            const SizedBox(height: 30),

            // BOTÃO DE AÇÃO
            ElevatedButton.icon(
              onPressed: cadastrarCliente, // Chama a nossa função lá de cima
              icon: const Icon(Icons.save),
              label: const Text('SALVAR NO FIREBASE'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
