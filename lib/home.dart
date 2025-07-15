import 'package:flutter/material.dart';
import 'package:multi_localization_app/l10n/app_localizations.dart';
import 'package:multi_localization_app/language.dart';
import 'package:provider/provider.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: const InputDecorationTheme(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
            child: DropdownMenu(
              label: FittedBox(child: Text("Lang")),
              initialSelection: context.watch<Language>().selectectLocale,
              textStyle: TextStyle(color: Colors.red),
              dropdownMenuEntries: Language.languages
                  .map(
                    (e) =>
                        DropdownMenuEntry(value: e['locale'], label: e['name']),
                  )
                  .toList(),
              onSelected: (value) {
                context.read<Language>().changeLanguage(value as String);
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.hello),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.read<Language>().changeLanguage('en');
                      },
                      child: Container(
                        height: 100,
                        color: Colors.red,
                        child: Text("1fgsdsssgsgdsgds"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      color: Colors.yellow,
                      child: Text("2"),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      color: Colors.green,
                      child: Text("3"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
