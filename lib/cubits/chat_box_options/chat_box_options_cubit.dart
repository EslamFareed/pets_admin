import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_box_options_state.dart';

class ChatBoxOptionsCubit extends Cubit<ChatBoxOptionsState> {
  ChatBoxOptionsCubit() : super(ChatBoxOptionsInitial());
}
