import 'package:dartz/dartz_streaming.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/widgets.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/core/samples/offer.dart';
import 'package:platinum/features/person/domain/usecases/get_availabe_offers.dart';
import 'package:platinum/features/person/presentation/state_manegment/state/offers_state.dart';
import 'package:provider/provider.dart';

class OffersProvider {
  List<Offer>? offers;
  final GetAvailableOffersUsecase usecase;
  OffersProvider(this.usecase) {}

  Future<OffersState> getOffers() async {
    final state = await usecase();
    return state.fold(
      (l) => ErrorOffersState(messege: maprFailureToMessege(l)),
      (r) => LoadedOffersState(offers: r),
    );
  }

  String maprFailureToMessege(Failure messege) {
    switch (messege.runtimeType) {
      case Failure:
        return 'fuck you!!!';
      default:
        return '';
    }
  }
}

class OffersScreen extends StatefulWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
