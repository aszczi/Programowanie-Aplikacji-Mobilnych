class FlashcardData {

  static final Map<String, List<String>> categories = {
    'Podróże': [
      'map', 'guide', 'bus', 'city', 'flight', 'travel', 'trip',
      'tourist', 'airport', 'ticket', 'island',
    ],
    'Jedzenie': [
      'meat', 'dinner', 'salad', 'soup', 'fish',
      'banana', 'orange', 'vegetable',
      'salt', 'coffee', 'bread', 'cheese', 'egg', 'chicken',
    ],
    'Praca': [
      'project', 'email', 'manager', 'job', 'task', 'work', 'office', 'boss',
      'report', 'phone', 'worker', 'colleague',
      'shop', 'money', 'pay', 'holiday', 'weekend',
    ],
    'Natura': [
      'hill', 'wind', 'flower', 'forest', 'ocean', 'island', 'desert',
      'cloud', 'sun', 'star',
    ],
    'Uczucia': [
      'happy', 'thirsty', 'sleepy', 'scared', 'bored', 'calm',
      'surprised', 'shy', 'confused',
    ],
    'Dom': [
      'kitchen', 'garden', 'home',
      'door', 'window', 'roof', 'chair', 'bed',
      'sofa', 'key', 'stairs',
    ],
    'Szkoła': [
      'school', 'notebook', 'class', 'homework',
      'grade', 'teacher', 'lesson', 'test',
      'rubber', 'chair', 'blackboard', 'subject',
    ],
    'Zakupy': [
      'sale', 'discount', 'expensive',
      'seller', 'shop', 'store', 'money', 'price',
      'basket', 'queue', 'size', 'clothes',
    ],
    'Zdrowie': [
      'medicine', 'doctor', 'toothache', 'hospital',
      'fever', 'cough', 'nurse', 'clinic',
      'flu', 'pain', 'headache', 'bandage', 'exercise',
    ],
    'Technologia': [
      'email', 'website', 'laptop', 'smartphone',
      'mouse', 'video',
    ],
  };

  //BAZA DANYCH OFFLINE
 
  static final Map<String, Map<String, dynamic>> offlineData = {
   
    'map': {'pl': 'mapa', 'def': 'A diagram representation of an area.', 'ex': 'I need a map of the city.'},
    'guide': {'pl': 'przewodnik', 'def': 'A person who leads or directs other people.', 'ex': 'The tour guide was very friendly.'},
    'bus': {'pl': 'autobus', 'def': 'A large motor vehicle carrying passengers.', 'ex': 'We go to school by bus.'},
    'city': {'pl': 'miasto', 'def': 'A large town.', 'ex': 'New York is a big city.'},
    'flight': {'pl': 'lot', 'def': 'The action or process of flying.', 'ex': 'The flight was delayed.'},
    'travel': {'pl': 'podróżować', 'def': 'Make a journey.', 'ex': 'I love to travel.'},
    'trip': {'pl': 'wycieczka', 'def': 'A journey or excursion.', 'ex': 'School trip to the zoo.'},
    'tourist': {'pl': 'turysta', 'def': 'A person who is travelling for pleasure.', 'ex': 'The city is full of tourists.'},
    'airport': {'pl': 'lotnisko', 'def': 'A complex of runways and buildings for aircraft.', 'ex': 'We arrived at the airport early.'},
    'ticket': {'pl': 'bilet', 'def': 'A piece of paper giving the holder a right to admission.', 'ex': 'Where is my train ticket?'},
    'island': {'pl': 'wyspa', 'def': 'A piece of land surrounded by water.', 'ex': 'They live on an island.'},
    
    'meat': {'pl': 'mięso', 'def': 'The flesh of an animal as food.', 'ex': 'I do not eat meat.'},
    'dinner': {'pl': 'obiad / kolacja', 'def': 'The main meal of the day.', 'ex': 'Dinner is ready.'},
    'soup': {'pl': 'zupa', 'def': 'A liquid dish made by boiling meat or vegetables.', 'ex': 'Tomato soup is tasty.'},
    'coffee': {'pl': 'kawa', 'def': 'A hot drink made from roasted coffee beans.', 'ex': 'I drink coffee every morning.'},
    'bread': {'pl': 'chleb', 'def': 'Food made of flour, water, and yeast.', 'ex': 'Fresh bread smells good.'},
    
    
    'happy': {'pl': 'szczęśliwy', 'def': 'Feeling or showing pleasure.', 'ex': 'I am so happy today.'},
    'scared': {'pl': 'przestraszony', 'def': 'Fearful; frightened.', 'ex': 'He is scared of spiders.'},

  };
}