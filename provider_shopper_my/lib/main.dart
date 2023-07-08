
// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper1/common/theme.dart';
import 'package:provider_shopper1/models/cart.dart';
import 'package:provider_shopper1/models/catalog.dart';
import 'package:provider_shopper1/screens/cart.dart';
import 'package:provider_shopper1/screens/catalog.dart';
import 'package:provider_shopper1/screens/login.dart';
//import 'package:desktop_window/desktop_window.dart';
//import 'package:window_size/window_size.dart';

void main() {
  setupWindow();
  runApp(const MyApp());
}

const double windowWidth = 400;
const double windowHeight = 800;

/*void setupWindow() async {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Demo');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}*/

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    if (Platform.isWindows) {
      var APPDATA;
      Process.run('powershell', ['(New-Object -ComObject Shell.Application).NameSpace(0x0).Self.Path = "$APPDATA\\YourAppName"']).then((_) {
        var PID;
        Process.run('powershell', ['(Get-Process -PID $PID).MainWindowTitle = "Provider Demo"']);
      });
    } else if (Platform.isLinux) {
      Process.run('bash', ['-c', 'xdg-open .desktop']).then((_) {
        Process.run('bash', ['-c', 'wmctrl -r "Provider Demo" -N "Provider Demo"']);
      });
    } else if (Platform.isMacOS) {
      Process.run('osascript', ['-e', 'tell application "Finder" to set name of application file to "Provider Demo"']);
      var PID;
      Process.run('osascript', ['-e', 'tell application "System Events" to set name of first process whose unix id is $PID to "Provider Demo"']);
    }
  }
}


GoRouter router() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const MyLogin(),
      ),
      GoRoute(
        path: '/catalog',
        builder: (context, state) => const MyCatalog(),
        routes: [
          GoRoute(
            path: 'cart',
            builder: (context, state) => const MyCart(),
          ),
        ],
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'Provider Demo',
        theme: appTheme,
        routerConfig: router(),
      ),
    );
  }
}
