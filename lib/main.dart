import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthcrimea/screens/buyer/main_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'providers/products_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    publishableKey: dotenv.env['SUPABESE_ANON_KEY']!,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductsProvider()..fetchProducts(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,

          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFFE600),
            surface: Colors.white,
            surfaceTint: Colors.transparent,
          ),

          cardTheme: const CardThemeData(
            surfaceTintColor: Colors.transparent,
            color: Colors.white,
          ),

          bottomSheetTheme: const BottomSheetThemeData(
            surfaceTintColor: Colors.transparent,
          ),

          dialogTheme: const DialogThemeData(
            surfaceTintColor: Colors.transparent,
          ),

          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        ),
        home: MainScreen(),
      ),
    ),
  );
}

final supabase = Supabase.instance.client;
