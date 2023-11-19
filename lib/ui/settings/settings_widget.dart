import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

List<String> list = <String>['English', 'اللغه العربيه'];

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue =
        context.locale.languageCode == ("ar") ? list[1] : list.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: Text("Language".tr(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(25),
          child: Container(
            width: 30,
            decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.zero))),
            // padding: const EdgeInsets.only(left: 50),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 3),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (String? value) {
                    value == list[1]
                        ? context.setLocale(const Locale("ar", "EG"))
                        : context.setLocale(const Locale("en", "US"));
                    // dropdownValue = value!;

                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
