class FirebaseConstants {
  static const users = "users";
  static const commutes = "commutes";
  static const plans = "plans";

  static const id = "id";
  static const password = "password";
  static const admin = "admin";
  static const name = "name";
  static const position = "position";
  static const department = "department";

  static const comeAt = "comeAt";
  static const endAt = "endAt";
  static const comment = "comment";
  static const workAtLunch = "workAtLunch";

  static const unit = "unit";
}

enum UserScreenType { mobile, tablet, pcWeb }

enum AuthType {root, user, viewer}

enum CommuteStatus { dataNotExist, goExist, endExist }
const List<String> planTimesH = [
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
const List<String> planTimesM = [
  "00",
  "05",
  "10",
  "15",
  "20",
  "25",
  "30",
  "35",
  "40",
  "45",
  "50",
  "55",
];

const planUnitList = [
  "1",
  "1.5",
  "2",
];
