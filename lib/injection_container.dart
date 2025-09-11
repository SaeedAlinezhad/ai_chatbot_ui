
import 'package:get_it/get_it.dart';
import 'package:orbix_chat/features/home/data/datasources/chat_remote_datasource.dart';
import 'package:orbix_chat/features/home/domain/repositories/chat_repository.dart';
import 'package:orbix_chat/features/home/domain/repositories/chat_repository_impl.dart';
import 'package:orbix_chat/features/home/domain/usecases/send_message_usecase.dart';
import 'package:orbix_chat/features/home/presentation/bloc/home_bloc.dart';
import 'package:orbix_chat/features/voice_input/data/repositories/speech_repository.dart';
import 'package:orbix_chat/features/voice_input/domain/usecases/listen_to_speech.dart';
import 'package:orbix_chat/features/voice_input/presentation/cubit/voice_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // DataSource
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<SpeechRepository>(
    () => SpeechRepositoryImpl(),
  );
  // UseCase
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));
  sl.registerLazySingleton(() => ListenToSpeechUseCase(sl()));

  // Bloc
  sl.registerFactory(() => HomeBloc(sendMessageUseCase: sl()));
  sl.registerFactory(() => VoiceCubit(sl()));
}
