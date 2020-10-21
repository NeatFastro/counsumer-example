import 'package:consumer_example/my_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

/// Providers are declared globally and specifies how to create a state
final counterProvider = StateProvider((ref) => 0);
final counterProvider2 = ChangeNotifierProvider((ref) => Counter());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // LOOK AT MEEE!
            MyConsumer(
              provider: counterProvider,
              builder: (context, counter, _) {
                return Text(counter.state.toString());
              },
            ),
            MyConsumer(
              provider: counterProvider2,
              builder: (context, state, _) {
                return Text(state.counter.toString());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            label: Text('Change Notifier Provider'),
            onPressed: () => context.read(counterProvider2).incrementCounter(),
            icon: Icon(Icons.add_circle_outline),
          ),
          FloatingActionButton.extended(
            label: Text('State Provider'),
            onPressed: () => context.read(counterProvider).state++,
            icon: Icon(Icons.add_circle),
          ),
        ],
      ),
    );
  }
}

class Counter extends ChangeNotifier {
  int counter = 0;

  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}
