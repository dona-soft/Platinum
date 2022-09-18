import 'package:equatable/equatable.dart';

class DailyPlayerReport extends Equatable {
  final int? id;
  final DateTime date, loginTime, logoutTime;

  const DailyPlayerReport({
    this.id,
    required this.date,
    required this.loginTime,
    required this.logoutTime,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
