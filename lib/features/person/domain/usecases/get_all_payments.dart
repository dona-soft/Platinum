import 'package:dartz/dartz.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/features/person/domain/entities/player/aux/player_payment.dart';
import 'package:platinum/features/person/domain/repository/repository.dart';

class GetAllPaymentsUsecase {
  final PlayerRepository repository;
  const GetAllPaymentsUsecase(this.repository);

  Future<Either<Failure, List<PlayerPayment>>> call() async {
    return await repository.getAllPayments();
  }
}
