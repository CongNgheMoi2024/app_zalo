abstract class SendMessageState  {
}
class DefaultSendMessageState extends SendMessageState{
}
class ReplySendMessageState extends SendMessageState {
   String? nameReply;
   String? contentMessRep;
   String? typeMessRep;
   String? fileName;
   String? idMessageReply;
  
  ReplySendMessageState( this.nameReply, this.contentMessRep, this.typeMessRep, this.fileName, this.idMessageReply);
}