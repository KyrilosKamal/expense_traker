import 'package:expense_traker/Screens/homepage.dart';
import 'package:expense_traker/models/expenses_model.dart';
import 'package:expense_traker/models/user_data_model.dart';
import 'package:expense_traker/services/services.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Define appTheme if not already defined in theme.dart
// Define appTheme with vibrant colors
final ThemeData appTheme = ThemeData(
  primaryColor: Colors.teal, // لون رئيسي مبهج
  hintColor: Colors.orange, // لون ثانوي
  scaffoldBackgroundColor: Colors.white, // خلفية بيضاء
  brightness: Brightness.light,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black54),
  ),
);


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ExpenseTypeAdapter());
  Hive.registerAdapter(ExpensesAdapter());
  Hive.registerAdapter(UserDataAdapter());

  await Hive.openBox<Expenses>('expenses');
  await Hive.openBox<UserData>('user');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ExpenseRepository expenseRepo = ExpenseRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(), // ثيم داكن
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: HomePage(expenseRepo: expenseRepo),
    );
  }
}

