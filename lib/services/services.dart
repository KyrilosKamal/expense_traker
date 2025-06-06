import 'package:hive/hive.dart';
import '../models/expenses_model.dart';
import '../models/user_data_model.dart';

class ExpenseRepository {
  final Box<Expenses> expenseBox = Hive.box<Expenses>('expenses');
  final Box<UserData> userBox = Hive.box<UserData>('user');

  ExpenseRepository() {
    _initializeUserData();
  }

  /// Initializes default user data if not present.
  void _initializeUserData() {
    if (!userBox.containsKey('info')) {
      userBox.put('info', UserData(monthlyIncome: 0, remainingBalance: 0));
    }
  }

  /// Returns all saved expenses.
  List<Expenses> getAllExpenses() => expenseBox.values.toList();

  /// Retrieves the current user data.
  UserData getUserData() {
    final user = userBox.get('info');
    if (user == null) {
      final newUser = UserData(monthlyIncome: 0, remainingBalance: 0);
      userBox.put('info', newUser);
      return userBox.get('info')!; // نرجع النسخة المرتبطة بالـ Box
    }
    return user;
  }

  /// Adds a new expense and updates remaining balance.
  void addExpense(Expenses expense) {
    expenseBox.add(expense);
    final user = getUserData();
    user.remainingBalance -= expense.money;
    user.save();
  }

  /// Deletes an expense and restores its amount to the remaining balance.
  void deleteExpense(int index, Expenses expense) {
    if (index >= 0 && index < expenseBox.length) {
      expenseBox.deleteAt(index);
      final user = getUserData();
      user.remainingBalance += expense.money;
      user.save();
    }
  }

  /// Clears all data (expenses and user info), and re-initializes user data.
  void resetAll() {
    expenseBox.clear();
    userBox.clear();
    _initializeUserData();
  }

  /// Sets monthly income and updates remaining balance accordingly.
  void setMonthlyIncome(double income) {
    final user = getUserData();
    user.monthlyIncome = income;
    user.remainingBalance = income;
    user.save();
  }
}
