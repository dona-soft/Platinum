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

  factory DailyPlayerReport.fromJson(Map<String, dynamic> json) {
    return DailyPlayerReport(
      date: json['date'],
      loginTime: json['loginTime'],
      logoutTime: json['logoutTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'loginTime': loginTime,
      'logoutTime': logoutTime,
    };
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
