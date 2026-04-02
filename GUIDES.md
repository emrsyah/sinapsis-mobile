# sinapsis-mobile — Mobile Reference
> Flutter 3.41 · Dart 3.11 · Riverpod · GoRouter · Freezed · flutter_quill

---

## Table of Contents
1. [Stack & Libraries](#1-stack--libraries)
2. [Folder Structure](#2-folder-structure)
3. [Architecture & Patterns](#3-architecture--patterns)
4. [Routing (GoRouter)](#4-routing-gorouter)
5. [State Management (Riverpod)](#5-state-management-riverpod)
6. [Data Layer (Repositories)](#6-data-layer-repositories)
7. [Models (Freezed)](#7-models-freezed)
8. [Editor (flutter_quill)](#8-editor-flutter_quill)
9. [Real-time Client (Reverb)](#9-real-time-client-reverb)
10. [File Uploads (Uploadthing)](#10-file-uploads-uploadthing)
11. [Push Notifications (FCM)](#11-push-notifications-fcm)
12. [Environment Configuration](#12-environment-configuration)
13. [Coding Conventions](#13-coding-conventions)

---

## 1. Stack & Libraries

| Package | Version | Purpose |
|---|---|---|
| `flutter_riverpod` | ^2.6 | State management |
| `riverpod_annotation` | ^2.6 | Code generation for providers |
| `go_router` | ^14.0 | Declarative routing + deep links |
| `dio` | ^5.0 | HTTP client |
| `freezed` | ^2.5 | Immutable models with codegen |
| `freezed_annotation` | ^2.5 | Freezed annotations |
| `json_serializable` | ^6.0 | JSON serialization codegen |
| `flutter_quill` | ^10.0 | Rich text editor |
| `shared_preferences` | ^2.0 | Token + user persistence |
| `firebase_core` | ^3.0 | Firebase initialization |
| `firebase_messaging` | ^15.0 | Push notifications (FCM) |
| `flutter_local_notifications` | ^17.0 | Local study reminders |
| `build_runner` | ^2.0 | Code generation runner |

**Run after any model change:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 2. Folder Structure

```
sinapsis_mobile/
├── lib/
│   ├── main.dart                          # app entry point, Firebase init
│   ├── app.dart                           # ProviderScope, MaterialApp.router, theme
│   │
│   ├── core/
│   │   ├── api/
│   │   │   ├── api_client.dart            # Dio client singleton (base URL, interceptors)
│   │   │   └── api_endpoints.dart         # all endpoint string constants
│   │   ├── storage/
│   │   │   └── local_storage.dart         # shared_preferences wrapper
│   │   ├── realtime/
│   │   │   └── reverb_client.dart         # WebSocket connection to Laravel Reverb
│   │   ├── router/
│   │   │   └── app_router.dart            # GoRouter definitions
│   │   └── constants.dart                 # app-wide constants
│   │
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   │   └── auth_repository.dart
│   │   │   ├── providers/
│   │   │   │   └── auth_provider.dart
│   │   │   ├── screens/
│   │   │   │   ├── login_screen.dart
│   │   │   │   └── register_screen.dart
│   │   │   └── widgets/
│   │   │       └── auth_form.dart
│   │   │
│   │   ├── notes/
│   │   │   ├── data/
│   │   │   │   └── note_repository.dart
│   │   │   ├── providers/
│   │   │   │   └── note_provider.dart
│   │   │   ├── screens/
│   │   │   │   ├── note_list_screen.dart
│   │   │   │   ├── note_editor_screen.dart
│   │   │   │   └── trash_screen.dart
│   │   │   └── widgets/
│   │   │       ├── note_card.dart
│   │   │       ├── editor_toolbar.dart
│   │   │       └── backlinks_panel.dart
│   │   │
│   │   ├── folders/
│   │   │   ├── data/
│   │   │   │   └── folder_repository.dart
│   │   │   ├── providers/
│   │   │   │   └── folder_provider.dart
│   │   │   └── widgets/
│   │   │       ├── folder_tree.dart
│   │   │       └── folder_bottom_sheet.dart
│   │   │
│   │   ├── tags/
│   │   │   ├── data/
│   │   │   │   └── tag_repository.dart
│   │   │   └── widgets/
│   │   │       └── tag_chip.dart
│   │   │
│   │   ├── study/
│   │   │   ├── data/
│   │   │   │   └── study_tool_repository.dart
│   │   │   ├── providers/
│   │   │   │   └── study_tool_provider.dart
│   │   │   ├── screens/
│   │   │   │   ├── flashcard_screen.dart
│   │   │   │   ├── quiz_screen.dart
│   │   │   │   └── mindmap_screen.dart
│   │   │   └── widgets/
│   │   │       ├── generate_button.dart
│   │   │       └── generation_history.dart
│   │   │
│   │   ├── sharing/
│   │   │   └── widgets/
│   │   │       └── share_bottom_sheet.dart
│   │   │
│   │   └── notifications/
│   │       └── notification_service.dart
│   │
│   ├── models/                            # freezed models
│   │   ├── user.dart
│   │   ├── user.freezed.dart              # generated — do not edit
│   │   ├── user.g.dart                    # generated — do not edit
│   │   ├── note.dart
│   │   ├── note.freezed.dart
│   │   ├── note.g.dart
│   │   ├── folder.dart
│   │   ├── folder.freezed.dart
│   │   ├── folder.g.dart
│   │   ├── tag.dart
│   │   ├── tag.freezed.dart
│   │   ├── tag.g.dart
│   │   ├── attachment.dart
│   │   ├── attachment.freezed.dart
│   │   ├── attachment.g.dart
│   │   ├── study_tool_generation.dart
│   │   ├── study_tool_generation.freezed.dart
│   │   └── study_tool_generation.g.dart
│   │
│   └── shared/
│       └── widgets/
│           ├── app_button.dart
│           ├── app_input.dart
│           ├── loading_spinner.dart
│           └── empty_state.dart
│
├── android/
│   └── app/
│       └── google-services.json           # FCM Android config
├── ios/
│   └── Runner/
│       └── GoogleService-Info.plist       # FCM iOS config
└── pubspec.yaml
```

---

## 3. Architecture & Patterns

### Feature-first structure
Each feature folder is self-contained: `data/` (repository), `providers/` (Riverpod), `screens/`, `widgets/`. Features never import from each other's internal files — only from `models/`, `core/`, and `shared/`.

### Data flow
```
Screen (Widget)
  → reads from Riverpod Provider (watches state)
  → calls Provider method on interaction
  → Provider calls Repository
  → Repository calls ApiClient (Dio)
  → Response deserialized to Freezed model
  → Provider updates AsyncValue state
  → Screen rebuilds
```

### Error handling
All async operations in repositories return a result and throw on failure. Providers catch and expose errors via `AsyncValue.error`. Screens show error states via `AsyncValue.when()`.

```dart
// Provider pattern
@riverpod
class NoteNotifier extends _$NoteNotifier {
  @override
  FutureOr<List<Note>> build() => ref.read(noteRepositoryProvider).getNotes();

  Future<void> createNote({String? folderId}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(noteRepositoryProvider).createNote(folderId: folderId),
    );
  }
}
```

---

## 4. Routing (GoRouter)

### core/router/app_router.dart
```dart
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isAuthRoute = state.matchedLocation == '/login' ||
                          state.matchedLocation == '/register';

      if (!isLoggedIn && !isAuthRoute) return '/login';
      if (isLoggedIn && isAuthRoute) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login',    builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),

      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const NoteListScreen(),
          ),
          GoRoute(
            path: '/notes/:id',
            builder: (_, state) => NoteEditorScreen(
              noteId: state.pathParameters['id']!,
            ),
          ),
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
          GoRoute(
            path: '/trash',
            builder: (_, __) => const TrashScreen(),
          ),
        ],
      ),
    ],
  );
});
```

### Navigating with noteId
```dart
// From NoteEditorScreen, navigate to study tool
context.go('/notes/${widget.noteId}/study/flashcard?generation_id=${gen.id}');
```

---

## 5. State Management (Riverpod)

Use `riverpod_annotation` for code generation. Run `build_runner` after adding new providers.

### Auth provider
```dart
// features/auth/providers/auth_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/auth_repository.dart';
import '../../models/user.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<User?> build() async {
    final storage = ref.read(localStorageProvider);
    final token = await storage.getToken();
    if (token == null) return null;
    return ref.read(authRepositoryProvider).getMe();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(authRepositoryProvider).login(email, password);
      await ref.read(localStorageProvider).saveToken(result.token);
      return result.user;
    });
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    await ref.read(localStorageProvider).clearToken();
    state = const AsyncValue.data(null);
  }
}

// Convenience provider: just the auth state (for redirect logic)
@riverpod
Stream<User?> authState(AuthStateRef ref) {
  return ref.watch(authNotifierProvider.stream);
}
```

### Note provider
```dart
// features/notes/providers/note_provider.dart
@riverpod
class NoteListNotifier extends _$NoteListNotifier {
  @override
  FutureOr<List<Note>> build({String? folderId, String? tagId}) {
    return ref.read(noteRepositoryProvider).getNotes(
      folderId: folderId,
      tagId: tagId,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

@riverpod
Future<Note> note(NoteRef ref, String id) {
  return ref.read(noteRepositoryProvider).getNote(id);
}
```

### Consuming state in screens
```dart
class NoteListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(noteListNotifierProvider());

    return notesAsync.when(
      loading: () => const LoadingSpinner(),
      error:   (e, _) => ErrorState(message: e.toString()),
      data:    (notes) => NoteListView(notes: notes),
    );
  }
}
```

---

## 6. Data Layer (Repositories)

Repositories are the only place that call `ApiClient`. Never call Dio directly from providers or screens.

### core/api/api_client.dart
```dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local_storage.dart';
import 'constants.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.read(localStorageProvider));
});

class ApiClient {
  final LocalStorage _storage;
  late final Dio _dio;

  ApiClient(this._storage) {
    _dio = Dio(BaseOptions(
      baseUrl: '${AppConstants.apiBaseUrl}/api/v1',
      headers: {'Accept': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
    ));

    // Auth interceptor — injects token on every request
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          // Token expired — clear storage and redirect to login
          _storage.clearToken();
        }
        handler.next(error);
      },
    ));
  }

  Future<T> get<T>(String path, {Map<String, dynamic>? params}) async {
    final res = await _dio.get(path, queryParameters: params);
    return res.data as T;
  }

  Future<T> post<T>(String path, {required Map<String, dynamic> body}) async {
    final res = await _dio.post(path, data: body);
    return res.data as T;
  }

  Future<T> patch<T>(String path, {required Map<String, dynamic> body}) async {
    final res = await _dio.patch(path, data: body);
    return res.data as T;
  }

  Future<void> delete(String path) async {
    await _dio.delete(path);
  }
}
```

### Example repository
```dart
// features/notes/data/note_repository.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../models/note.dart';

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  return NoteRepository(ref.read(apiClientProvider));
});

class NoteRepository {
  final ApiClient _api;
  NoteRepository(this._api);

  Future<List<Note>> getNotes({String? folderId, String? tagId}) async {
    final data = await _api.get<List<dynamic>>(
      ApiEndpoints.notes,
      params: {
        if (folderId != null) 'folder_id': folderId,
        if (tagId != null) 'tag_id': tagId,
      },
    );
    return data.map((e) => Note.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Note> getNote(String id) async {
    final data = await _api.get<Map<String, dynamic>>(
      '${ApiEndpoints.notes}/$id',
      params: {'include': 'tags,backlinks'},
    );
    return Note.fromJson(data);
  }

  Future<Note> createNote({String? title, String? folderId}) async {
    final data = await _api.post<Map<String, dynamic>>(
      ApiEndpoints.notes,
      body: {'title': title ?? 'Untitled', if (folderId != null) 'folder_id': folderId},
    );
    return Note.fromJson(data);
  }

  Future<Note> updateNote(String id, {String? title, String? content}) async {
    final data = await _api.patch<Map<String, dynamic>>(
      '${ApiEndpoints.notes}/$id',
      body: {
        if (title != null) 'title': title,
        if (content != null) 'content': content,
      },
    );
    return Note.fromJson(data);
  }

  Future<void> deleteNote(String id) async {
    await _api.delete('${ApiEndpoints.notes}/$id');
  }
}
```

### core/api/api_endpoints.dart
```dart
class ApiEndpoints {
  static const String auth         = '/auth';
  static const String notes        = '/notes';
  static const String folders      = '/folders';
  static const String tags         = '/tags';
  static const String studyTools   = '/study-tools';

  static String noteLinks(String noteId) => '/notes/$noteId/links';
  static String noteBacklinks(String noteId) => '/notes/$noteId/backlinks';
  static String noteAttachments(String noteId) => '/notes/$noteId/attachments';
  static String noteStudyTools(String noteId) => '/notes/$noteId/study-tools';
  static String notePublish(String noteId) => '/notes/$noteId/publish';
  static String noteTags(String noteId) => '/notes/$noteId/tags';
  static String studyToolStatus(String id) => '/study-tools/$id/status';
  static String noteRestore(String id) => '/notes/$id/restore';
}
```

---

## 7. Models (Freezed)

Freezed generates immutable models with `copyWith`, `==`, `hashCode`, and `fromJson/toJson`.

### models/note.dart
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'tag.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
class Note with _$Note {
  const factory Note({
    required String id,
    required String title,
    String? content,
    @Default(false) bool isPublished,
    String? shareToken,
    String? folderId,
    String? deletedAt,
    required String createdAt,
    required String updatedAt,
    @Default([]) List<Tag> tags,
    @Default([]) List<Note> backlinks,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}
```

### models/study_tool_generation.dart
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_tool_generation.freezed.dart';
part 'study_tool_generation.g.dart';

enum StudyToolType { flashcard, quiz, mindmap }
enum StudyToolStatus { pending, completed, failed }

@freezed
class StudyToolGeneration with _$StudyToolGeneration {
  const factory StudyToolGeneration({
    required String id,
    required String noteId,
    required StudyToolType type,
    required Map<String, dynamic> content,
    String? imageUrl,
    required StudyToolStatus status,
    required String createdAt,
  }) = _StudyToolGeneration;

  factory StudyToolGeneration.fromJson(Map<String, dynamic> json) =>
      _$StudyToolGenerationFromJson(json);
}
```

### models/user.dart
```dart
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    String? avatarUrl,
    String? lastOpenedNoteId,
    required String createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

---

## 8. Editor (flutter_quill)

### Note editor screen structure
```dart
// features/notes/screens/note_editor_screen.dart
class NoteEditorScreen extends ConsumerStatefulWidget {
  final String noteId;
  const NoteEditorScreen({required this.noteId, super.key});

  @override
  ConsumerState<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends ConsumerState<NoteEditorScreen> {
  late QuillController _controller;
  Timer? _saveTimer;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
    _controller.addListener(_onContentChanged);
    // Update last opened note silently
    ref.read(noteRepositoryProvider).updateLastOpened(widget.noteId);
  }

  void _onContentChanged() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 1500), _save);
  }

  Future<void> _save() async {
    final markdown = _quillToMarkdown(_controller);
    await ref.read(noteRepositoryProvider).updateNote(
      widget.noteId,
      content: markdown,
    );
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    _controller.removeListener(_onContentChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteAsync = ref.watch(noteProvider(widget.noteId));

    return noteAsync.when(
      loading: () => const LoadingSpinner(),
      error: (e, _) => ErrorState(message: e.toString()),
      data: (note) {
        // Initialize editor content once
        if (!_initialized) {
          _controller = QuillController(
            document: _markdownToDocument(note.content ?? ''),
            selection: const TextSelection.collapsed(offset: 0),
          );
          _controller.addListener(_onContentChanged);
          _initialized = true;
        }
        return _buildEditor(note);
      },
    );
  }

  Widget _buildEditor(Note note) {
    return Column(
      children: [
        EditorToolbar(controller: _controller, noteId: widget.noteId),
        Expanded(
          child: QuillEditor.basic(
            controller: _controller,
            configurations: const QuillEditorConfigurations(
              padding: EdgeInsets.all(16),
              placeholder: 'Start writing...',
            ),
          ),
        ),
        BacklinksPanel(backlinks: note.backlinks),
      ],
    );
  }
}
```

### [[Note]] linking in mobile editor
Handled via a custom toolbar button that shows an autocomplete bottom sheet:

```dart
// In EditorToolbar — [[Note]] link button
IconButton(
  icon: const Icon(Icons.link),
  onPressed: () => _showNoteLinkSheet(context),
)

void _showNoteLinkSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (_) => NoteLinkBottomSheet(
      onSelected: (Note selectedNote) async {
        // Insert link chip at cursor
        _controller.document.insert(
          _controller.selection.extentOffset,
          '\u{0020}[[${selectedNote.title}]]\u{0020}',
        );
        // Create link in backend
        await ref.read(noteRepositoryProvider).createLink(
          sourceNoteId: widget.noteId,
          targetNoteId: selectedNote.id,
        );
      },
    ),
  );
}
```

---

## 9. Real-time Client (Reverb)

### core/realtime/reverb_client.dart
```dart
import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reverbClientProvider = Provider<ReverbClient>((ref) {
  final storage = ref.read(localStorageProvider);
  return ReverbClient(storage);
});

class ReverbClient {
  final LocalStorage _storage;
  WebSocketChannel? _channel;
  final _eventController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get events => _eventController.stream;

  ReverbClient(this._storage);

  Future<void> connect(String userId) async {
    final token = await _storage.getToken();
    if (token == null) return;

    _channel = WebSocketChannel.connect(
      Uri.parse(
        '${AppConstants.reverbWsUrl}/app/${AppConstants.reverbKey}'
        '?protocol=7&client=dart&version=1.0',
      ),
    );

    // Subscribe to private user channel
    _channel!.sink.add(jsonEncode({
      'event': 'pusher:subscribe',
      'data': {
        'channel': 'private-user.$userId',
        'auth': await _getChannelAuth(userId, token),
      },
    }));

    _channel!.stream.listen((raw) {
      final data = jsonDecode(raw as String) as Map<String, dynamic>;
      _eventController.add(data);
    });
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }

  Future<String> _getChannelAuth(String userId, String token) async {
    // Call Laravel /broadcasting/auth to get signed auth string
    final dio = Dio();
    final res = await dio.post(
      '${AppConstants.apiBaseUrl}/broadcasting/auth',
      data: {'channel_name': 'private-user.$userId'},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return res.data['auth'] as String;
  }
}
```

### Listening for events in screens
```dart
// In NoteEditorScreen — listen for note.updated
@override
void initState() {
  super.initState();
  _listenForRealtime();
}

void _listenForRealtime() {
  final reverb = ref.read(reverbClientProvider);
  reverb.events.listen((event) {
    if (event['event'] != 'note.updated') return;
    final data = jsonDecode(event['data'] as String) as Map<String, dynamic>;
    if (data['note_id'] != widget.noteId) return;
    // Invalidate and re-fetch note
    ref.invalidate(noteProvider(widget.noteId));
  });
}

// In GenerationHistory widget — listen for studytool.ready
reverb.events.listen((event) {
  if (event['event'] != 'studytool.ready') return;
  final data = jsonDecode(event['data'] as String) as Map<String, dynamic>;
  if (data['note_id'] != noteId) return;
  ref.invalidate(studyToolListProvider(noteId));
});
```

---

## 10. File Uploads (Uploadthing)

Flutter uses the Uploadthing REST API directly since there is no official Dart SDK.

### Upload helper
```dart
// core/api/uploadthing_client.dart
import 'dart:io';
import 'package:dio/dio.dart';

class UploadthingClient {
  static const String _baseUrl = 'https://uploadthing.com/api';
  final Dio _dio = Dio();

  Future<String> uploadFile(File file, String token) async {
    final formData = FormData.fromMap({
      'files': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    final res = await _dio.post(
      '$_baseUrl/uploadFiles',
      data: formData,
      options: Options(
        headers: {
          'X-Uploadthing-Api-Key': AppConstants.uploadthingApiKey,
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final files = res.data['data'] as List<dynamic>;
    return files.first['url'] as String;
  }
}
```

### Usage in note editor
```dart
Future<void> _handleImagePick() async {
  final picker = ImagePicker();
  final picked = await picker.pickImage(source: ImageSource.gallery);
  if (picked == null) return;

  final token = await ref.read(localStorageProvider).getToken() ?? '';
  final url = await UploadthingClient().uploadFile(File(picked.path), token);

  // Save attachment record to Laravel
  await ref.read(attachmentRepositoryProvider).saveAttachment(
    noteId: widget.noteId,
    fileUrl: url,
    fileName: picked.name,
    fileType: 'image/jpeg',
  );

  // Insert image block into editor
  _controller.document.insert(
    _controller.selection.extentOffset,
    BlockEmbed.image(url),
  );
}
```

---

## 11. Push Notifications (FCM)

### features/notifications/notification_service.dart
```dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _local = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Request permission
    await _fcm.requestPermission(alert: true, badge: true, sound: true);

    // Initialize local notifications
    await _local.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_showLocalNotification);

    // Handle background tap (app was in background)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    await _local.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails('sinapsis_channel', 'Sinapsis'),
        iOS: DarwinNotificationDetails(),
      ),
      payload: message.data['note_id'],
    );
  }

  void _handleNotificationTap(RemoteMessage message) {
    final noteId = message.data['note_id'] as String?;
    if (noteId != null) {
      // Navigate to note
      appRouter.go('/notes/$noteId');
    }
  }

  // Schedule spaced repetition reminder
  Future<void> scheduleStudyReminder({
    required String noteTitle,
    required DateTime scheduledTime,
  }) async {
    await _local.zonedSchedule(
      scheduledTime.hashCode,
      'Time to review',
      'Review your notes on $noteTitle',
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails('sinapsis_reminders', 'Study Reminders'),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
```

---

## 12. Environment Configuration

### core/constants.dart
```dart
class AppConstants {
  // API
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.sinapsis.app',
  );

  // Reverb WebSocket
  static const String reverbWsUrl = String.fromEnvironment(
    'REVERB_WS_URL',
    defaultValue: 'wss://api.sinapsis.app',
  );
  static const String reverbKey = String.fromEnvironment(
    'REVERB_KEY',
    defaultValue: '',
  );

  // Uploadthing
  static const String uploadthingApiKey = String.fromEnvironment(
    'UPLOADTHING_API_KEY',
    defaultValue: '',
  );
}
```

**Pass environment variables at build time:**
```bash
flutter run \
  --dart-define=API_BASE_URL=https://api.sinapsis.app \
  --dart-define=REVERB_WS_URL=wss://api.sinapsis.app \
  --dart-define=REVERB_KEY=your_key \
  --dart-define=UPLOADTHING_API_KEY=your_key
```

**FCM configured via:**
- Android: `android/app/google-services.json`
- iOS: `ios/Runner/GoogleService-Info.plist`

---

## 13. Coding Conventions

### Naming
| Thing | Convention | Example |
|---|---|---|
| Classes | PascalCase | `NoteRepository` |
| Files | snake_case | `note_repository.dart` |
| Variables/methods | camelCase | `getNotes()` |
| Constants | camelCase in class | `AppConstants.apiBaseUrl` |
| Riverpod providers | camelCase + Provider suffix | `noteListNotifierProvider` |
| Screens | PascalCase + Screen suffix | `NoteEditorScreen` |
| Widgets | PascalCase | `NoteCard` |

### Rules
- Never call `ApiClient` directly from screens or providers — always go through a repository
- Never access `shared_preferences` directly — always go through `LocalStorage` wrapper
- All models must use `freezed` — no plain Dart classes for API data
- Run `build_runner` after every model or provider annotation change
- Always use `AsyncValue.when()` in screens to handle loading/error/data states
- `GoRouter` handles all navigation — never use `Navigator.push` directly
- The `ReverbClient` is a singleton via Riverpod — never create multiple instances
- Use `ref.invalidate()` to trigger re-fetches after mutations — never manually manage lists
- Dart 3.11 dot shorthand syntax is preferred: `.center` over `MainAxisAlignment.center`
- Generated files (`*.freezed.dart`, `*.g.dart`) must never be edited manually and should be in `.gitignore` patterns for reviews but committed to the repo

## IMPORTANT NOTES
This can be use as the main references, but its not strict and can be change or expanded, especially the code part. Just a reference for the structure and how things work.