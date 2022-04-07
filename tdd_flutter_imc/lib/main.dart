import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        isGenres: [false, false],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
    required this.isGenres,
  }) : super(key: key);

  final String title;
  List<bool> isGenres;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String birthDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async => {await _getBirthDate(context)},
              child: const Text('Data de nascimento'),
            ),
            Text(
              birthDate,
            ),
            ToggleButtons(
              children: const <Widget>[
                Icon(Icons.female),
                Icon(Icons.male),
              ],
              onPressed: (int index) {
                setState(() {
                  widget.isGenres[0] = false;
                  widget.isGenres[1] = false;
                  widget.isGenres[index] = true;
                });
              },
              isSelected: widget.isGenres,
            ),
          ],
        ),
      ), //
    );
  }

  _getBirthDate(context) async {
    DateTime? local = await showDatePicker(
        context: context,
        initialDate: DateTime(2022),
        firstDate: DateTime(1900),
        lastDate: DateTime(2023));
    setState(
      () => birthDate = DateFormat('dd/MM/yyyy').format(
        (local)!,
      ),
    );
  }
}
