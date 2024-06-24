import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/providers/my_provider.dart';
import 'package:news/providers/search_provider.dart';
import 'package:news/ui/home/home_layout.dart';
import 'package:news/ui/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        MultiProvider(providers: [
          ChangeNotifierProvider(create: (context) => MyProvider()),
          ChangeNotifierProvider(create: (context) => SearchProvider())
        ]),
      ],
      child: EasyLocalization(
          path: 'assets/translations',
          saveLocale: true,
          supportedLocales: const [
            Locale("ar", "EG"),
            Locale("en", "US"),
          ],
          startLocale: const Locale('en', 'US'),
          child: DevicePreview(
              enabled: true, builder: (context) => const MyApp() // Wrap your app
          ),),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    var provider = Provider.of<SearchProvider>(context);
    provider.searchedItem ??= "";
    provider.showSearchIcon ??= false;
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeLayout.routeName: (context) => HomeLayout(),
      },
    );
  }
}
