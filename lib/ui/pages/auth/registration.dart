import 'package:fedya_shashlik/data/network/api_service.dart';
import 'package:fedya_shashlik/ui/pages/main/main_page.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistrationPage extends StatefulWidget {
  static const route = '/registration';

  const RegistrationPage({Key? key, required this.phone}) : super(key: key);

  final String phone;

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _nameController = TextEditingController();
  String name = '';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.registration),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              AppLocalizations.of(context)!.registrationText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextField(
              controller: _nameController,
              onChanged: (value) => setState(() => name = value),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(24.0),
              child: MaterialButton(
                disabledColor: Colors.grey,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                color: AppColors.yellow,
                height: mediaQuery.size.height * .07,
                minWidth: mediaQuery.size.width,
                onPressed: _nameController.text.isNotEmpty
                    ? () async {
                        int response = await ApiService.getInstance().editName(widget.phone, name);
                        if (response == 200) {
                          Navigator.popAndPushNamed(context, MainPage.route);
                        }
                      }
                    : null,
                child: Text(
                  AppLocalizations.of(context)!.confirm,
                  style: AppTextStyles.title0.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
