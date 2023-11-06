enum AccountTypeEnum {
  user,
  memorizer,
}

enum AccountTypeState {
  saved,
  unActive,
  pending,
  accepted,
  refused,
}

class AccountTypeDescription {
  final String title;
  final String content;
  String id = "";
  final AccountTypeEnum type;
  List<AccountTypeCondition> conditions = [];
  AccountTypeDescription({
    required this.title,
    required this.type,
    required this.content,
    this.conditions = const [],
  });
}

class AccountTypeCondition {
  final String title;
  final String content;

  AccountTypeCondition({
    required this.content,
    required this.title,
  });
}
