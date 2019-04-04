import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_weather/widgets/widgets.dart';
import 'package:flutter_weather/repositories/repositories.dart';
import 'package:flutter_weather/blocs/blocs.dart';

void main() {
  final WeatherRepository weatherRespository = WeatherRepository(
    weatherApiClient: WeatherApiClient(httpClient: http.Client()),
  );
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App(weatherRespository: weatherRespository));
}

class App extends StatefulWidget {
  final WeatherRepository weatherRespository;

  App({Key key, @required this.weatherRespository})
      : assert(weatherRespository != null),
        super(key: key);
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeBloc _themeBloc = ThemeBloc();
  SettingsBloc _settingsBloc = SettingsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<ThemeBloc>(
          bloc: _themeBloc,
        ),
        BlocProvider<SettingsBloc>(bloc: _settingsBloc)
      ],
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (BuildContext context, ThemeState state) {
          return MaterialApp(
              title: 'Flutter Weather',
              theme: state.theme,
              home: Weather(
                weatherRepository: widget.weatherRespository,
              ));
        },
      ),
    );
  }

  @override
  void dispose() {
    _themeBloc.dispose();
    _settingsBloc.dispose();
    super.dispose();
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
  }
}
