# Value Notifier Plus

[![License: MIT][license_badge]][license_link]

## ValueNotifierPlus

`ValueNotifierPlus` é um pacote que expande as funcionalidades de `ValueNotifier` do Flutter, oferecendo uma alternativa ao `Cubit` utilizando `ValueNotifier` em vez de `Streams`. Ele inclui suporte para observadores, múltiplos listeners e widgets helpers, como `ValueNotifierPlusBuilder`, `ValueNotifierPlusListener`, `ValueNotifierPlusConsumer` e `MultiValueNotifierPlusListener`.

### Instalação

Adicione o `ValueNotifierPlus` ao seu arquivo `pubspec.yaml`:

```yaml
dependencies:
  value_notifier_plus: x.x.x

```

### Uso

#### 1. Criando um ValueNotifierPlus

```dart
import 'package:flutter/material.dart';
import 'value_notifier_plus.dart';

class CounterNotifier extends ValueNotifierPlus<int> {
  CounterNotifier() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
```

#### 2. Usando o ValueNotifierPlusProvider

```dart
import 'package:flutter/material.dart';
import 'value_notifier_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueNotifierPlusProvider(
      notifier: CounterNotifier(),
      child: MaterialApp(
        home: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterNotifier = ValueNotifierPlusProvider.of<CounterNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text('ValueNotifierPlus Example')),
      body: Center(
        child: ValueNotifierPlusBuilder<CounterNotifier, int>(
          builder: (context, state) {
            return Text('Counter: $state');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterNotifier.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
```

#### 3. Usando o ValueNotifierPlusListener

```dart
import 'package:flutter/material.dart';
import 'value_notifier_plus.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ValueNotifierPlus Example')),
      body: Center(
        child: ValueNotifierPlusListener<CounterNotifier, int>(
          listener: (context, state) {
            if (state == 10) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reached 10!')));
            }
          },
          child: ValueNotifierPlusBuilder<CounterNotifier, int>(
            builder: (context, state) {
              return Text('Counter: $state');
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ValueNotifierPlusProvider.of<CounterNotifier>(context).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

#### 4. Usando o ValueNotifierPlusConsumer

```dart
import 'package:flutter/material.dart';
import 'value_notifier_plus.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ValueNotifierPlus Example')),
      body: Center(
        child: ValueNotifierPlusConsumer<CounterNotifier, int>(
          listener: (context, state) {
            if (state == 10) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reached 10!')));
            }
          },
          builder: (context, state) {
            return Text('Counter: $state');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ValueNotifierPlusProvider.of<CounterNotifier>(context).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

#### 5. Usando o MultiValueNotifierPlusListener

```dart
import 'package:flutter/material.dart';
import 'value_notifier_plus.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ValueNotifierPlus Example')),
      body: Center(
        child: MultiValueNotifierPlusListener(
          listeners: [
            ValueNotifierPlusListener<CounterNotifier, int>(
              listener: (context, state) {
                if (state == 5) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reached 5!')));
                }
              },
              child: Container(),
            ),
            ValueNotifierPlusListener<CounterNotifier, int>(
              listener: (context, state) {
                if (state == 10) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reached 10!')));
                }
              },
              child: Container(),
            ),
          ],
          child: ValueNotifierPlusBuilder<CounterNotifier, int>(
            builder: (context, state) {
              return Text('Counter: $state');
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ValueNotifierPlusProvider.of<CounterNotifier>(context).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### Observador

Você pode adicionar um observador para monitorar mudanças de estado nos `ValueNotifierPlus`:

```dart
import 'package:flutter/material.dart';
import 'value_notifier_plus.dart';

class MyObserver extends ValueNotifierPlusObserver {
  @override
  void onChange<ValueNotifierPlusType extends ValueNotifierPlus>(
    ValueNotifierPlusType notifier,
    Object? state,
  ) {
    print('State changed to $state');
  }
}

void main() {
  ValueNotifierPlus.observer = MyObserver();
  runApp(MyApp());
}
```

### Testes

Para rodar os testes, execute o seguinte comando no terminal:

```bash
flutter test
```

### Contribuições

Contribuições são bem-vindas! Por favor, abra um pull request ou uma issue no GitHub se encontrar algum problema ou tiver sugestões de melhorias.

### Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.