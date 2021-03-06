import 'package:estimulo2020/trilhas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'termos.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bem vindo',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Olá, seja Bem vindo!"),
          backgroundColor: Colors.lightBlue[800],
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final chaveSenha = GlobalKey<FormState>();
  final chaveEmail = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

  bool ocultarSenha = false;

  Future<bool> verificaUsuario() async {
    Firestore db = Firestore.instance;

    var _email = email.text.toString();
    var _senha = senha.text.hashCode.toString();

    QuerySnapshot querySnapshot = await db
        .collection('usuarios')
        .where('email', isEqualTo: _email)
        .limit(1)
        .getDocuments();

    var retorno = querySnapshot.documents;

    if (retorno.length == 1) {
      var usuario = retorno[0].data;

      var senhaFirebase = usuario['senha'].toString();
      if (_senha == senhaFirebase) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image(image: AssetImage('images/estimulo.jpeg')),
          Container(
            margin: EdgeInsets.all(40),
            child: Text(
              'Bem vindo, faça o login!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Form(
              key: chaveEmail,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'usuario@email.com',
                      suffixIcon:
                          IconButton(icon: Icon(Icons.email), onPressed: null),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    onSaved: (value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe o e-mail";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Form(
              key: chaveSenha,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Senha',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(ocultarSenha
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              ocultarSenha = !ocultarSenha;
                            });
                          },
                        )),
                    controller: senha,
                    obscureText: !ocultarSenha,
                    onSaved: (value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe a senha";
                      } else if (value.length < 4) {
                        return "Senha muito pequena";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: [
                RaisedButton(
                  onPressed: () async {
                    if (chaveEmail.currentState.validate() &&
                        chaveSenha.currentState.validate()) {
                      bool usuarioCadastrado = await verificaUsuario();
                      if (usuarioCadastrado) {
                        var _email = email.text.toString();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Trilhas(_email)),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // retorna um objeto do tipo Dialog
                            return AlertDialog(
                              title: new Text(
                                  "Usuário não cadastrado ou senha incorreta"),
                              content: new Text(
                                  "Por favor, efetue o seu cadastro no aplicativo ou verifique se sua senha está correta!"),
                              actions: <Widget>[
                                // define os botões na base do dialogo
                                new FlatButton(
                                  child: new Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Colors.blue[700],
                  child: Container(
                    width: 250,
                    height: 50,
                    child: Center(
                      child:
                          Text('Login', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(7),
                  child: Text('Ou'),
                ),
                RaisedButton(
                  // Within the `FirstRoute` widget
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Termos()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Colors.green[700],
                  child: Container(
                    width: 250,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Cadastre-se',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
