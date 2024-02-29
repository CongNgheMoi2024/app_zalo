class AccountTypeChoice {
  static const String base = 'base';
  static const String plus = 'plus';
  static const String vip = 'vip';
  static const String vvip = 'vvip';

  static String getAccountTypeString(String accountType) {
    switch (accountType) {
      case AccountTypeChoice.base:
        return 'Tài khoản tiêu chuẩn';
      case AccountTypeChoice.plus:
        return 'Tài khoản Plus';
      case AccountTypeChoice.vip:
        return 'Tài khoản VIP';
      case AccountTypeChoice.vvip:
        return 'Tài khoản VVIP';
      default:
        return 'Tài khoản tiêu chuẩn';
    }
  }
}

class Constant {
  static const int defaultPoint = 0;
}

class AccountTypeChoiceHome {
  static const String base = 'base';
  static const String plus = 'plus';
  static const String vip = 'vip';
  static const String vvip = 'vvip';

  static String getAccountTypeString(String accountType) {
    switch (accountType) {
      case AccountTypeChoice.base:
        return 'Thường';
      case AccountTypeChoice.plus:
        return 'Plus';
      case AccountTypeChoice.vip:
        return 'VIP';
      case AccountTypeChoice.vvip:
        return 'V VIP';
      default:
        return 'Tài khoản tiêu chuẩn';
    }
  }
}

class BiddingStatus {
  static const String waiting = 'waiting';
  static const String success = 'success';
  static const String fail = 'fail';

  static String getBiddingStatusString(String biddingStatus) {
    final map = {
      BiddingStatus.waiting: 'Đang chờ',
      BiddingStatus.success: 'Thành công',
      BiddingStatus.fail: 'Thất bại',
    };
    return map[biddingStatus] ?? 'Đang chờ';
  }
}
