# Categories Feature - Quick Reference Card

## 🚀 30-Second Integration

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_finder_app/core/di/dependency_injection.dart';
import 'package:pet_finder_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:pet_finder_app/features/home/presentation/widgets/categories_widget.dart';

// Wrap your screen
BlocProvider(
  create: (context) => getIt<HomeCubit>()..getCategories(),
  child: YourScreen(),
)

// Add the widget anywhere
CategoriesWidget(
  onCategorySelected: (category) {
    // Handle selection
  },
)
```

## 📦 What You Get

| Component                  | Location                | Purpose                   |
| -------------------------- | ----------------------- | ------------------------- |
| `CategoryModel`            | `data/models/`          | Data structure (id, name) |
| `CategoryRemoteDataSource` | `data/datasources/`     | API calls                 |
| `CategoryRepository`       | `data/repositories/`    | Data management           |
| `HomeCubit`                | `presentation/cubit/`   | Business logic            |
| `CategoriesWidget`         | `presentation/widgets/` | Reusable UI               |
| `CategoriesExampleScreen`  | `presentation/pages/`   | Full example              |

## 🎯 API Details

```
Endpoint: {{endpoint}}v1/categories
Method:   GET
Response: [{"id": 5, "name": "boxes"}, ...]
```

## 📊 States

```dart
CategoriesLoading        // Show spinner
CategoriesLoaded         // state.categories (List<CategoryModel>)
CategoriesError          // state.message (String)
```

## 💡 Common Tasks

### Get Categories

```dart
context.read<HomeCubit>().getCategories();
```

### Handle State

```dart
BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    if (state is CategoriesLoaded) {
      return Text('${state.categories.length} categories');
    }
    return SizedBox.shrink();
  },
)
```

### Access Category Data

```dart
onCategorySelected: (category) {
  print(category.id);     // int
  print(category.name);   // String
}
```

## 🔧 Dependency Injection

Already configured in `dependency_injection.dart`:

- ✅ `CategoryRemoteDataSource`
- ✅ `CategoryRepository`
- ✅ `HomeCubit`

Just use: `getIt<HomeCubit>()`

## ⚡ Quick Examples

### Example 1: Basic List

```dart
BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    if (state is CategoriesLoaded) {
      return ListView(
        children: state.categories.map((cat) =>
          ListTile(title: Text(cat.name))
        ).toList(),
      );
    }
    return CircularProgressIndicator();
  },
)
```

### Example 2: Horizontal Chips

```dart
CategoriesWidget(
  selectedCategoryName: selectedCategory,
  onCategorySelected: (category) {
    setState(() => selectedCategory = category.name);
  },
)
```

### Example 3: Grid View

```dart
if (state is CategoriesLoaded) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    itemCount: state.categories.length,
    itemBuilder: (context, index) {
      final cat = state.categories[index];
      return Card(child: Center(child: Text(cat.name)));
    },
  );
}
```

## 🐛 Troubleshooting

| Issue                  | Solution                                                       |
| ---------------------- | -------------------------------------------------------------- |
| Categories not loading | Check if `setupDependencyInjection()` is called in `main.dart` |
| State not updating     | Wrap screen with `BlocProvider`                                |
| Endpoint error         | Verify `{{endpoint}}` is configured in `end_points.dart`       |
| Type error             | Import `category_model.dart`                                   |

## 📱 Integration Checklist

- [ ] Dependency injection setup in `main.dart`
- [ ] Wrap screen with `BlocProvider`
- [ ] Call `getCategories()` on cubit creation
- [ ] Handle all three states (Loading, Loaded, Error)
- [ ] Test with and without internet

## 🎨 UI Components Available

1. **CategoriesWidget** - Ready-to-use horizontal scrolling chips
2. **CategoriesExampleScreen** - Full screen with error handling
3. **Custom BlocBuilder** - Build your own UI

## ⚙️ Configuration

No configuration needed! Everything is set up in:

- ✅ `dependency_injection.dart` - DI setup
- ✅ `end_points.dart` - API endpoint

## 📚 Documentation

- `CATEGORIES_USAGE.md` - Detailed guide
- `IMPLEMENTATION_SUMMARY.md` - Overview
- `FILE_STRUCTURE.txt` - File organization
- `QUICK_REFERENCE.md` - This file

## 🎯 Architecture

```
UI Widget → HomeCubit → Repository → DataSource → API
```

Simple, clean, and maintainable!

---

**Need help?** Check `CATEGORIES_USAGE.md` for detailed examples.
