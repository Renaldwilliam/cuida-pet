// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../home_page.dart';

// ignore: must_be_immutable
class _HomeAddressWidget extends StatelessWidget {
  HomeController controller;
  _HomeAddressWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text('Estabeleciomentos proximos de  '),
          Observer(
            builder: (_) {
              return Text(
                controller.addressEntity?.address ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              );
            },
          )
        ],
      ),
    );
  }
}
