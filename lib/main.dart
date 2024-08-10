import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/app_database.dart';
import 'routes.dart';

class AppDatabaseProvider extends InheritedWidget {
  const AppDatabaseProvider({
    super.key,
    required this.appDatabase,
    required super.child,
  });
  final AppDatabase appDatabase;
  static AppDatabaseProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDatabaseProvider>();
  }
  static AppDatabaseProvider of(BuildContext context) {
    final AppDatabaseProvider? result = maybeOf(context);
    assert(result != null, 'No AppDatabaseProvider found in context');
    return result!;
  }
  @override
  bool updateShouldNotify(AppDatabaseProvider oldWidget) => appDatabase != oldWidget.appDatabase;
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase
    .databaseBuilder("app-database")
    .build();
  runApp(AppDatabaseProvider(appDatabase: database, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Todo',
        darkTheme: ThemeData(
          colorScheme: darkDynamic,
          useMaterial3: true,
        ),
        theme: ThemeData(
          colorScheme: lightDynamic,
          useMaterial3: true,
        ),
        routerConfig: routerConfig,
      ),
    );
  }
}
