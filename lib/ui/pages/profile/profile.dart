import 'package:fedya_shashlik/data/network/api_service.dart';
import 'package:fedya_shashlik/prefs/user.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

enum Gender { male, female }

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const route = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _mailController = TextEditingController();
  final _genderController = TextEditingController();

  String? _phoneNumber = '', _firstName = '', _lastName = '', _mail = '';
  Gender? _gender = Gender.male;
  DateTime? _dateOfBirth;

  void fetchData() async {
    _firstName = await UserPreferences.getInstance().getFirstName();
    _lastName = await UserPreferences.getInstance().getLastName();
    _phoneNumber = await UserPreferences.getInstance().getPhoneNumber();
    _mail = await UserPreferences.getInstance().getMail();
    _gender = await UserPreferences.getInstance().getGender();
    _dateOfBirth = await UserPreferences.getInstance().getDateOfBirth();
    setState(() {
      _firstNameController.text = _firstName!;
      _lastNameController.text = _lastName!;
      _mailController.text = _mail ?? '';
      _genderController.text = _gender != null ? (Gender.values.firstWhere((element) => element == _gender) == Gender.male ? 'Мужчина' : 'Женщина') : '';
      _dateOfBirthController.text = (_dateOfBirth != null
          ? ('${_dateOfBirth!.day < 10 ? '0${_dateOfBirth!.day}' : _dateOfBirth!.day.toString()}.${_dateOfBirth!.month < 10 ? '0${_dateOfBirth!.month}' : _dateOfBirth!.month.toString()}.${_dateOfBirth!.year}')
          : '');
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: SizedBox(
                  height: mediaQuery.size.height * .14,
                  width: mediaQuery.size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.phoneNumber,
                          style: AppTextStyles.label,
                        ),
                        const SizedBox(height: 4.0),
                        FutureBuilder(
                          future: UserPreferences.getInstance().getPhoneNumber(),
                          builder: (context, snapshot) => snapshot.hasData ? Text(snapshot.data.toString(), style: AppTextStyles.title0) : const Text(''),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _firstNameController,
                        onChanged: (value) => _firstName = value,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.firstName,
                        ),
                      ),
                      TextField(
                        controller: _lastNameController,
                        onChanged: (value) => _lastName = value,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.lastName,
                        ),
                      ),
                      TextField(
                        controller: _dateOfBirthController,
                        onTap: () async {
                          _dateOfBirth = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (_dateOfBirth != null) {
                            _dateOfBirthController.text =
                                '${_dateOfBirth!.day < 10 ? '0${_dateOfBirth!.day}' : _dateOfBirth!.day.toString()}.${_dateOfBirth!.month < 10 ? '0${_dateOfBirth!.month}' : _dateOfBirth!.month.toString()}.${_dateOfBirth!.year}';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.dateOfBirth,
                        ),
                      ),
                      TextField(
                        controller: _mailController,
                        onChanged: (value) => _mail = value,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.mail,
                        ),
                      ),
                      TextField(
                        readOnly: true,
                        enabled: true,
                        controller: _genderController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: AppLocalizations.of(context)!.gender,
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            // routeSettings: ,
                            // useRootNavigator: true,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            context: context,
                            builder: (context) => IntrinsicHeight(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(AppLocalizations.of(context)!.male),
                                    leading: Radio(
                                      value: Gender.male,
                                      groupValue: _gender,
                                      onChanged: (Gender? value) {
                                        _gender = value!;
                                        _genderController.text = AppLocalizations.of(context)!.male;
                                        Navigator.pop(context);
                                      },
                                    ),
                                    onTap: () {
                                      _gender = Gender.male;
                                      _genderController.text = AppLocalizations.of(context)!.male;
                                      context.pop();
                                    },
                                  ),
                                  ListTile(
                                    title: Text(AppLocalizations.of(context)!.female),
                                    leading: Radio(
                                      value: Gender.female,
                                      groupValue: _gender,
                                      onChanged: (Gender? value) {
                                        _gender = value!;
                                        _genderController.text = AppLocalizations.of(context)!.female;
                                        context.pop();
                                      },
                                    ),
                                    onTap: () {
                                      _gender = Gender.female;
                                      _genderController.text = AppLocalizations.of(context)!.female;
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(24.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  height: mediaQuery.size.height * .08,
                  minWidth: mediaQuery.size.width,
                  color: AppColors.yellow,
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    UserPreferences.getInstance().savePhoneNumber(_phoneNumber ?? '');
                    UserPreferences.getInstance().saveFirstName(_firstName ?? '');
                    UserPreferences.getInstance().saveLastName(_lastName ?? '');
                    UserPreferences.getInstance().saveDateOfBirth(_dateOfBirth);
                    UserPreferences.getInstance().saveMail(_mail);
                    UserPreferences.getInstance().saveGender(_gender);
                    if (_phoneNumber != null && _firstName != null && _lastName != null) {
                      ApiService.getInstance().editName(_phoneNumber!, '${_firstName!} ${_lastName!}');
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
