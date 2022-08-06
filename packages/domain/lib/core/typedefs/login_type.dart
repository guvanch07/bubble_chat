typedef LoginFunction = void Function(
  String email,
  String password,
);

typedef RegisterFunction = void Function(
  String email,
  String password,
);

typedef CreateContactCallback = void Function(
  String firstName,
  String lastName,
  String phoneNumber,
);
