import 'package:hive/hive.dart';
import '../models/user_data_model.dart';
import '../models/expenses_model.dart';

void registerAdapters() {
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(UserDataAdapter());
  }

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(ExpensesAdapter());
  }

  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(ExpenseTypeAdapter());
  }
}
