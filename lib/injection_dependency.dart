import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path/path.dart';
import 'package:platinum/core/connection/network_info.dart';
import 'package:platinum/core/constants/strings.dart';
import 'package:platinum/features/person/data/repository/player_repository_impl.dart';
import 'package:platinum/features/person/data/repository/trainer_repository_impl.dart';
import 'package:platinum/features/person/data/sources/player_local_source.dart';
import 'package:platinum/features/person/data/sources/player_remote_source.dart';
import 'package:platinum/features/person/data/sources/trainer_local_source.dart';
import 'package:platinum/features/person/data/sources/trainer_remote_source.dart';
import 'package:platinum/features/person/domain/repository/repository.dart';
import 'package:platinum/features/person/domain/usecases/get_all_payments.dart';
import 'package:platinum/features/person/domain/usecases/get_all_programs.dart';
import 'package:platinum/features/person/domain/usecases/get_all_sports.dart';
import 'package:platinum/features/person/domain/usecases/get_all_trainers.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Usecases

  sl.registerLazySingleton(() => GetAllPaymentsUsecase(sl()));
  sl.registerLazySingleton(() => GetAllProgramsUsecase(sl()));
  sl.registerLazySingleton(() => GetAllSportsUsecase(sl()));
  sl.registerLazySingleton(() => GetAllTrainersUsecase(sl()));

  // Repositiry

  sl.registerLazySingleton<PlayerRepository>(() => PlayerRepositoryImpl(
      localSource: sl(), remoteSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<TrainerRepository>(() => TrainerRepositoryImpl(
      localSource: sl(), remoteSource: sl(), networkInfo: sl()));

  // DataSources

  sl.registerLazySingleton<PlayerRemoteSource>(() => PlayerRemoteSourceImpl());
  sl.registerLazySingleton<PlayerLocalSource>(
      () => PlayerLocalSourceImpl(playerDatabase: sl()));

  sl.registerLazySingleton<TrainerRemoteSource>(
      () => TrainerRemoteSourceImpl());
  sl.registerLazySingleton<TrainerLocalSource>(
      () => TrainerLocalSourceImpl(database: sl()));

  // Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External

  final Database playerdb = await openDatabase(
    join(await getDatabasesPath(), PLAYER_DATABASE),
    onCreate: (db, version) {
      db.execute('CREATE TABLE IF NOT EXISTS $PLAYER_TABLE (id PRIMARY KEY)');
      db.execute('CREATE TABLE IF NOT EXISTS $OFFERS_TABLE (id PRIMARY KEY)');
      db.execute('CREATE TABLE IF NOT EXISTS $SPORTS_TABLE (id PRIMARY KEY)');
      db.execute('CREATE TABLE IF NOT EXISTS $TRAINERS_TABLE (id PRIMARY KEY)');
      db.execute('CREATE TABLE IF NOT EXISTS $PROGRAMS_TABLE (id PRIMARY KEY)');
      db.execute('CREATE TABLE IF NOT EXISTS $PAYMENTS_TABLE (id PRIMARY KEY)');
    },
  );
  sl.registerFactory(() => playerdb);

  sl.registerLazySingleton(() => http.Client);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
