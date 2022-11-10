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
import 'package:platinum/features/person/domain/usecases/get_availabe_offers.dart';
import 'package:platinum/features/person/domain/usecases/get_player_info.dart';
import 'package:platinum/features/person/domain/usecases/get_player_metrics.dart';
import 'package:platinum/features/person/domain/usecases/get_player_subs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Usecases

  sl.registerLazySingleton(() => GetAllPaymentsUsecase(sl()));
  sl.registerLazySingleton(() => GetAllProgramsUsecase(sl()));
  sl.registerLazySingleton(() => GetAllSportsUsecase(sl()));
  sl.registerLazySingleton(() => GetAllTrainersUsecase(sl()));
  sl.registerLazySingleton(() => GetAvailableOffersUsecase(sl()));
  sl.registerLazySingleton(() => GetPlayerInfoUsecase(sl()));
  sl.registerLazySingleton(() => GetPlayerStatusUsecase(sl()));
  sl.registerLazySingleton(() => GetPlayerSubsUsecase(sl()));

  // Provider

  /** 
   * Empty for now maybe implement in the future...
  */

  // Repositiry

  sl.registerLazySingleton<PlayerRepository>(() => PlayerRepositoryImpl(
      localSource: sl(), remoteSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<TrainerRepository>(() => TrainerRepositoryImpl(
      localSource: sl(), remoteSource: sl(), networkInfo: sl()));

  // DataSources

  sl.registerLazySingleton<PlayerRemoteSource>(
      () => PlayerRemoteSourceImpl(sharedPrefs: sl()));
  sl.registerLazySingleton<PlayerLocalSource>(
      () => PlayerLocalSourceImpl(playerDatabase: sl()));

  sl.registerLazySingleton<TrainerRemoteSource>(
      () => TrainerRemoteSourceImpl());
  sl.registerLazySingleton<TrainerLocalSource>(
      () => TrainerLocalSourceImpl(database: sl()));

  // Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External

  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);

  final Database playerdb = await openDatabase(
    await join(await getDatabasesPath(), PLAYER_DATABASE),
    version: 1,
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE IF NOT EXISTS $PLAYER_STATS_TABLE (serial PRIMARY KEY, '
          'FullName TEXT, '
          'Phone TEXT, '
          'SubscribeDate TEXT, '
          'Weight FLOAT, '
          'Height FLOAT, '
          'isSubscribed INTEGER, '
          'isTakenContainer INTEGER, '
          'SubscribeEndDate TEXT, '
          'GenderMale INTEGER, '
          'Balance FLOAT)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS $OFFERS_TABLE (serial PRIMARY KEY, '
          'id INTEGER, '
          'name TEXT, '
          'percent FLOAT, '
          'FullPay INTEGER, '
          'endDate TEXT)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS $SPORTS_TABLE (serial PRIMARY KEY, '
          'id INTEGER, '
          'name Text, '
          'price INTEGER, '
          'daysInWeek INTEGER, '
          'DailyPrice FLOAT, '
          'isActive INTEGER)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS $TRAINERS_TABLE (serial PRIMARY KEY, '
          'id INTEGER, '
          'FullName TEXT, '
          'Phone TEXT, '
          'GenderMale INTEGER)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS $TRAINING_RESOURCE_TABLE (serial PRIMARY KEY, '
          'LastCheck TEXT, '
          'trainer TEXT, '
          'sport TEXT, '
          'rollDate TEXT, '
          'Price INTEGER, '
          'Offer TEXT, '
          'PriceAfterOffer FLOAT)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS $TRAININGS_TABLE (serial PRIMARY KEY, '
          'program_id INTEGER , '
          'training TEXT, '
          'count INTEGER, '
          'rounds INTEGER, '
          'category TEXT)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS $PROGRAMS_TABLE (serial PRIMARY KEY, '
          'program TEXT, '
          'trainingCatagory TEXT , '
          'sport_id INTEGER, '
          'id INTEGER)');

      db.execute(
          'CREATE TABLE IF NOT EXISTS $PAYMENTS_TABLE (serial PRIMARY KEY, '
          'id INTEGER, '
          'PaymentValue FLOAT, '
          'PayDate TEXT, '
          'des TEXT)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS $METRICS_TABLE (serial PRIMARY KEY, '
          'R_Humerus TEXT, '
          'L_Humerus TEXT, '
          'R_Arm TEXT, '
          'L_Arm TEXT, '
          'Shoulders TEXT, '
          'Waist TEXT, '
          'Weight TEXT, '
          'Height TEXT, '
          'Chest TEXT, '
          'Hips TEXT, '
          'Neck TEXT, '
          'R_Thigh TEXT, '
          'L_Thigh TEXT, '
          'R_Leg TEXT, '
          'L_Leg TEXT, '
          'Check_Date TEXT)');
    },
  );

  sl.registerLazySingleton(() => playerdb);
  sl.registerLazySingleton(() => http.Client);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
