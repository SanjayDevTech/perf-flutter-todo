import 'package:go_router/go_router.dart';
import 'package:todo_test/ui/screens/details_page.dart';
import 'package:todo_test/ui/screens/home_page.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: 'details',
      path: '/details/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters["id"] ?? "0") ?? 0;
        return DetailsPage(id: id);
      },
    ),
  ],
);
