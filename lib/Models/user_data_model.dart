import 'package:hive/hive.dart';
part 'user_data_model.g.dart';

@HiveType(typeId: 3)
class UserData extends HiveObject {
  @HiveField(0)
  double monthlyIncome;

  @HiveField(1)
  double remainingBalance;

  UserData({required this.monthlyIncome, required this.remainingBalance});
}
