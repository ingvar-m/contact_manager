import 'package:contact_manager/data/models/contact_model.dart';
import 'package:contact_manager/data/repositories/contacts_repository_impl.dart';
import 'package:contact_manager/domain/repositories/contacts_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive_ce/hive.dart';

final contactsBoxProvider = Provider<Box<Contact>>((ref) {
  return Hive.box<Contact>('contacts');
});

final contactsRepositoryProvider = Provider<ContactsRepository>((ref) {
  final box = ref.watch(contactsBoxProvider);
  return ContactsRepositoryImpl(box);
});

final contactsListProvider = StateProvider<List<Contact>>((ref) {
  final repository = ref.watch(contactsRepositoryProvider);
  return repository.getAllContacts();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final groupedContactsProvider = Provider<Map<String, List<Contact>>>((ref) {
  final contacts = ref.watch(contactsListProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  final filteredContacts = contacts.where((contact) {
    final nameMatch = contact.fullName.toLowerCase().contains(searchQuery);
    final phoneMatch = contact.phone.contains(searchQuery);
    return nameMatch || phoneMatch;
  }).toList();

  filteredContacts.sort(
    (a, b) => a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase()),
  );
  final Map<String, List<Contact>> grouped = {};
  for (var contact in filteredContacts) {
    final firstLetter = contact.firstName.trim().isNotEmpty
        ? contact.firstName.trim()[0].toUpperCase()
        : '#';
    if(!grouped.containsKey(firstLetter)) {
      grouped[firstLetter] = [];
    }
    grouped[firstLetter]!.add(contact);
  }
  return grouped;
});
