import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroService {
  final CollectionReference _clientes = FirebaseFirestore.instance.collection(
    'clientes',
  );

  Future<void> salvarNoFirebase({
    required String nome,
    required String email,
    required String telefone,
    required String endereco,
  }) async {
    await _clientes.add({
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
      'data_cadastro': DateTime.now(),
    });
  }
}
