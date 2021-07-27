import 'dart:convert';

class TransationModel {
  String chequeNumber;
  String staffName;
  String managerName;
  String businessUnit;
  String date;
  TransationModel({
    required this.chequeNumber,
    required this.staffName,
    required this.managerName,
    required this.businessUnit,
    required this.date,
  });

  TransationModel copyWith({
    String? chequeNumber,
    String? staffName,
    String? managerName,
    String? businessUnit,
    String? date,
  }) {
    return TransationModel(
      chequeNumber: chequeNumber ?? this.chequeNumber,
      staffName: staffName ?? this.staffName,
      managerName: managerName ?? this.managerName,
      businessUnit: businessUnit ?? this.businessUnit,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chequeNumber': chequeNumber,
      'staffName': staffName,
      'managerName': managerName,
      'businessUnit': businessUnit,
      'date': date,
    };
  }

  factory TransationModel.fromMap(Map<String, dynamic> map) {
    return TransationModel(
      chequeNumber: map['chequeNumber'],
      staffName: map['staffName'],
      managerName: map['managerName'],
      businessUnit: map['businessUnit'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransationModel.fromJson(String source) =>
      TransationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransationModel(chequeNumber: $chequeNumber, staffName: $staffName, managerName: $managerName, businessUnit: $businessUnit, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransationModel &&
        other.chequeNumber == chequeNumber &&
        other.staffName == staffName &&
        other.managerName == managerName &&
        other.businessUnit == businessUnit &&
        other.date == date;
  }

  @override
  int get hashCode {
    return chequeNumber.hashCode ^
        staffName.hashCode ^
        managerName.hashCode ^
        businessUnit.hashCode ^
        date.hashCode;
  }
}
