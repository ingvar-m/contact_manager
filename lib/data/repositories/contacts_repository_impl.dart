import 'package:contact_manager/data/models/contact_model.dart';
import 'package:contact_manager/domain/repositories/contacts_repository.dart';
import 'package:hive_ce/hive.dart';

class ContactsRepositoryImpl implements ContactsRepository {

  final Box<Contact> _box;

  ContactsRepositoryImpl(this._box);

  @override
  Future<void> addContact(Contact contact) async {
    await _box.add(contact);
  }

  @override
  Future<void> deleteContact(dynamic key) async {
    await _box.delete(key);
  }

  @override
  List<Contact> getAllContacts() {
    return _box.values.toList();
  }

  @override
  Future<void> updateContact(Contact contact) async {
    await _box.put(contact.key, contact);
  }
  
}