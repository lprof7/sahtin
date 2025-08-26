# food_app

تطبيق Flutter يعتمد على معمارية MVVM مع فصل واضح للمهام والوظائف.

## هيكل المجلدات

```
lib/
├── core/
│   ├── routing/
│   ├── errors/
│   ├── dependency_injection/
│   └── responses/
├── data/
│   ├── services/
│   ├── repositories/
│   ├── models/
│   └── data_transfer_objects/
└── presentation/
    ├── shared/
    └── features/
```

### شرح المجلدات:
- **core/**: أدوات أساسية مشتركة (توجيه، أخطاء، حقن تبعيات، استجابات).
- **data/**: كل ما يتعلق بجلب ومعالجة وتخزين البيانات (خدمات، مستودعات، نماذج، DTOs).
- **presentation/**: واجهات المستخدم وإدارة الحالة (عناصر مشتركة وميزات منفصلة).

---

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
