// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class pagina2 extends StatefulWidget {
  const pagina2({Key? key}) : super(key: key);

  @override
  _pagina2State createState() => _pagina2State();
}

//OBS: Pelo o q eu entendi o STREAM pega algo de algum SERVIDOR EXTERNO
//E o BUILDER faz com q sempre q ele receber algum COMANDO/FUNCAO
//de um servidor externo ele ira FAZER/CONSTRUIR/BUILDER alguma coisa
//tipo um CONTAINER... Entao sempre q o STREAM recebe a informacao q tem
//um novo valor em CAMPO, o BUILDER vai criar um CONTAINER novo e
//por o valor desse CAMPO no TEXT desse CONTAINER

class _pagina2State extends State<pagina2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //EU ACHO q o StreamBuilder serve para dizer q os dados vao ser
        //atualizados em tempo real com o BD/COLLECTION TESTE1
        body: StreamBuilder(
          //passando o parametro Strem q recebe qual o servico q estaremos usando
          //no caso é o FIRESTORE
          //e vamos buscar os dados q ta na COLECAO/BC TESTE1...
          //EU ACHO q SNAPSHOT é uma COPIA dos dados de teste1 EU ACHO
          stream: FirebaseFirestore.instance.collection('teste1').snapshots(),
          //acho q aqui ele ta pegando o q ta no SNAPSHOT e construindo
          //um container para cada valor q tiver no campo nome
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //verificando se o SNAPSHOT tiver VAZIO... Ele poem um GIF
            //de CARREGANDO
            if (!snapshot.hasData) {
              return Center(
                //gif de carregando...
                child: CircularProgressIndicator(),
              );
            }
            return Scaffold(
              body: SafeArea(
                //criando uma COLUMN e nela podemos criar uma LISTA/CHILDREN
                //com varios WIDGESTS
                child: Column(
                  //o primeiro objeto/sintaxe q temos no children é
                  //esse q pega todos os DOCUMENTS q tem um CAMPO com um
                  //valor e imprime no container a baixo
                  children: snapshot.data!.docs.map(
                    (documents) {
                      //passando o valor de campo para o container
                      return Container(
                        height: 100,
                        width: 100,
                        color: Colors.blue,
                        child: Text(documents['campo']),
                      );
                    },
                  ).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
