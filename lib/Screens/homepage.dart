import 'package:expense_traker/Screens/charts_screen.dart';
import 'package:expense_traker/models/expenses_model.dart';
import 'package:expense_traker/models/user_data_model.dart';
import 'package:expense_traker/services/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final ExpenseRepository expenseRepo;

  const HomePage({super.key, required this.expenseRepo});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum FilterOption { all, today, week, month }

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _moneyController = TextEditingController();
  final _incomeController = TextEditingController();
  final _notesController = TextEditingController();
  ExpenseType _selectedCategory = ExpenseType.Other;
  FilterOption _selectedFilter = FilterOption.all;

  String _searchQuery = '';  // متغير بحث

  @override
  Widget build(BuildContext context) {
    List<Expenses> allExpenses = widget.expenseRepo.getAllExpenses();
    UserData user = widget.expenseRepo.getUserData();

    // تطبيق الفلترة والبحث معًا
    List<Expenses> filteredExpenses = _applyFilter(allExpenses);

    // حساب إجمالي المصروفات للفلترة الحالية
    double totalExpenses = filteredExpenses.fold(0, (sum, e) => sum + e.money);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.pie_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ExpensesChartScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset All',
            onPressed: () {
              widget.expenseRepo.resetAll();
              setState(() {
                _searchQuery = '';
                _selectedFilter = FilterOption.all;
              });
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSummaryCard(user, totalExpenses),
                  const SizedBox(height: 20),
                  _buildAddExpenseForm(),
                  const SizedBox(height: 20),
                  _buildFilterChips(),
                  const SizedBox(height: 10),
                  _buildSearchField(),
                  const SizedBox(height: 10),
                  _buildExpensesList(filteredExpenses),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(UserData user, double totalExpenses) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: Colors.teal.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Monthly Income: ${user.monthlyIncome.toStringAsFixed(2)} ُEGP",
              style: TextStyle(color: Colors.teal.shade900),
            ),
            const SizedBox(height: 8),
            Text(
              "Remaining Balance: ${user.remainingBalance.toStringAsFixed(2)} ُEGP",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 8),
            Text(
              "Total Expenses (${_selectedFilter.name.toUpperCase()}): ${totalExpenses.toStringAsFixed(2)} ُEGP",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _showIncomeDialog(user),
              child: const Text("Edit Income"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddExpenseForm() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Add Expense",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (val) =>
                val == null || val.isEmpty ? 'Enter title' : null,
              ),
              TextFormField(
                controller: _moneyController,
                decoration: const InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || double.tryParse(val) == null
                    ? 'Enter valid amount'
                    : null,
              ),
              DropdownButtonFormField<ExpenseType>(
                value: _selectedCategory,
                items: ExpenseType.values
                    .map(
                      (cat) =>
                      DropdownMenuItem(value: cat, child: Text(cat.name)),
                )
                    .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
                decoration: const InputDecoration(labelText: "Category"),
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: "Notes (optional)",
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitExpense,
                child: const Text("Add"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Wrap(
      spacing: 10,
      children: FilterOption.values.map((option) {
        return ChoiceChip(
          label: Text(option.name.toUpperCase()),
          selected: _selectedFilter == option,
          onSelected: (_) => setState(() => _selectedFilter = option),
          selectedColor: Colors.teal,
          labelStyle: TextStyle(color: _selectedFilter == option ? Colors.white : Colors.black),
        );
      }).toList(),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Search Expenses',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
      onChanged: (val) {
        setState(() {
          _searchQuery = val.toLowerCase();
        });
      },
    );
  }

  Widget _buildExpensesList(List<Expenses> expenses) {
    if (expenses.isEmpty) {
      return const Center(child: Text("No expenses found."));
    }

    return ListView.builder(
      itemCount: expenses.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        final e = expenses[i];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            title: Text("${e.title} - ${e.money.toStringAsFixed(2)} ُEGP"),
            subtitle: Text(
              "${e.category.name} | ${DateFormat('dd/MM/yyyy').format(e.date)}\n${e.notes ?? ''}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.expenseRepo.deleteExpense(i, e);
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  }

  void _submitExpense() {
    if (_formKey.currentState!.validate()) {
      final e = Expenses(
        title: _titleController.text,
        money: double.parse(_moneyController.text),
        date: DateTime.now(),
        category: _selectedCategory,
        notes: _notesController.text,
      );
      widget.expenseRepo.addExpense(e);

      _titleController.clear();
      _moneyController.clear();
      _notesController.clear();
      setState(() {});
    }
  }

  List<Expenses> _applyFilter(List<Expenses> all) {
    DateTime now = DateTime.now();

    return all.where((e) {
      bool matchesFilter;
      switch (_selectedFilter) {
        case FilterOption.today:
          matchesFilter = e.date.year == now.year &&
              e.date.month == now.month &&
              e.date.day == now.day;
          break;
        case FilterOption.week:
          final diff = now.difference(e.date).inDays;
          matchesFilter = diff <= 7;
          break;
        case FilterOption.month:
          matchesFilter = e.date.year == now.year && e.date.month == now.month;
          break;
        case FilterOption.all:
          matchesFilter = true;
          break;
      }
      // تحقق من نص البحث في العنوان أو الملاحظات أو اسم التصنيف
      bool matchesSearch = _searchQuery.isEmpty ||
          e.title.toLowerCase().contains(_searchQuery) ||
          (e.notes?.toLowerCase().contains(_searchQuery) ?? false) ||
          e.category.name.toLowerCase().contains(_searchQuery);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  void _showIncomeDialog(UserData user) {
    _incomeController.text = user.monthlyIncome.toStringAsFixed(2);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Set Monthly Income"),
        content: TextFormField(
          controller: _incomeController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Income"),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Save"),
            onPressed: () {
              final value = double.tryParse(_incomeController.text);
              if (value != null) {
                widget.expenseRepo.setMonthlyIncome(value);
                setState(() {});
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
