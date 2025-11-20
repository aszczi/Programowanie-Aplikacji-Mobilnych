import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:http/http.dart' as http;
import '../managers/favorites_manager.dart'; 

class StudyPage extends StatefulWidget {
  final String categoryName;
  final List<String> englishWords;

  const StudyPage({super.key, required this.categoryName, required this.englishWords});

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  int _currentIndex = 0;

  String? _currentDefinition;
  String? _currentPolishTranslation;
  String? _currentPhonetic;
  String? _currentExample;
  List<String> _currentSynonyms = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final word = widget.englishWords[_currentIndex].toLowerCase();

    setState(() {
      _isLoading = true;
      _currentDefinition = null;
      _currentPolishTranslation = null;
      _currentPhonetic = null;
      _currentExample = null;
      _currentSynonyms = [];
    });

    try {
      final url = Uri.parse('https://freedictionaryapi.com/api/v1/entries/en/$word?translations=true');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        String def = "Brak definicji.";
        String plTrans = "Brak tłumaczenia";
        String? phonetic;
        String? example;
        List<String> synonyms = [];

        if (data['entries'] != null && (data['entries'] as List).isNotEmpty) {
          var entry = data['entries'][0];
          if (entry['pronunciations'] != null) {
            for (var p in entry['pronunciations']) {
              if (p['text'] != null) {
                phonetic = p['text'];
                break;
              }
            }
          }
          if (entry['senses'] != null && (entry['senses'] as List).isNotEmpty) {
            var sense = entry['senses'][0];
            def = sense['definition'] ?? "Brak";
            if (sense['examples'] != null && (sense['examples'] as List).isNotEmpty) {
              example = sense['examples'][0].toString();
            }
            if (sense['synonyms'] != null) {
              synonyms = List<String>.from(sense['synonyms']);
            }
          }
        }

        bool foundTrans = false;
        if (data['entries'] != null) {
          for (var entry in data['entries']) {
            if (entry['senses'] != null) {
              for (var sense in entry['senses']) {
                if (sense['translations'] != null) {
                  for (var trans in sense['translations']) {
                    if (trans['language'] != null && trans['language']['code'] == 'pl') {
                      plTrans = trans['word'];
                      foundTrans = true;
                      break;
                    }
                  }
                }
                if (foundTrans) break;
              }
            }
            if (foundTrans) break;
          }
        }

        if (mounted) {
          setState(() {
            _currentDefinition = def;
            _currentPolishTranslation = plTrans;
            _currentPhonetic = phonetic;
            _currentExample = example;
            _currentSynonyms = synonyms.take(5).toList();
          });
        }
      } else {
        if (mounted) setState(() {
          _currentDefinition = "Błąd API";
          _currentPolishTranslation = "Błąd";
        });
      }
    } catch (e) {
      if (mounted) setState(() {
        _currentDefinition = "Błąd połączenia";
        _currentPolishTranslation = "Błąd sieci";
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _nextCard() {
    if (_currentIndex < widget.englishWords.length - 1) {
      setState(() { _currentIndex++; });
      _fetchData();
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      setState(() { _currentIndex--; });
      _fetchData();
    }
  }

  void _showMoreDetails() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.englishWords[_currentIndex], style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                  if (_currentPhonetic != null) Text(_currentPhonetic!, style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.grey)),
                ],
              ),
              const Divider(height: 30),
              const Text("PRZYKŁAD UŻYCIA:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey, letterSpacing: 1)),
              const SizedBox(height: 5),
              Text(_currentExample != null ? '"$_currentExample"' : "Brak przykładu w API.", style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
              const SizedBox(height: 20),
              const Text("SYNONIMY:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey, letterSpacing: 1)),
              const SizedBox(height: 10),
              if (_currentSynonyms.isNotEmpty) Wrap(spacing: 8.0, runSpacing: 4.0, children: _currentSynonyms.map((syn) => Chip(label: Text(syn), backgroundColor: Theme.of(context).hintColor.withOpacity(0.2))).toList()) else const Text("Brak synonimów w API.", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentEnglishWord = widget.englishWords[_currentIndex];
    final isFav = FavoritesManager.isFavorite(currentEnglishWord);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [IconButton(icon: const Icon(Icons.home), onPressed: () => Navigator.popUntil(context, (route) => route.isFirst))],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.8), borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Text(widget.categoryName, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Center(
              child: SizedBox(
                height: 400,
                width: MediaQuery.of(context).size.width * 0.85,
                child: FlipCard(
                  key: ValueKey(_currentIndex),
                  direction: FlipDirection.HORIZONTAL,
                  front: _buildCardSide(
                    mainText: currentEnglishWord,
                    bottomText: _currentDefinition,
                    isLoading: _isLoading,
                    bgColor: const Color(0xFFF7A8D8).withOpacity(0.7),
                    textColor: Colors.black87,
                    label: "ANGIELSKI",
                    isFront: true,
                  ),
                  back: _buildCardSide(
                    mainText: _isLoading ? "..." : (_currentPolishTranslation ?? "..."),
                    bottomText: null,
                    isLoading: false,
                    bgColor: const Color(0xFFE0BBE4),
                    textColor: Colors.black87,
                    label: "POLSKI",
                    isFront: false,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          IconButton(iconSize: 60, icon: Icon(isFav ? Icons.star : Icons.star_border, color: isFav ? Colors.amber : const Color(0xFFE0BBE4)), onPressed: () { setState(() { FavoritesManager.toggleFavorite(currentEnglishWord); }); }),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: _currentIndex > 0 ? _previousCard : null, style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300], foregroundColor: Colors.black87), child: const Text("Poprzednia")),
                ElevatedButton(onPressed: _currentIndex < widget.englishWords.length - 1 ? _nextCard : null, style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300], foregroundColor: Colors.black87), child: const Text("Następna")),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildCardSide({
    required String mainText,
    String? bottomText,
    required bool isLoading,
    required Color bgColor,
    required Color textColor,
    required String label,
    required bool isFront,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textColor.withOpacity(0.5))),
                const SizedBox(height: 20),
                if (isLoading && isFront)
                   const CircularProgressIndicator(color: Colors.white)
                else
                  Text(
                    mainText,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textColor),
                    textAlign: TextAlign.center
                  ),

                if (isFront && !isLoading) ...[
                  const SizedBox(height: 20),
                  Divider(color: textColor.withOpacity(0.3)),
                  const SizedBox(height: 10),
                  Text(bottomText ?? "...", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: textColor.withOpacity(0.8)), textAlign: TextAlign.center, maxLines: 3, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 40),
                ]
              ],
            ),
          ),

          if (isFront && !isLoading)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: TextButton.icon(
                  onPressed: _showMoreDetails,
                  label: Text("Pokaż więcej", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}