import 'package:hive/hive.dart';
part 'expenses_model.g.dart';

@HiveType(typeId: 2)
enum ExpenseType {
  @HiveField(0)
  Food,
  @HiveField(1)
  Transport,
  @HiveField(2)
  Shopping,
  @HiveField(3)
  Bills,
  @HiveField(4)
  Other,
}

@HiveType(typeId: 1)
class Expenses extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  double money;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  ExpenseType category;

  @HiveField(4)
  String? notes;

  Expenses({
    required this.title,
    required this.money,
    required this.date,
    required this.category,
    this.notes,
  });
}
