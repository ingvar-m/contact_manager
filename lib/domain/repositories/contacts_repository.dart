import '../../data/models/contact_model.dart';

abstract class ContactsRepository {

  Future<void> addContact(Contact contact);
  Future<void> updateContact(Contact contact);
  Future<void> deleteContact(int key);
  List<Contact> getAllContacts();

}