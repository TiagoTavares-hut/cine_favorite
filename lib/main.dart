import 'package:cine_favorite/views/favoritos_view.dart';
import 'package:cine_favorite/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async{
  //garantir o carregamento dos widgets primeiro
  WidgetsFlutterBinding.ensureInitialized();

  //conectar com o firebase
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: "Cine Favorite",
    theme: ThemeData(
      primarySwatch: Colors.orange,
      brightness: Brightness.dark
    ),
    home: AuthStream(), // permite a navegação de tela de acordo com alguma decisão
  ));
}

class AuthStream extends StatelessWidget {
  const AuthStream({super.key});

  @override
  Widget build(BuildContext context) {
    //ouvinte da mudança de status (listener)
    return StreamBuilder<User?>(//permitir retorno null para usuario?
      //ouvinte da mudança de status do usuário
      stream: FirebaseAuth.instance.authStateChanges(),
      //identific a mudanca de status do usuario(logodo ou nao) 
      builder: (context, snapshot){ //analisa o instantâneo da aplicação
        //se tiver logado, vai para a tela de favoritos
        if(snapshot.hasData){
          return FavoritosView();
        }//caso contrario => tela de login
        return LoginView();
      });
  }
}