import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/providers/auth.dart';
import 'package:clover_construction/providers/department.dart';
import 'package:clover_construction/providers/hireWorkers.dart';
import 'package:clover_construction/providers/orders.dart';
import 'package:clover_construction/providers/profile.dart';
import 'package:clover_construction/providers/store.dart';
import 'package:clover_construction/providers/store_category.dart';
import 'package:clover_construction/providers/tools.dart';
import 'package:clover_construction/providers/worker.dart';
import 'package:clover_construction/screens/auth.dart';
import 'package:clover_construction/screens/hired_workers.dart';
import 'package:clover_construction/screens/orders.dart';
import 'package:clover_construction/screens/home.dart';
import 'package:clover_construction/screens/product_payment.dart';
import 'package:clover_construction/screens/profile.dart';
import 'package:clover_construction/screens/splash.dart';
import 'package:clover_construction/screens/store_category.dart';
import 'package:clover_construction/screens/tools.dart';
import 'package:clover_construction/screens/tools_details.dart';
import 'package:clover_construction/screens/worker.dart';
import 'package:clover_construction/screens/worker_details.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: "test_public_key_5904412e4d6243c6aaebe2de1969b623",
      builder: (context, navigatorkey) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: AuthProvider(),
            ),
            ChangeNotifierProvider(create: ((context) => AuthProvider())),
            ChangeNotifierProvider(
              create: (context) => Stores(),
            ),
            ChangeNotifierProvider(
              create: (context) => StoreCategoryProvider(),
            ),
            ChangeNotifierProvider(create: (context) => WorkerProvider()),
            ChangeNotifierProvider(create: (context) => StoreToolsProvider()),
            ChangeNotifierProvider(create: (context) => DepartmentProvider()),
            ChangeNotifierProvider(create: (context) => OrderProvider()),
            ChangeNotifierProvider(create: (context) => HiredWorker()),
            ChangeNotifierProvider(create: (context) => ProfileProvider())
          ],
          child: MaterialApp(
            navigatorKey: navigatorkey,
            title: 'Clover Construction',
            theme: ThemeData(
              primaryColor: primaryColor,
              fontFamily: 'Lato',
              iconTheme: const IconThemeData(
                color: Colors.black,
                size: 24.0,
              ),
              textTheme: const TextTheme(
                  titleMedium: TextStyle(
                fontFamily: 'Lato-Bold',
                fontWeight: FontWeight.w700,
                fontSize: 24,
              )),
            ),
            localizationsDelegates: const[
              KhaltiLocalizations.delegate,
            ],
            home: const SplashScreen(),
            routes: {
              AuthScreen.routeName: (context) => const AuthScreen(),
              HomeScreen.routeName: (context) => const HomeScreen(),
              StoreCategoryScreen.routeName: (context) =>
                  const StoreCategoryScreen(),
              ToolsScreen.routeName: (context) => const ToolsScreen(),
              ToolsDetailsScreen.routeName: (context) =>
                  const ToolsDetailsScreen(),
              WrokerScreen.routeName: (context) => const WrokerScreen(),
              WorkerDetailScreen.routeName: (context) =>
                  const WorkerDetailScreen(),
              OrdersScreen.routeName: (context) => const OrdersScreen(),
              ProductPaymnetScreen.routeName:(context) => const ProductPaymnetScreen(),
              HiredWorkerScreen.routeName: (context) => const HiredWorkerScreen(),
              ProfileScreen.routeName: (context) => const ProfileScreen()
            },
          ),
        );
      },
    );
  }
}
