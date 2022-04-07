import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tdd_flutter_imc/main.dart';

Future<void> main() async {
  _initTest(WidgetTester tester) async {
    var widget = MyHomePage(
      title: '',
      isGenres: [false, false],
    );
    await tester.pumpWidget(MaterialApp(
      home: widget,
    ));
    return widget;
  }

  testWidgets('Deve selecionar uma data de nascimento corretamente',
      (WidgetTester tester) async {
    await _initTest(tester);
    var birthDateButon = find.byElementPredicate((element) {
      if (element.widget is ElevatedButton) {
        return true;
      }
      return false;
    });
    expect(birthDateButon, findsOneWidget);

    await tester.tap(birthDateButon);
    await tester.pumpAndSettle();

    var btnEdit = find.byIcon(Icons.edit);
    expect(btnEdit, findsOneWidget);

    await tester.tap(btnEdit);
    await tester.pumpAndSettle();

    var dateField = find.byType(TextFormField);
    expect(dateField, findsOneWidget);

    await tester.enterText(dateField, '04/21/1986');

    var btnOk = find.text('OK');
    await tester.pumpAndSettle();
    expect(btnOk, findsOneWidget);
    await tester.tap(btnOk);
    await tester.pumpAndSettle();

    btnOk = find.text('OK');
    expect(btnOk, findsNothing);

    var birthDateText = find.text('21/04/1986');
    expect(birthDateText, findsOneWidget);
  });

  testWidgets('deve ser selecionado o ??? corretamente feminino corretamente',
      (WidgetTester tester) async {
    var screen = await _initTest(tester);

    var genderToogle = find.byType(ToggleButtons);
    expect(genderToogle, findsOneWidget);

    var genderFemale = find.byIcon(Icons.female);
    expect(genderFemale, findsOneWidget);

    await tester.tap(genderFemale);

    expect(screen.isGenres[0], true);
    expect(screen.isGenres[1], false);
  });

  testWidgets('deve ser selecionado o ??? corretamente masculino corretamente',
      (WidgetTester tester) async {
    var screen = await _initTest(tester);

    var genderToogle = find.byType(ToggleButtons);
    expect(genderToogle, findsOneWidget);

    var genderMale = find.byIcon(Icons.male);
    expect(genderMale, findsOneWidget);

    await tester.tap(genderMale);

    expect(screen.isGenres[0], false);
    expect(screen.isGenres[1], true);
  });
}
