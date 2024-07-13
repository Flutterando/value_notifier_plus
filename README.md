# Value Notifier Plus

[![License: MIT][license_badge]][license_link]

`ValueNotifierPlus` é um pacote que expande as funcionalidades de `ValueNotifier` do Flutter, oferecendo uma alternativa ao `Cubit` utilizando `ValueNotifier` em vez de `Streams`. `ValueNotifier` é mais eficiente em termos de desempenho porque não precisa lidar com a complexidade de um sistema de fluxo assíncrono. Isso pode ser importante em cenários de alta frequência de atualização de UI.

## Instalação

Adicione o `ValueNotifierPlus` ao seu arquivo `pubspec.yaml`:

```yaml
dependencies:
  value_notifier_plus: x.x.x
```

## O que é o `ValueNotifierPlus`

O `ValueNotifierPlus` é uma classe que estende o `ValueNotifier` padrão do Flutter, adicionando capacidades adicionais como estados imutáveis e integração simplificada com a árvore de widgets. Ele facilita o gerenciamento de estado de forma mais eficiente e menos verbosa, sem a necessidade de streams e eventos complexos.

## Widgets do `ValueNotifierPlus`

### `BuilderPlus`

O `BuilderPlus` é um widget que reconstrói sua árvore de widgets sempre que o valor do `ValueNotifierPlus` muda. É similar ao `BlocBuilder` do pacote `flutter_bloc`.

#### Exemplo de Uso:

```dart
import 'package:flutter/material.dart';
import 'value_notifier_plus.dart';

class CounterNotifier extends ValueNotifierPlus<int> {
  CounterNotifier() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlusProvider(
      provider: CounterNotifier(),
      child: MaterialApp(
        home: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterNotifier = context.of<CounterNotifier>();

    return Scaffold(
      appBar: AppBar(title: Text('ValueNotifierPlus Example')),
      body: Center(
        child: BuilderPlus<CounterNotifier, int>(
          notifier: counterNotifier,
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

### `ListenerPlus`

O `ListenerPlus` é um widget que executa uma função sempre que o valor do `ValueNotifierPlus` muda, sem reconstruir a árvore de widgets. É similar ao `BlocListener` do pacote `flutter_bloc`.

#### Exemplo de Uso:

```dart
import 'package:flutter/material.dart';
import 'value_notifier_plus.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterNotifier = context.of<CounterNotifier>();

    return Scaffold(
      appBar: AppBar(title: Text('ValueNotifierPlus Example')),
      body: Center(
        child: ListenerPlus<CounterNotifier, int>(
          notifier: counterNotifier,
          listener: (context, state) {
            if (state == 10) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reached 10!')));
            }
          },
          child: ListenerPlus<CounterNotifier, int>(
            notifier: counterNotifier,
            builder: (context, state) {
              return Text('Counter: $state');
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterNotifier.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### `ConsumerPlus`

O `ConsumerPlus` combina a funcionalidade de `ValueNotifierPlusListener` e `ValueNotifierPlusBuilder`, permitindo ouvir e reconstruir a árvore de widgets em resposta a mudanças de estado. É similar ao `BlocConsumer` do pacote `flutter_bloc`.

#### Exemplo de Uso:

```dart
import 'package:flutter/material.dart';
import 'value_notifier_plus.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterNotifier = context.of<CounterNotifier>();

    return Scaffold(
      appBar: AppBar(title: Text('ValueNotifierPlus Example')),
      body: Center(
        child: ConsumerPlus<CounterNotifier, int>(
          notifier: counterNotifier,
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
          counterNotifier.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### `ListenersPlus e ProvidersPlus`

O `ListenersPlus e ProvidersPlus` permite registrar múltiplos listeners e providers para diferentes `ValueNotifierPlus` ao mesmo tempo, simplificando o código quando há vários observadores. É similar ao `MultiBlocListener e MultiBlocProvider` do pacote `flutter_bloc`.

#### Exemplo de Uso:

```dart
import 'package:flutter/material.dart';
import 'value_notifier_plus.dart';

class CounterNotifier extends ValueNotifierPlus<int> {
  CounterNotifier() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

class AnotherNotifier extends ValueNotifierPlus<int> {
  AnotherNotifier() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProvidersPlus(
      providers: [
        CounterNotifier(),
        AnotherNotifier(),
      ],
      child: Builder(
        builder: (context) {
          return const MaterialApp(
            home: CounterPage(),
          );
        },
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterNotifier = context.of<CounterNotifier>();
    final anotherNotifier = context.of<AnotherNotifier>();

    return Scaffold(
      appBar: AppBar(title: Text('ValueNotifierPlus Example')),
      body: Center(
        child: ListenersPlus(
          listeners: [
            ListenerPlus<CounterNotifier, int>(
              notifier: counterNotifier,
              listener: (context, state) {
                if (state == 5) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Counter Reached 5!')));
                }
              },
              child: Container(),
            ),
            ListenerPlus<AnotherNotifier, int>(
              notifier: anotherNotifier,
              listener: (context, state) {
                if (state == 10) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('AnotherNotifier Reached 10!')));
                }
              },
              child: Container(),
            ),
          ],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuilderPlus<CounterNotifier, int>(
                notifier: counterNotifier,
                builder: (context, state) {
                  return Text('Counter: $state');
                },
              ),
              BuilderPlus<AnotherNotifier, int>(
                notifier: anotherNotifier,
                builder: (context, state) {
                  return Text('AnotherNotifier: $state');
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterNotifier.increment();
          anotherNotifier.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

## Observador

Você pode adicionar um observador para monitorar mudanças de estado nos `ValueNotifierPlus`:

```dart
import 'package:flutter/material.dart';
import 'value_notifier_plus.dart';

class MyObserver extends ObserverPlus {
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

## Testes

Para rodar os testes, execute o seguinte comando no terminal:

```bash
flutter test
```

## Contribuições

Contribuições são bem-vindas! Por favor, abra um pull request ou uma issue no GitHub se encontrar algum problema ou tiver sugestões de melhorias.

## Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

[flutter_install_link]: https://docs.flutter.dev/get-started/install
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT