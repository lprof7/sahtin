import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/data/models/dish.dart';
import 'package:food_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

/// ---------- Service للتعامل مع Firestore ----------
class DishService {
  final CollectionReference dishesCollection = FirebaseFirestore.instance
      .collection('dishes');

  Future<void> addMultiple(List<Dish> dishes) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (var dish in dishes) {
      final docRef = dishesCollection.doc(); // Firebase يولد ID تلقائي
      final data = dish.toJson();
      data.remove('uid'); // نحذف uid من البيانات المخزنة
      batch.set(docRef, data);
    }
    await batch.commit();
  }
}

/// ---------- واجهة ----------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Algerian Dishes',
      home: const AddDishesPage(),
    );
  }
}

class AddDishesPage extends StatefulWidget {
  const AddDishesPage({super.key});

  @override
  State<AddDishesPage> createState() => _AddDishesPageState();
}

class _AddDishesPageState extends State<AddDishesPage> {
  final DishService dishService = DishService();
  bool _isLoading = false;

  /// نبني قائمة أطباق جزائرية
  List<Dish> _buildAlgerianDishes() {
    return [
      Dish(
        uid: "", // مش هنستعمله
        name: "كسكس باللحم",
        description: "كسكس جزائري تقليدي مع لحم وخضار.",
        kal: 450,
        rating: Rating(stars: 4.6, ratingsNumber: 230),
        options: [
          Option(name: "حجم صغير", price: 3.0),
          Option(name: "حجم كبير", price: 6.0),
        ],
        picture: "https://example.com/couscous.jpg",
        category: "جزائري",
      ),
      Dish(
        uid: "",
        name: "شوربة الحريرة",
        description: "شوربة جزائرية دافئة مع الحمص والعدس.",
        kal: 180,
        rating: Rating(stars: 4.3, ratingsNumber: 90),
        options: [Option(name: "مع خبز", price: 0.5)],
        picture: "https://example.com/chorba.jpg",
        category: "جزائري",
      ),
      Dish(
        uid: "",
        name: "مقروط",
        description: "حلوى جزائرية بالتمور والعسل.",
        kal: 300,
        rating: Rating(stars: 4.7, ratingsNumber: 150),
        options: [Option(name: "علبة 6", price: 4.0)],
        picture: "https://example.com/makroud.jpg",
        category: "حلويات",
      ),
      Dish(
        uid: "",
        name: "بريك",
        description: "بريك بالبيض والبطاطا أو اللحم المفروم.",
        kal: 220,
        rating: Rating(stars: 4.4, ratingsNumber: 110),
        options: [
          Option(name: "عادي", price: 1.5),
          Option(name: "بالجبن", price: 2.0),
        ],
        picture: "https://example.com/borek.jpg",
        category: "جزائري",
      ),
      Dish(
        uid: "",
        name: "طاجين زيتون",
        description: "طاجين بالدجاج والزيتون.",
        kal: 380,
        rating: Rating(stars: 4.5, ratingsNumber: 95),
        options: [Option(name: "مع أرز", price: 2.0)],
        picture: "https://example.com/tajine_zitoun.jpg",
        category: "جزائري",
      ),
      Dish(
        uid: "",
        name: "رشـة",
        description: "طعام تقليدي من المعكرونة المحلية - Rechta.",
        kal: 360,
        rating: Rating(stars: 4.2, ratingsNumber: 60),
        options: [Option(name: "مع لحم", price: 3.5)],
        picture: "https://example.com/rechta.jpg",
        category: "جزائري",
      ),
      Dish(
        uid: "",
        name: "محاجب",
        description: "فطائر رقيقة محشوة بالخضر أو باللحم.",
        kal: 270,
        rating: Rating(stars: 4.4, ratingsNumber: 130),
        options: [Option(name: "حار", price: 1.0)],
        picture: "https://example.com/mhadjeb.jpg",
        category: "جزائري",
      ),
      Dish(
        uid: "",
        name: "طاجين البطاطا",
        description: "طاجين بالخضر والبهارات الجزائرية.",
        kal: 320,
        rating: Rating(stars: 4.1, ratingsNumber: 50),
        options: [Option(name: "نباتي", price: 0.0)],
        picture: "https://example.com/tajine_potatoes.jpg",
        category: "جزائري",
      ),
      Dish(
        uid: "",
        name: "بسطيلة بالسمك",
        description: "طبق سمك ملفوف بعجينة مخبوزة.",
        kal: 400,
        rating: Rating(stars: 4.0, ratingsNumber: 40),
        options: [Option(name: "حجم عائلي", price: 8.0)],
        picture: "https://example.com/pastilla_fish.jpg",
        category: "بحري",
      ),
      Dish(
        uid: "",
        name: "كسرة بالزيت",
        description: "خبز تقليدي (كسرة) يقدم مع زيت وزيتون.",
        kal: 150,
        rating: Rating(stars: 4.3, ratingsNumber: 70),
        options: [Option(name: "مع جبن", price: 1.0)],
        picture: "https://example.com/kesra.jpg",
        category: "جزائري",
      ),
    ];
  }

  Future<void> _addTenDishes() async {
    setState(() => _isLoading = true);
    try {
      final dishes = _buildAlgerianDishes();
      await dishService.addMultiple(dishes);

      debugPrint("✅ تمت إضافة ${dishes.length} طبقاً بنجاح");

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ تمت إضافة 10 أطباق جزائرية بنجاح")),
      );
    } catch (e, st) {
      debugPrint("❌ Error while adding dishes: $e\n$st");
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ خطأ أثناء الإضافة: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Algerian Dishes")),
      body: Center(
        child: ElevatedButton.icon(
          icon:
              _isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : const Icon(Icons.add),
          label: Text(_isLoading ? "جاري الإضافة..." : "أضف 10 أطباق جزائرية"),
          onPressed: _isLoading ? null : _addTenDishes,
        ),
      ),
    );
  }
}
