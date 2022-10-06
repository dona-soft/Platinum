import 'package:equatable/equatable.dart';
import 'package:platinum/core/samples/offer.dart';

abstract class OffersState extends Equatable {
  const OffersState();

  @override
  List<Object> get props => [];
}

class LoadingOffersState extends OffersState {}

class LoadedOffersState extends OffersState {
  final List<Offer> offers;

  const LoadedOffersState({required this.offers});

  @override
  List<Object> get props => [offers];
}

class ErrorOffersState extends OffersState {
  final String messege;

  ErrorOffersState({required this.messege});

  @override
  List<Object> get props => [messege];
}
