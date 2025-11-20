import 'package:flutter/material.dart';
import '../data/flashcard_data.dart';   
import '../managers/favorites_manager.dart'; 
import 'study_page.dart';                 

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  @override
  Widget build(BuildContext context) {
    final categories = FlashcardData.categories.keys.toList();
    final favoritesCount = FavoritesManager.favoritesList.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategorie', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(icon: const Icon(Icons.home), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                'Wybierz temat',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                if (favoritesCount > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudyPage(
                        categoryName: "Ulubione ⭐",
                        englishWords: FavoritesManager.favoritesList,
                      ),
                    ),
                  ).then((_) => setState(() {}));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Brak ulubionych. Dodaj coś!")),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFFD700), Color(0xFFFFA500)]),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))],
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      "Twoje Ulubione ($favoritesCount)",
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final categoryName = categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudyPage(
                              categoryName: categoryName,
                              englishWords: FlashcardData.categories[categoryName]!,
                            ),
                          ),
                        ).then((_) => setState(() {}));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor.withOpacity(0.5 - index * 0.05),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          categoryName,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}