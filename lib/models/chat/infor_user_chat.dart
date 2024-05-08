class InforUserChat {
  String idUserRecipient;
  String name;
  String avatar;
  String timeActive;
  bool sex;
  bool? isGroup;
  String? idGroup;
  String? nameGroup;
  List<String> members = [];
  String? idAdmin;
  InforUserChat(
      {required this.idUserRecipient,
      required this.name,
      required this.avatar,
      required this.timeActive,
      required this.sex,
      this.isGroup,
      this.idGroup,
      this.nameGroup,
      required this.members,
      this.idAdmin});
}
