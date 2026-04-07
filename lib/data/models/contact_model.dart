import 'package:hive_ce/hive.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 0)
class Contact extends HiveObject {
  @HiveField(0)
  String phone;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String? lastName;

  Contact({
    required this.phone,
    required this.firstName,
    this.lastName,
  });

  String get fullName =>  "$firstName ${lastName ?? ''}".trim();

}
