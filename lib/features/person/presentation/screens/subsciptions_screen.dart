import 'package:flutter/material.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/core/errors/exceptions.dart';
import 'package:platinum/core/errors/failures.dart';
import 'package:platinum/core/samples/player_training.dart';
import 'package:platinum/core/themes/main_theme.dart';
import 'package:platinum/features/person/domain/usecases/get_player_subs.dart';
import 'package:platinum/features/person/presentation/widgets/loading_error.dart';
import 'package:platinum/features/person/presentation/widgets/subs_screen/subs_list_item.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({
    Key? key,
    required this.subsUsecase,
  }) : super(key: key);

  final GetPlayerSubsUsecase subsUsecase;

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  Future<List<PlayerTraining>> loadSubs() async {
    List<PlayerTraining> playerTraining = [];
    final either = await widget.subsUsecase();
    either.fold(
      (fail) {
        throw GlobalException(message: mapFailureToMessege(fail));
      },
      (r) {
        playerTraining = r;
      },
    );
    return playerTraining;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الاشتراكات السابقة'),
        backgroundColor: LightTheme.primaryColorLight,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<PlayerTraining>>(
          future: loadSubs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return SubsListItem(playerTraining: snapshot.data![index]);
                },
              );
            } else if (snapshot.hasError) {
              final str = (snapshot.error as GlobalException).message;
              return LoadingErrorWidget(
                message: str,
                reload: () => setState(() {}),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
