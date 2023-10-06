import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

typedef TryAgain = void Function();

mixin LocationMixin<E extends StatefulWidget> on State<E> {
  void showDialogLocationServiceUnavailable() {
    showDialog(
      context: context,
      builder: (contextDialog) {
        return AlertDialog(
          title: const Text('Precisamos da sua localização'),
          content: const Text(
              'Para realizar a busca da sua localização, precisamos que você atuve o GPS'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(contextDialog);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(contextDialog);
                Geolocator.openLocationSettings();
              },
              child: const Text('Abrir configurações'),
            ),
          ],
        );
      },
    );
  }

  void showDialogLocationServiceDenied({TryAgain? tryAgain}) {
    showDialog(
      context: context,
      builder: (contextDialog) {
        return AlertDialog(
          title: const Text('Precisamos da sua autorização'),
          content: const Text(
              'Para realizar a busca da sua localização, precisamos que você autorize a ultização'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(contextDialog);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(contextDialog);
                if (tryAgain != null) {
                  tryAgain();
                }
              },
              child: const Text('Tentar Novamente'),
            ),
          ],
        );
      },
    );
  }

  void showDialogLocationServiceDeniedForever() {
    showDialog(
      context: context,
      builder: (contextDialog) {
        return AlertDialog(
          title: const Text('Precisamos da sua autorização'),
          content: const Text(
              'Para realizar a busca da sua localização, precisamos que você autorize a ultização, clique no botão botão configurações e autorize a utilziação e clique novamente no botão localização atual'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(contextDialog);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(contextDialog);
                Geolocator.openLocationSettings();
              },
              child: const Text('Abrir configurações'),
            ),
          ],
        );
      },
    );
  }
}
