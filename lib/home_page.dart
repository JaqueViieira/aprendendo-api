import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<List> pegarUsuario() async {
  var url = Uri.parse(
    'https://63335438433198e79dc37265.mockapi.io/api/v1/users',
  );
  var response = await http.get(url);
  if (response.statusCode == 200) {
    return jsonDecode(
      utf8.decode(response.bodyBytes),
    );
  } else {
    throw Exception('Erro ao carregar dados do servidor');
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: pegarUsuario(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar usuarios'),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data![index]['name'],
                  ),
                  subtitle: Text(snapshot.data![index]['id']),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
