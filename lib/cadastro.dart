import 'package:flutter/material.dart';
import 'trilhas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: PaginaDeCadastro(),
      ),
    );
  }
}

class PaginaDeCadastro extends StatefulWidget {
  PaginaDeCadastroState createState() => PaginaDeCadastroState();
}

class PaginaDeCadastroState extends State<PaginaDeCadastro> {
  final nome = GlobalKey<FormState>();
  final email = GlobalKey<FormState>();
  final cnpj = GlobalKey<FormState>();
  final cpf = GlobalKey<FormState>();
  final celular = GlobalKey<FormState>();
  final senhaUm = GlobalKey<FormState>();
  final senhaDois = GlobalKey<FormState>();
  TextEditingController cNome = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cCpf = TextEditingController();
  TextEditingController cCnpj = TextEditingController();
  TextEditingController cCelular = TextEditingController();
  TextEditingController cSenhaUm = TextEditingController();
  TextEditingController cSenhaDois = TextEditingController();
  double tamText = 18;
  static const double tamEsp = 16;
  bool exibirSenhaUm = false;
  bool exibirSenhaDois = false;

  salvaUsuario() async {
    Firestore banco = Firestore();
    await banco.collection('usuarios').document(cCpf.text.toString()).setData({
      'habilitado': true,
      'nome': cNome.text.toString(),
      'email': cEmail.text.toString(),
      'celular': cCelular.text.toString(),
      'cnpj': cCnpj.text.toString(),
      'senha': cSenhaUm.text.hashCode.toString()
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        //container geral que emgloba toda a tela
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Dados pessois",
                style: TextStyle(
                  fontSize: tamText,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: tamEsp, bottom: tamEsp),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Nome Completo",
                        style: TextStyle(
                            fontSize: tamText,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                  Form(
                    key: nome,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Ex: Diogo Souza Santos',
                        icon: Icon(Icons.person),
                      ),
                      controller: cNome,
                      keyboardType: TextInputType.name,
                      style: TextStyle(fontSize: 18),
                      onSaved: (value) {
                        print(value);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Informe o seu nome";
                        } else if (value.length < 8) {
                          return "Nome muito pequeno";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: tamEsp, bottom: tamEsp),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "CPF",
                        style: TextStyle(
                            fontSize: tamText,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                  Form(
                    key: cpf,
                    child: TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.perm_identity),
                        hintText: 'Ex: usuario@email.com',
                      ),
                      style: TextStyle(fontSize: 18),
                      controller: cCpf,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        print(value);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Informe o seu CPF";
                        } else if (value.length != 11) {
                          return "CPF invalido";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: tamEsp, bottom: tamEsp),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "E-mail",
                        style: TextStyle(
                          fontSize: tamText,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                  Form(
                    key: email,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Ex: usuario@email.com',
                        icon: Icon(Icons.email),
                      ),
                      controller: cEmail,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        print(value);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Informe o cnpj da sua empresa";
                        } else if (value.length < 4) {
                          return "Número inexistente";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: tamEsp, bottom: tamEsp),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Número de celular",
                        style: TextStyle(
                          fontSize: tamText,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                  Form(
                    key: celular,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Ex: (31) 996256375 ',
                        icon: Icon(Icons.phone),
                      ),
                      controller: cCelular,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(fontSize: 18),
                      //keyboardType: TextInputType.number,
                      onSaved: (value) {
                        print(value);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo vazio";
                        } else if (value.length < 11) {
                          return "Celular inexistente";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: tamEsp, bottom: tamEsp),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Senha",
                        style: TextStyle(
                          fontSize: tamText,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                  Form(
                    key: senhaUm,
                    child: TextFormField(
                      //keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.security),
                        suffixIcon: IconButton(
                          icon: Icon(exibirSenhaUm
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(
                              () {
                                exibirSenhaUm = !exibirSenhaUm;
                              },
                            );
                          },
                        ),
                      ),
                      controller: cSenhaUm,
                      obscureText: !exibirSenhaUm,
                      style: TextStyle(fontSize: 18),
                      onSaved: (value) {
                        print(value);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo vazio";
                        } else if (value.length < 5) {
                          return "No mínimo 6 caracteres";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: tamEsp, bottom: tamEsp),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Confirme a Senha",
                        style: TextStyle(
                          fontSize: tamText,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                  Form(
                    key: senhaDois,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.security),
                        suffixIcon: IconButton(
                          icon: Icon(exibirSenhaDois
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(
                              () {
                                exibirSenhaDois = !exibirSenhaDois;
                              },
                            );
                          },
                        ),
                      ),
                      style: TextStyle(fontSize: 18),
                      controller: cSenhaDois,
                      obscureText: !exibirSenhaDois,
                      onSaved: (value) {
                        print(value);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo vazio";
                        } else if (value.length < 5) {
                          return "No mínimo 6 caracteres";
                        } else if (cSenhaDois.text != cSenhaUm.text) {
                          return "As senhas são diferentes";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 8),
              child: Text(
                "Dados Empresariais",
                style: TextStyle(
                  fontSize: tamText,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: tamEsp, bottom: tamEsp),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "CNPJ",
                        style: TextStyle(
                          fontSize: tamText,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                  Form(
                    key: cnpj,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Ex: 34.832.541/0001-06',
                        icon: Icon(Icons.work),
                      ),
                      controller: cCnpj,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 18),
                      onSaved: (value) {
                        print(value);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo vazio";
                        } else if (value.length < 7) {
                          return "Cnpj inexistente";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: RaisedButton(
                onPressed: () async {
                  if (nome.currentState.validate() &&
                      email.currentState.validate() &&
                      cnpj.currentState.validate() &&
                      cpf.currentState.validate() &&
                      celular.currentState.validate() &&
                      senhaUm.currentState.validate() &&
                      senhaDois.currentState.validate()) {
                    salvaUsuario();
                    var _email = cEmail.text.toString();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Trilhas(_email),
                      ),
                    );
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Colors.green[700],
                child: Container(
                  width: 250,
                  height: 50,
                  child: Center(
                    child: Text('Cadastrar',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
