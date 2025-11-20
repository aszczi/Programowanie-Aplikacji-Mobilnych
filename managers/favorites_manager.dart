import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManager {
  
  static Set<String> _favorites = {};
  
  static const String _storageKey = 'saved_flashcards_favorites';

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? storedList = prefs.getStringList(_storageKey);
    
    if (storedList != null) {
      _favorites = storedList.toSet();
    }
  }

  static bool isFavorite(String word) => _favorites.contains(word);

  static Future<void> toggleFavorite(String word) async {
    if (_favorites.contains(word)) {
      _favorites.remove(word);
    } else {
      _favorites.add(word);
    }
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_storageKey, _favorites.toList());
  }

  static List<String> get favoritesList => _favorites.toList();
}