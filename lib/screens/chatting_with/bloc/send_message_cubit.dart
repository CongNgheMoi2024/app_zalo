import 'package:app_zalo/screens/chatting_with/bloc/send_message_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMessageCubit extends Cubit<SendMessageState>{
  SendMessageCubit() : super(DefaultSendMessageState()); 
  void replyMessage(String nameReply,String contentMessRep, String typeMessRep,String fileName,String idMessageReply){
    emit(ReplySendMessageState(nameReply, contentMessRep, typeMessRep, fileName, idMessageReply));
  }
  void defaultState(){
    emit(DefaultSendMessageState());
  }
}