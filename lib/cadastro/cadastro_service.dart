import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 1. Nova importação

class CadastroService {
  final CollectionReference _clientes = FirebaseFirestore.instance.collection(
    'clientes',
  );
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // 2. Instância de Autenticação

  // SALVAR COM SEGURANÇA (Auth + Firestore)
  Future<void> salvarNoFirebase({
    required String nome,
    required String email,
    required String telefone,
    required String endereco,
    required String senha, // 3. Agora precisamos da senha no cadastro
  }) async {
    // A. Cria a conta na "Portaria" de segurança
    UserCredential cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );

    // B. Pega o UID único gerado pelo Google
    String uid = cred.user!.uid;

    // C. Salva o perfil usando o UID como ID do documento (.doc(uid))
    await _clientes.doc(uid).set({
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
      'data_cadastro': DateTime.now(),
    });
  }

  // O restante (editar, excluir, listar) continua QUASE igual,
  // mas agora referenciando o UID que criamos acima.

  Future<void> editarNoFirebase(
    String id,
    Map<String, dynamic> novosDados,
  ) async {
    await _clientes.doc(id).update(novosDados);
  }

  Future<void> excluirNoFirebase(String id) async {
    await _clientes.doc(id).delete();
  }

  Stream<QuerySnapshot> listarClientes() {
    return _clientes.orderBy('data_cadastro', descending: true).snapshots();
  }
}
