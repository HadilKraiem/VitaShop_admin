import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'providers/products_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/dashboard_screen.dart';
import 'screens/edit_upload_product_form.dart';
import 'screens/inner_screen/orders/orders_screen.dart';
import 'screens/search_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyB6VGaOfwuveuLAiifimPy7zBD9EYpxuOw',
          appId: '1:907790733415:android:c59b27dd606968544c04c2',
          messagingSenderId: '907790733415',
          projectId: 'vitashop-76ad5',
          storageBucket: "vitashop-76ad5.appspot.com",
        ))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}
// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: SelectableText(snapshot.error.toString()),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return ThemeProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ProductsProvider();
              }),
            ],
            child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Shop Smart ADMIN EN',
                theme: Styles.themeData(
                    isDarkTheme: themeProvider.getIsDarkTheme,
                    context: context),
                home: const DashboardScreen(),
                routes: {
                  OrdersScreenFree.routeName: (context) =>
                      const OrdersScreenFree(),
                  SearchScreen.routeName: (context) => const SearchScreen(),
                  EditOrUploadProductScreen.routeName: (context) =>
                      const EditOrUploadProductScreen(),
                },
              );
            }),
          );
        });
  }
}
