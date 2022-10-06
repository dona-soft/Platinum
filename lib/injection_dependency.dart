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
import 'package:sqflite/sqflite.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Usecases

  sl.registerLazySingleton(() => GetAllPaymentsUsecase(sl()));
  sl.registerLazySingleton(() => GetAllProgramsUsecase(sl()));
  sl.registerLazySingleton(() => GetAllSportsUsecase(sl()));
  sl.registerLazySingleton(() => GetAllTrainersUsecase(sl()));
  sl.registerLazySingleton(() => GetAvailableOffersUsecase(sl()));

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
    await join(await getDatabasesPath(), PLAYER_DATABASE),
    version: 1,
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE IF NOT EXISTS $PLAYER_STATS_TABLE (id PRIMARY KEY)');
      db.execute('CREATE TABLE IF NOT EXISTS $OFFERS_TABLE '
          '(id PRIMARY KEY, '
          'name TEXT, '
          'percent FLOAT, '
          'endDate DATE)');
      db.execute('CREATE TABLE IF NOT EXISTS $SPORTS_TABLE (id PRIMARY KEY, '
          'name Text, '
          'price INTEGER, '
          'daysInWeek INTEGER, '
          'dailyPrice FLOAT, '
          'isActive BOOL)');
      db.execute('CREATE TABLE IF NOT EXISTS $TRAINERS_TABLE (id PRIMARY KEY, '
          'fullName TEXT, '
          'phoneNum TEXT, '
          'genderMale BOOL)');
      db.execute('CREATE TABLE IF NOT EXISTS $TRAININGS_TABLE (id PRIMARY KEY, '
          'apiKey INTEGER , '
          'name TEXT, '
          'muscle TEXT, '
          'counter INTEGER, '
          'rounds INTEGER, '
          'catagory TEXT'
          'isTimer BOOL)');
      db.execute('CREATE TABLE IF NOT EXISTS $PROGRAMS_TABLE (id PTIMARY KEY, '
          'trainingCatagory TEXT , '
          'trainsApiIds TEXT)');
      db.execute('CREATE TABLE IF NOT EXISTS $PAYMENTS_TABLE (id PRIMARY KEY, '
          'paymentValue FLOAT, '
          'payDate DATE, '
          'description TEXT)');
    },
  );

  sl.registerLazySingleton(() => playerdb);
  sl.registerLazySingleton(() => http.Client);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
