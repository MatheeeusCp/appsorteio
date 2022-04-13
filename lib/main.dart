import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _sorteado;
  final TextEditingController _controllerInitial = TextEditingController();
  final TextEditingController _controllerEnd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sorteio'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
           Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Entre com um intervalo',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _controllerInitial,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _controllerEnd,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: ElevatedButton(
              onPressed: _sortear,
              child: const Text('Sortear'),
            ),
          ),
          Text(
            _sorteado?.toString() ?? 'Nenhum numero selecionado',
          ),
        ],
      ),
    );
  }

  void _sortear() {
    final initial = _controllerInitial.text.trim();
    final end = _controllerEnd.text.trim();

    if (initial.isEmpty || end.isEmpty) {
      _sorteado = 'Preencha todos os campos';

      setState(() {});
      return;
    }

    final min = int.tryParse(initial)!;
    final max = int.tryParse(end)!;

    if (min > max) {
      _sorteado = 'O primeiro campo deve ter valor menor que o segundo';

      setState(() {});
      return;
    }

    final random = Random();
    final value = min + random.nextInt(max - min);
    _sorteado = value.toString();

    setState(() {});
  }
}
