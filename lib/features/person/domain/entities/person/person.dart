import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final int? id;
  final String fullName, phoneNum;
  final bool genderMale;

  const Person({
    required this.id,
    required this.fullName,
    required this.phoneNum,
    required this.genderMale,
  });

  @override
  List<Object?> get props => [id, fullName, phoneNum];
}
