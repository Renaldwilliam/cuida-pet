// ignore_for_file: camel_case_types

part of '../../address_page.dart';

typedef AddressSelectedCallback = void Function(PlaceModel);

class _AddressSearchWidget extends StatefulWidget {
  final AddressSelectedCallback addressSelectedCallback;
  final PlaceModel? place;
  const _AddressSearchWidget({
    super.key,
    required this.addressSelectedCallback,
    required this.place,
  });

  @override
  State<_AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<_AddressSearchWidget> {
  final searchTextEC = TextEditingController();
  final searchTextFN = FocusNode();

  final controller = Modular.get<AddressSearchController>();

  @override
  void initState() {
    super.initState();
    if (widget.place != null) {
      searchTextEC.text = widget.place?.address ?? '';
      searchTextFN.requestFocus();
    }
  }

  @override
  void dispose() {
    super.dispose();
    searchTextEC.dispose();
    searchTextFN.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide:
            const BorderSide(style: BorderStyle.none, color: Colors.black));

    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: TypeAheadFormField<PlaceModel>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: searchTextEC,
          focusNode: searchTextFN,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.location_on),
            hintText: 'Insira um endereço',
            border: border,
            disabledBorder: border,
            enabledBorder: border,
          ),
        ),
        onSuggestionSelected: _onSuggestionSelected,
        itemBuilder: (_, itemData) {
          return _itemTile(
            address: itemData.address,
          );
        },
        suggestionsCallback: _suggestionsCallback,
      ),
    );
  }

  Future<List<PlaceModel>> _suggestionsCallback(String pattern) async {
    if (pattern.isNotEmpty) {
      return controller.searchAddress(pattern);
    }
    return <PlaceModel>[];
  }

  void _onSuggestionSelected(PlaceModel suggestion) {
    searchTextEC.text = suggestion.address;
    widget.addressSelectedCallback(suggestion);
  }
}

class _itemTile extends StatelessWidget {
  final String address;
  const _itemTile({required this.address});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(address),
    );
  }
}
