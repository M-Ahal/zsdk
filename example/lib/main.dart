import 'package:flutter/material.dart';
import 'package:zsdk/zsdk_printing.dart';

import 'views/original_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  final _zebraPrinting = ZebraPrinting();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomFutureBuilder(
                future: _zebraPrinting.checkPrinterStatusOverTCPIP(),
                builder: (statusInfo) => Text('${statusInfo.status}, ${statusInfo.cause}')),
            TextButton(
              child: const Text('Original View'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => OriginalView()),
              ),
            ),
          ],
        ),
      );
}

class CustomFutureBuilder<T> extends FutureBuilder<T> {
  CustomFutureBuilder({
    required super.future,
    required Widget Function(T resolvedValue) builder,
    Widget? waitingPlaceholder,
    super.key,
  }) : super(
          builder: (_, snapshot) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: snapshot.connectionState != ConnectionState.done
                ? waitingPlaceholder ?? const CircularProgressIndicator()
                : builder(snapshot.data as T),
          ),
        );
}
