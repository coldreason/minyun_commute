import 'package:intl/intl.dart';

class Constants {
  static const chatPerUser = 'userChat';
  static const chatRoomInfo = "chatRoomInfo";
  static const chats = "chats";
}

class FirebaseConstants{
  static const user = "user";
  static const commute = "commute";
  static const plan = "plan";

  static const id =  "id";
  static const password = "password";
  static const admin = "admin";
  static const name = "name";
  static const position = "position";
  static const department = "department";

  static const comeAt = "comeAt";
  static const endAt = "endAt";
  static const comment = "comment";

  static const unit = "unit";
}

enum UserScreenType{
  mobile,tablet,pcWeb
}

final List<String> planTimesH = [
  "06",
  "07",
  "08",
  "09",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22"
];
final List<String> planTimesM = [
  "00",
  "10",
  "20",
  "30",
  "40",
  "50",
];

final planUnitList = [
  "1",
  "1.5",
  "2",
];

NumberFormat formatter = NumberFormat("00");