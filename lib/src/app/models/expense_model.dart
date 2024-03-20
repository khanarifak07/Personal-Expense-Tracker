// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Expense {
  final int amount;
  final DateTime date;
  final String description;
  Expense({
    required this.amount,
    required this.date,
    required this.description,
  });

  Expense copyWith({
    int? amount,
    DateTime? date,
    String? description,
  }) {
    return Expense(
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
      'description': description,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      amount: map['amount'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Expense(amount: $amount, date: $date, description: $description)';

  @override
  bool operator ==(covariant Expense other) {
    if (identical(this, other)) return true;

    return other.amount == amount &&
        other.date == date &&
        other.description == description;
  }

  @override
  int get hashCode => amount.hashCode ^ date.hashCode ^ description.hashCode;
}
