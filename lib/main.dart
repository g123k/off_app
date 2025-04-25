import 'package:betclic_app/api/openfoodfacts_api.dart';
import 'package:betclic_app/storage/app_storage.dart';
import 'package:betclic_app/style.dart';
import 'package:betclic_app/ui/details/product_details.dart';
import 'package:betclic_app/ui/homepage/homepage_with_riverpod.dart';
import 'package:betclic_app/ui/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

void main() {
  GetIt.instance
    ..registerLazySingleton<IAPIManager>(() => OpenFoodFactsAPIManager())
    ..registerSingleton<IAppStorage>(HiveAppStorage()..init());

  runApp(const MyApp());
}

GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, _) {
        return HomePageWithRiverpod();
      },
      routes: [
        GoRoute(
          path: 'product',
          builder: (BuildContext context, GoRouterState state) {
            final String? barcode = state.uri.queryParameters['barcode'];
            assert(barcode?.isNotEmpty == true);
            return ProductDetails(barcode: barcode!);
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Avenir',
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          extensions: [OffThemeExtension.defaultValues()],
          dividerColor: AppColors.gray2,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: AppColors.blue,
            unselectedItemColor: AppColors.gray2,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
          ),
          navigationBarTheme: const NavigationBarThemeData(
            indicatorColor: AppColors.blue,
          ),
        ),
        routerConfig: _router,
      ),
    );
  }
}
