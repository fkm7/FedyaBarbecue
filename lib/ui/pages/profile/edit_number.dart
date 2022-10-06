import 'package:fedya_shashlik/data/network/api_service.dart';
import 'package:fedya_shashlik/prefs/user.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class EditNumberPage extends StatefulWidget {
  const EditNumberPage({Key? key}) : super(key: key);

  static const route = '/editNumber';

  @override
  State<EditNumberPage> createState() => _EditNumberPageState();
}

class _EditNumberPageState extends State<EditNumberPage> {
  final _phoneController = TextEditingController();
  final _smsCodeController = TextEditingController();
  bool numberInserted = false;
  String phoneNumber = '';
  String smsCode = '';
  String status = '';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: numberInserted
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _phoneController.text = phoneNumber;
                    _smsCodeController.clear();
                    numberInserted = false;
                  });
                },
                icon: const Icon(Icons.arrow_back),
              )
            : IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.close),
              ),
        title: Text(
          AppLocalizations.of(context)!.editPhone,
          style: AppTextStyles.appBarTitle.copyWith(
            fontSize: 16,
          ),
        ),
      ),
      body: !numberInserted
          ? Column(
              children: [
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    AppLocalizations.of(context)!.phoneNumber,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: IntlPhoneField(
                    countries: const ['UZ'],
                    initialCountryCode: 'UZ',
                    showCountryFlag: false,
                    controller: _phoneController,
                    onChanged: (value) => setState(() => phoneNumber = value.completeNumber),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context)!.phoneNumber),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      disabledColor: Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      height: mediaQuery.size.height * .07,
                      minWidth: mediaQuery.size.width,
                      color: AppColors.yellow,
                      child: Text(
                        AppLocalizations.of(context)!.next,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: phoneNumber.contains(RegExp(r'^(\+998)[0-9]{9}'))
                          ? () async {
                              _phoneController.clear();
                              setState(() => numberInserted = true);
                              status = await Provider.of<ApiService>(context, listen: false).checkPhoneNumber(phoneNumber);
                            }
                          : null,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    AppLocalizations.of(context)!.enterCodeText + " +998906024795",
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    controller: _smsCodeController,
                    onChanged: (value) => smsCode = value,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.enterCode,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      disabledColor: Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      height: mediaQuery.size.height * .08,
                      minWidth: mediaQuery.size.width,
                      color: AppColors.yellow,
                      child: Text(
                        AppLocalizations.of(context)!.confirm,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: phoneNumber.contains(RegExp(r'^(\+998)[0-9]{9}')) && smsCode.length == 4
                          ? () async {
                              int response = await ApiService.getInstance().smsVerification(phoneNumber, smsCode);
                              if (response == 200) {
                                UserPreferences.getInstance().savePhoneNumber(phoneNumber);
                                Navigator.pop(context);
                              }
                            }
                          : null,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
