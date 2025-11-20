class FavoritesManager {
  static final Set<String> _favorites = {};

  static bool isFavorite(String word) => _favorites.contains(word);

  static void toggleFavorite(String word) {
    if (_favorites.contains(word)) {
      _favorites.remove(word);
    } else {
      _favorites.add(word);
    }
  }

  static List<String> get favoritesList => _favorites.toList();
}