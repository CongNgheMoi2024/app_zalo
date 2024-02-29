class Regex {
  static bool _hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static bool isPhone(String s) => _hasMatch(
      s, r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');

  static bool email(String s) => _hasMatch(s,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static bool fullName(String s) => _hasMatch(s,
      r"^^[a-zA-ZàáảãạÀÁẢÃẠăằắẳẵặĂẰẮẲẴẶâầấẩẫậÂẦẤẨẪẬèéẻẽẹÈÉẺẼẸêềếểễệỀẾÊỂỄỆìíỉĩịÌÍỈĨỊòóỏõọÒÓỎÕỌôồốổỗộÔỒỐỔỖỘơờớởỡợƠỜỚỞỠỢùúủũụÙÚỦŨỤưừứửữựƯỪỨỬỮỰỳýỷỹỵỲÝỶỸỴđĐ]+(\s+[a-zA-ZàáảãạÀÁẢÃẠăằắẳẵặĂẰẮẲẴẶâầấẩẫậÂẦẤẨẪẬèéẻẽẹÈÉẺẼẸêềếểễệỀẾÊỂỄỆìíỉĩịÌÍỈĨỊòóỏõọÒÓỎÕỌôồốổỗộÔỒỐỔỖỘơờớởỡợƠỜỚỞỠỢùúủũụÙÚỦŨỤưừứửữựƯỪỨỬỮỰỳýỷỹỵỲÝỶỸỴđĐ]+)*$");
  // static bool isPassword(String password) {
  //   final regex = RegExp(r'^.{8,}$');
  //   return regex.hasMatch(password);
  // }

  static bool password(String s) => _hasMatch(s,
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*])[A-Za-z\d!@#\$%^&*]{6,}$");

  static bool phone(String s) =>
      _hasMatch(s, r"^((0)([1-9])+([0-9]{8})\b)|((\+84))([1-9])+([0-9]{8})\b");

  static bool number(String s) => _hasMatch(s, r"^[0-9]");

  static bool code(String s) => _hasMatch(s, r"^[0-9]{5,6}");

  static RegExp get unsignedRegExp => RegExp(
      r'đụ|má|đĩ|đù|mé|đỉ|lồn|cặc|lol|ngu|phò|mia|đéo|địt|đít|cứt|nứng|buồi|điếm|fuck|shit|chịch|mịa|sex|mông|ngực|cu|chim|trym|nude|chó');

  static RegExp get specialCharacters =>
      RegExp("[!#@)(:;√™®©°₫•¥><\$€¢£℅π÷×¶%∆&'*+/,=?^_.`[\\]{|\"}~-]");
}
