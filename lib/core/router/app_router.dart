import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/notes/screens/note_list_screen.dart';
import '../../features/notes/screens/note_editor_screen.dart';
import '../../features/notes/screens/trash_screen.dart';
import '../../features/notes/screens/home_screen.dart';
import '../../features/study/screens/flashcard_screen.dart';
import '../../features/study/screens/quiz_screen.dart';
import '../../features/study/screens/mindmap_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isAuthRoute =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!isLoggedIn && !isAuthRoute) return '/login';
      if (isLoggedIn && isAuthRoute) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, _) => const RegisterScreen()),
      GoRoute(path: '/', builder: (_, _) => const HomeScreen()),
      GoRoute(
        path: '/folder/:id',
        builder: (_, state) => NoteListScreen(folderId: state.pathParameters['id']),
      ),
      GoRoute(
        path: '/notes/:id',
        builder: (_, state) => NoteEditorScreen(noteId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/trash', builder: (_, _) => const TrashScreen()),
      GoRoute(
        path: '/notes/:id/study/flashcard',
        builder: (_, state) => FlashcardScreen(
          noteId: state.pathParameters['id']!,
          generationId: state.uri.queryParameters['generation_id'],
        ),
      ),
      GoRoute(
        path: '/notes/:id/study/quiz',
        builder: (_, state) => QuizScreen(
          noteId: state.pathParameters['id']!,
          generationId: state.uri.queryParameters['generation_id'],
        ),
      ),
      GoRoute(
        path: '/notes/:id/study/mindmap',
        builder: (_, state) => MindmapScreen(
          noteId: state.pathParameters['id']!,
          generationId: state.uri.queryParameters['generation_id'],
        ),
      ),
    ],
  );
}
