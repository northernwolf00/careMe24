import 'package:careme24/blocs/app_bloc.dart';
import 'package:careme24/blocs/medcard/medcard_cubit.dart';
import 'package:careme24/blocs/medcard/medcard_state.dart';
import 'package:careme24/models/medcard/medcard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactSelectDialogMed extends StatefulWidget {
  const ContactSelectDialogMed({Key? key}) : super(key: key);

  @override
  _ContactSelectDialogMedState createState() => _ContactSelectDialogMedState();
}

class _ContactSelectDialogMedState extends State<ContactSelectDialogMed> {
  TextEditingController _searchController = TextEditingController();
  List<MedcardModel> _filteredContacts = [];

  @override
  void initState() {
    super.initState();
    AppBloc.medCardCubit.fetchData();
    _filterContacts();

    _searchController.addListener(_filterContacts);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterContacts);
    _searchController.dispose();
    super.dispose();
  }

  void _filterContacts() {
    final state = AppBloc.medCardCubit.state;
    if (state is MedCardLoaded) {
      String query = _searchController.text.toLowerCase();
      setState(() {
        _filteredContacts = state.otherCards
            .where((contact) =>
                contact.personalInfo.full_name.toLowerCase().contains(query) ||
                contact.personalInfo.phone.toString().contains(query))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: BlocBuilder<MedCardCubit, MedCardState>(builder: (context, state) {
        if (state is MedCardLoading) {
          return _buildLoading();
        } else {
          if (state is MedCardLoaded) {
            String query = _searchController.text.toLowerCase();
            _filteredContacts = state.otherCards
                .where((contact) =>
                    contact.personalInfo.full_name
                        .toLowerCase()
                        .contains(query) ||
                    contact.personalInfo.phone.toString().contains(query))
                .toList();
            return _buildContactList(context, state);
          }
        }
        return _buildEmpty();
      }),
    );
  }

  Widget _buildLoading() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError(String message) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(child: Text("Ошибка: $message")),
    );
  }

  Widget _buildEmpty() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(child: Text("Нет данных")),
    );
  }

  Widget _buildContactList(BuildContext context, MedCardLoaded state) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      constraints:
          BoxConstraints(maxHeight: 500), // Prevents dialog from being too tall
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Close button
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          /// Title
          Text(
            "Выберите пользователя, которому хотите создать заявку",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),

          SizedBox(height: 12),

          /// Search field
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 10, bottom: 0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(0),
            ),
            child: TextField(
              controller: _searchController,
              maxLines: 1,
              cursorHeight: 20,
              scrollPadding: EdgeInsets.zero,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                prefixIcon: Icon(Icons.search),
                prefixStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.zero,
                hintText: "Поиск...",
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),

          SizedBox(height: 12),

          /// Contacts list
          _filteredContacts.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredContacts.length,
                    itemBuilder: (context, index) {
                      MedcardModel contact = _filteredContacts[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              contact.personalInfo.avatar.isNotEmpty
                                  ? NetworkImage(contact.personalInfo.avatar)
                                  : null,
                          child: contact.personalInfo.avatar.isEmpty
                              ? Icon(Icons.person)
                              : null,
                        ),
                        title: Text(
                          contact.personalInfo.full_name,
                          style: TextStyle(color: Colors.blue),
                        ),
                        subtitle: Text(contact.personalInfo.phone.toString()),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.pop(context, contact);
                        },
                      );
                    },
                  ),
                )
              : Center(child: Text("Нет совпадений")),
        ],
      ),
    );
  }
}
