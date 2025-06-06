// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpensesAdapter extends TypeAdapter<Expenses> {
  @override
  final int typeId = 1;

  @override
  Expenses read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expenses(
      title: fields[0] as String,
      money: fields[1] as double,
      date: fields[2] as DateTime,
      category: fields[3] as ExpenseType,
      notes: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Expenses obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.money)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpensesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExpenseTypeAdapter extends TypeAdapter<ExpenseType> {
  @override
  final int typeId = 2;

  @override
  ExpenseType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExpenseType.Food;
      case 1:
        return ExpenseType.Transport;
      case 2:
        return ExpenseType.Shopping;
      case 3:
        return ExpenseType.Bills;
      case 4:
        return ExpenseType.Other;
      default:
        return ExpenseType.Food;
    }
  }

  @override
  void write(BinaryWriter writer, ExpenseType obj) {
    switch (obj) {
      case ExpenseType.Food:
        writer.writeByte(0);
        break;
      case ExpenseType.Transport:
        writer.writeByte(1);
        break;
      case ExpenseType.Shopping:
        writer.writeByte(2);
        break;
      case ExpenseType.Bills:
        writer.writeByte(3);
        break;
      case ExpenseType.Other:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
