import 'package:d_convertor/logic.dart';
import 'package:d_convertor/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ref.watch(themeProvider),
      theme: ThemeData(),
      darkTheme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const MyHomePage(title: 'D Convertor'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, ref) {
    final temp = ref.watch(tempProvider);
    final themeMode = ref.watch(themeProvider);
    final enteredTemp = ref.watch(enteredTempProvider);
    final selectedDegree2 = ref.watch(selectedTemp2Provider);
    final selectedDegree1 = ref.watch(selectedTemp1Provider);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: true,
            title: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black)),
            actions: [
              IconButton(
                  onPressed: () => ref.read(themeProvider.notifier).state =
                      themeMode == ThemeMode.dark
                          ? ThemeMode.light
                          : ThemeMode.dark,
                  icon: themeMode == ThemeMode.dark
                      ? const Icon(CupertinoIcons.sun_max, color: Colors.white)
                      : const Icon(CupertinoIcons.moon_stars_fill,
                          color: Colors.black))
            ]),
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(25.0),
                child: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      Text(temp,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 30.0),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (newTemp) {
                            if (newTemp == '' ||
                                RegExp(r'^[a-z`!@#$%^&*()+_=]')
                                    .hasMatch(newTemp.toLowerCase())) {
                              ref.read(enteredTempProvider.notifier).state =
                                  0.0;
                            } else {
                              ref.read(enteredTempProvider.notifier).state =
                                  double.parse(newTemp);
                            }
                          },
                          initialValue: enteredTemp.toString(),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor)))),
                      const SizedBox(height: 25.0),
                      DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor))),
                          value: selectedDegree1,
                          items: const [
                            DropdownMenuItem(
                                child: Text('Celsius'), value: 'Celsius'),
                            DropdownMenuItem(
                                child: Text('Fahrenheit'), value: 'Fahrenheit'),
                            DropdownMenuItem(
                                child: Text('Kelvin'), value: 'Kelvin')
                          ],
                          onChanged: (newTemp) => ref
                              .watch(selectedTemp1Provider.notifier)
                              .state = newTemp!),
                      const SizedBox(height: 25.0),
                      const Text('TO'),
                      const SizedBox(height: 25.0),
                      DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor))),
                          value: selectedDegree2,
                          items: const [
                            DropdownMenuItem(
                                child: Text('Celsius'), value: 'Celsius'),
                            DropdownMenuItem(
                                child: Text('Fahrenheit'), value: 'Fahrenheit'),
                            DropdownMenuItem(
                                child: Text('Kelvin'), value: 'Kelvin')
                          ],
                          onChanged: (newTemp) => ref
                              .watch(selectedTemp2Provider.notifier)
                              .state = newTemp!),
                      const SizedBox(height: 25.0)
                    ]))));
  }
}
