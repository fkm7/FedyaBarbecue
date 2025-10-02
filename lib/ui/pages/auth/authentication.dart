import 'package:fedya_shashlik/data/network/api_service.dart';
import 'package:fedya_shashlik/prefs/user.dart';
import 'package:fedya_shashlik/ui/pages/auth/registration.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  static String route = '/auth';

  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _phoneController = TextEditingController();
  final _smsCodeController = TextEditingController();
  bool _numberInserted = false;
  bool isRegistered = false;
  String _phoneNumber = '';
  String _smsCode = '';
  String _status = '';
  final phoneFocus = FocusNode();
  final codeFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: _numberInserted
            ? IconButton(
                onPressed: () {
                  setState(() => _numberInserted = false);
                },
                icon: const Icon(Icons.arrow_back),
              )
            : IconButton(
                onPressed: () {
                  context.pop();
                  // Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
        title: Text(AppLocalizations.of(context)!.authentication),
      ),
      body: !_numberInserted
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    AppLocalizations.of(context)!.enterNumberText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: IntlPhoneField(
                    focusNode: phoneFocus,
                    keyboardType: TextInputType.phone,
                    showCountryFlag: false,
                    countries: const ['UZ'],
                    initialCountryCode: 'UZ',
                    controller: _phoneController,
                    onSubmitted: _phoneNumber.contains(RegExp(r'^(\+998)[0-9]{9}'))
                        ? (value) async {
                            _phoneController.clear();
                            setState(() => _numberInserted = true);
                            _status = await Provider.of<ApiService>(context, listen: false).checkPhoneNumber(_phoneNumber);
                          }
                        : (value) {
                            phoneFocus.requestFocus();
                          },
                    onChanged: (value) => setState(() => _phoneNumber = value.completeNumber),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.phoneNumber,
                      counter: const SizedBox(),
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
                      onPressed: _phoneNumber.contains(RegExp(r'^(\+998)[0-9]{9}'))
                          ? () async {
                              setState(() => _numberInserted = true);
                              _phoneController.clear();
                              _status = await Provider.of<ApiService>(context, listen: false).checkPhoneNumber(_phoneNumber);
                            }
                          : null,
                      child: Text(
                        AppLocalizations.of(context)!.next,
                        style: AppTextStyles.title0.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    AppLocalizations.of(context)!.enterCodeText + ' ' + _phoneNumber,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    maxLength: 4,
                    controller: _smsCodeController,
                    onChanged: (value) => setState(() => _smsCode = value),
                    keyboardType: TextInputType.number,
                    onSubmitted: (value) async {
                      if (_smsCode.length < 4) {
                        codeFocus.requestFocus();
                      } else if (_phoneNumber.contains(RegExp(r'^(\+998)[0-9]{9}'))) {
                        int response = await ApiService.getInstance().smsVerification(_phoneNumber, _smsCode);
                        if (response == 200) {
                          UserPreferences.getInstance().savePhoneNumber(_phoneNumber);
                          if (_status == 'register') {
                            Navigator.popAndPushNamed(
                              context,
                              RegistrationPage.route,
                              arguments: _phoneNumber,
                            );
                          } else if (_status == 'login') {
                            ApiService.getInstance().getUserDetail(phone: _phoneNumber);
                            Navigator.pop(context);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red, content: Text('Код не правильные', style: AppTextStyles.label)));
                        }
                      }
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.smsCode,
                      counter: const SizedBox(),
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
                      child: Text(
                        AppLocalizations.of(context)!.confirm,
                        style: AppTextStyles.title0.copyWith(color: Colors.black),
                      ),
                      onPressed: _phoneNumber.contains(RegExp(r'^(\+998)[0-9]{9}')) && _smsCode.length == 4
                          ? () async {
                              // _smsCodeController.clear();
                              int response = await ApiService.getInstance().smsVerification(_phoneNumber, _smsCode);
                              if (response == 200) {
                                var token = await UserPreferences.getInstance().getFCMToken();
                                if (token != null) ApiService.getInstance().postToken(phone: _phoneNumber, token: token);
                                await UserPreferences.getInstance().savePhoneNumber(_phoneNumber);
                                if (_status == 'register') {
                                  Navigator.popAndPushNamed(context, RegistrationPage.route, arguments: _phoneNumber);
                                } else if (_status == 'login') {
                                  ApiService.getInstance().getUserDetail(phone: _phoneNumber);
                                  Navigator.pop(context);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.red, content: Text('Код не правильные', style: AppTextStyles.label)));
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
