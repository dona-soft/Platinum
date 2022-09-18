import 'package:dartz/dartz.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/core/samples/offer.dart';
import 'package:platinum/features/person/domain/repository/repository.dart';

class GetAvailableOffersUsecase {
  final PlayerRepository repository;
  const GetAvailableOffersUsecase(this.repository);

  Future<Either<Failure, List<Offer>>> call() async {
    return await repository.getAvailableOffers();
  }
}
