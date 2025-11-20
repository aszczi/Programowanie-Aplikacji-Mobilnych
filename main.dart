import 'package:flutter/material.dart';
import 'screens/category_list_page.dart';
import 'managers/favorites_manager.dart'; 
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  await FavoritesManager.init();

  runApp(const FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fiszki Perfect Center',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: const Color(0xFFF7A8D8),
        hintColor: const Color(0xFFE0BBE4),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Color(0xFFF7A8D8),
          foregroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const CategoryListPage(),
    );
  }
}