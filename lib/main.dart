import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fedya_shashlik/bloc/cart.dart';
import 'package:fedya_shashlik/bloc/category.dart';
import 'package:fedya_shashlik/bloc/connection/connection_cubit.dart';
import 'package:fedya_shashlik/bloc/connection/internet_cubit.dart';
import 'package:fedya_shashlik/bloc/product.dart';
import 'package:fedya_shashlik/data/network/api.dart';
import 'package:fedya_shashlik/data/network/api_service.dart';
import 'package:fedya_shashlik/prefs/user.dart';
import 'package:fedya_shashlik/router.dart';
import 'package:fedya_shashlik/service/notification.dart';
import 'package:fedya_shashlik/ui/pages/main/main_page.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp();
  final api = ApiService(API());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ConnectionCheckerCubit>(
            create: (_) => ConnectionCheckerCubit(internetConnectionChecker: InternetConnectionChecker())),
        BlocProvider<InternetCubit>(create: (_) => InternetCubit(connectivity: Connectivity())),
      ],
      child: MultiProvider(
        providers: [
          Provider(create: (context) => api),
          ChangeNotifierProvider(create: (context) => Cart()),
          ChangeNotifierProvider(create: (context) => ProductBloc()),
          ChangeNotifierProvider(create: (context) => CategoryBloc()),
          ChangeNotifierProvider(create: (context) => MainPageState()),
          Provider(create: (context) => UserPreferences.getInstance()),
        ],
        child: MyApp(app: app),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.app}) : super(key: key);

  final FirebaseApp app;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SystemUiOverlayStyle _currentStyle = SystemUiOverlayStyle.dark;
  final messaging = FirebaseMessaging.instance;
  final localMessaging = PushNotificationService();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    messaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    messaging.requestPermission();
    // FirebaseMessaging.instance.requestPermission();
    // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    // FirebaseMessaging.onMessage.listen((event) => localMessaging.showNotification(
    //       event.notification.hashCode,
    //       event.notification!.title!,
    //       event.notification!.body!,
    //     ));
    messaging.getToken().then((token) async {
      context.read<UserPreferences>().saveFCMToken(token);
      String? phone = await context.read<UserPreferences>().getPhoneNumber();
      if (phone != null && token != null) {
        context.read<ApiService>().postToken(phone: phone, token: token);
      }
    });
    messaging.onTokenRefresh.listen((tokenValue) async {
      context.read<UserPreferences>().saveFCMToken(tokenValue);
      String? phone = await context.read<UserPreferences>().getPhoneNumber();
      if (phone != null) {
        context.read<ApiService>().postToken(phone: phone, token: tokenValue);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => AnnotatedRegion<SystemUiOverlayStyle>(
        value: _currentStyle,
        child: BlocBuilder<ConnectionCheckerCubit, ConnectionCheckerState>(
          bloc: context.read<ConnectionCheckerCubit>(),
          builder: (context, state) {
            if (state is InternetConnectionConnected) {
              context.read<CategoryBloc>().fetchCategory();
              context.read<ProductBloc>().fetchProducts();
            }
            return Provider(
              create: (context) => MyRouter(context.read<ConnectionCheckerCubit>()),
              builder: (context, child) {
                final router = Provider.of<MyRouter>(context, listen: false).router;
                return MaterialApp.router(
                  restorationScopeId: 'app',
                  color: Colors.black,
                  routerDelegate: router.routerDelegate,
                  routeInformationParser: router.routeInformationParser,
                  localizationsDelegates: AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  title: "Федя Шашлык",
                  theme: ThemeData(
                    colorScheme: const ColorScheme.dark(),
                    scaffoldBackgroundColor: AppColors.dark,
                    backgroundColor: AppColors.dark,
                    // appBarTheme: AppTheme.appBarTheme,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
