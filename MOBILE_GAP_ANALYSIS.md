# Sinapsis Mobile — Gap Analysis & Implementation Plan

> Comparison of the Flutter mobile app (`sinapsis_mobile/`) against the
> feature-complete Next.js web app (`sinapsis-frontend/`).
> Goal: bring mobile to feature parity.

**Last updated:** 2026-06-18

---

## 1. Tech Stack Reference

| Concern | Web (`sinapsis-frontend`) | Mobile (`sinapsis_mobile`) |
|---|---|---|
| Framework | Next.js 16 (App Router) | Flutter 3.38+ / Dart 3.7+ |
| State | Zustand + TanStack Query | Riverpod 3.x (codegen) |
| Routing | App Router | GoRouter 17 (`lib/core/router/app_router.dart`) |
| HTTP | fetch wrapper (`lib/api.ts`) | Dio (`lib/core/api/api_client.dart`) |
| Editor | **Tiptap → HTML** | **flutter_quill → JSON Delta** ⚠️ |
| Real-time | Laravel Echo + Reverb | Reverb client present (`lib/core/realtime/reverb_client.dart`), not wired |
| AI gen | OpenRouter via `/api/ai/*` route handlers | none (fetch-only) |

API base: mobile uses `${API_BASE_URL}/api/v1`; all endpoints are already
declared in `lib/core/api/api_endpoints.dart`.

---

## 2. Status Matrix

| Feature | Screens | API | Provider | Models | Verdict |
|---|---|---|---|---|---|
| Auth | ✅ | ✅ | ✅ | ✅ | **Parity** |
| Notes CRUD | ✅ | ✅ | ✅ | ✅ | **Parity** |
| Folders | ✅ | ✅ | ✅ | ✅ | **Parity** |
| Trash | ✅ | ✅ | ✅ | ✅ | **Parity** |
| Tags | ❌ | ✅ | ❌ | ✅ | **Gap — quick win** |
| Search | ❌ | ✅ (`/notes?search=`) | ❌ | ✅ | **Gap** |
| Study Tools (flashcard/quiz/mindmap) | 🟡 stubs | ✅ | ✅ | ✅ | **Gap — high value** |
| Sharing / Publish | ❌ | 🟡 endpoint only | ❌ | 🟡 fields only | **Gap** |
| Attachments | ❌ | endpoints declared | ❌ | ✅ | **Gap** |
| Backlinks / `[[wiki]]` links | ❌ | 🟡 endpoints declared | ❌ | ✅ (in Note) | **Gap** |
| Home dashboard stats | 🟡 partial | ✅ | ✅ | ✅ | **Minor gap** |
| Real-time sync | ❌ wiring | n/a | ❌ | n/a | **Gap** |
| Notification center / deep-link | 🟡 infra only | ✅ FCM | n/a | n/a | **Gap** |
| Settings screen | ❌ | n/a | n/a | n/a | **Gap** |

Legend: ✅ done · 🟡 partial · ❌ missing

---

## 3. Cross-cutting Caveat — Editor Content Format ⚠️

**This is the most important issue and blocks true parity.**

- Web stores note `content` as **HTML** (Tiptap output).
- Mobile stores `content` as **Quill JSON Delta**
  (`lib/features/notes/screens/note_editor_screen.dart:73` —
  `jsonEncode(_quillController.document.toDelta().toJson())`).

A note authored on web renders as raw HTML text inside Quill (Quill cannot parse
HTML natively), and a note authored on mobile shows raw Delta JSON on web. They
are **not interchangeable**. The reader (`note_view_screen.dart`) does
`Document.fromJson(...)` and will throw / fallback on web-authored HTML.

A dedicated **Context7 research section** on solutions is at the end of this
document (§6).

---

## 4. Implementation Plan (ordered by value ÷ effort)

Each feature follows the established pattern:
`models/` (exists) → `features/<x>/data/<x>_repository.dart` →
`features/<x>/providers/<x>_provider.dart` → `features/<x>/screens|widgets/` →
register route in `lib/core/router/app_router.dart`.

> After touching any `@riverpod` provider or Freezed model, run:
> `dart run build_runner build --delete-conflicting-outputs`

---

### Phase 1 — Tags (quick win, backend fully wired) ✅ DONE (2026-06-18)

> Implemented: `tag_provider.dart`, `tag_chip.dart`, `tag_selector_sheet.dart`,
> `tag_manage_screen.dart`; routes `/tags` + `/tags/:id`; drawer entry; tag chips
> + selector in note viewer; `NoteListScreen` extended with `tagId`/`title`.
> Codegen + `flutter analyze` clean.


**Why first:** `TagRepository` already exists (`lib/features/tags/data/tag_repository.dart`),
model exists (`lib/models/tag.dart`). Only provider + UI missing.

**Files to create:**
- `lib/features/tags/providers/tag_provider.dart`
  - `tagListProvider` (AsyncNotifier) → `getTags()`
  - methods: `createTag(name, color?)`, `deleteTag(id)`,
    `attachTag(noteId, tagId)`, `detachTag(noteId, tagId)`
- `lib/features/tags/screens/tag_manage_screen.dart` — list + create/delete tags (color swatch)
- `lib/features/tags/widgets/tag_chip.dart` — colored chip
- `lib/features/tags/widgets/tag_selector_sheet.dart` — bottom sheet to attach/detach on a note

**Files to edit:**
- `lib/core/router/app_router.dart` — add `/tags` route
- `lib/core/shell/app_drawer.dart` — add "Tags" nav entry + filter-by-tag
  (note list already supports `tagId` via `noteListProvider`)
- `lib/features/notes/screens/note_view_screen.dart` — render tag chips
- `lib/features/notes/screens/note_editor_screen.dart` — add tag selector button

**Endpoints (declared):** `tags`, `tag(id)`, `noteTagsUrl(id)`, `noteTagDetach(id, tagId)`

---

### Phase 2 — Search (small, high utility)

**Files to create:**
- `lib/features/notes/screens/search_screen.dart` — search field + debounced results list
- `lib/features/notes/providers/search_provider.dart` —
  `searchNotesProvider(query)` → `GET /notes?search=`
  (reuse `NoteRepository.getNotes(search: ...)`)

**Files to edit:**
- `lib/core/router/app_router.dart` — add `/search`
- `lib/features/notes/screens/home_screen.dart` — add search icon in AppBar
- `lib/core/shell/app_drawer.dart` — add "Search" nav entry

---

### Phase 3 — Study Tools UI (highest user value)

**Decision required first:** *Who generates content?*
- Web generates client-side via OpenRouter (`/api/ai/*`) then POSTs the record.
- Mobile has **fetch-only** repo (`StudyToolRepository`: `getGenerations`, `getGeneration`).

**Recommendation:** Let the **backend own generation** (mobile should not embed an
OpenRouter key). Mobile flow: `POST /notes/:id/study-tools` (create job) →
poll `studyToolStatus(id)` until `completed` → `getGeneration(id)` → render.
*Confirm the backend exposes a create+generate endpoint; if not, this is a
backend dependency.*

**Existing stubs to implement:**
- `lib/features/study/screens/flashcard_screen.dart` — flip-card carousel
  (`FlashCard{question, answer}`, `FlashcardContent.cards[]`)
- `lib/features/study/screens/quiz_screen.dart` — MCQ render + scoring
  (`QuizQuestion{question, options[], correctIndex, explanation}`)
- `lib/features/study/screens/mindmap_screen.dart` — tree/graph render
  (`MindMapNode{label, children[]}`); consider `graphview` package

**Files to create:**
- `lib/features/study/widgets/generation_options_sheet.dart` — params dialog
  (amount/difficulty/depth/focus — mirror web)
- `lib/features/study/widgets/generation_history_list.dart`
- Extend `lib/features/study/data/study_tool_repository.dart` with
  `createGeneration(noteId, type, options)` + `getStatus(id)`
- Extend `lib/features/study/providers/study_tool_provider.dart` with a
  status-polling notifier

**Files to edit:**
- `lib/features/notes/screens/note_view_screen.dart` — "Study Tools" entry point
- Routes already exist in `app_router.dart` (flashcard/quiz/mindmap)

**Models:** already complete in `lib/models/study_tool_generation.dart`.

---

### Phase 4 — Sharing / Publish

**Files to create:**
- `lib/features/sharing/data/sharing_repository.dart` —
  `publish(noteId)`, `unpublish(noteId)`, `getShared(token)`
- `lib/features/sharing/providers/sharing_provider.dart`
- `lib/features/sharing/widgets/share_sheet.dart` — toggle publish + copy link
  (`{webOrigin}/shared/{token}`)
- `lib/features/sharing/screens/shared_note_screen.dart` — public read-only viewer

**Files to edit:**
- `lib/core/router/app_router.dart` — add public `/shared/:token` route
  (must bypass the auth redirect guard — adjust `redirect` in `router()`)
- `lib/features/notes/screens/note_view_screen.dart` — share button
- `lib/models/note.dart` already has `isPublished`, `shareToken`

**Endpoints:** `notePublish(id)` (POST/DELETE), `shared(token)` (GET, no auth)

---

### Phase 5 — Attachments

**Files to create:**
- `lib/features/attachments/data/attachment_repository.dart` —
  list/upload(multipart)/delete (model: `lib/models/attachment.dart`)
- `lib/features/attachments/providers/attachment_provider.dart`
- `lib/features/attachments/widgets/attachment_panel.dart`

**Files to edit:**
- `lib/core/api/api_client.dart` — confirm multipart/`FormData` upload support
- `lib/features/notes/screens/note_view_screen.dart` / editor — attachment panel
- add deps: `file_picker`, `image_picker`, `open_filex` (pubspec.yaml)

**Endpoints:** `noteAttachments(id)`, `attachment(id)`

---

### Phase 6 — Backlinks & `[[wiki]]` links

**Files to create:**
- `lib/features/notes/widgets/backlinks_panel.dart`
- provider method: `noteBacklinksProvider(id)` → `noteBacklinks(id)`

**Files to edit:**
- `lib/features/notes/data/note_repository.dart` — `getBacklinks`, `createLink`,
  `deleteLink` (createLink/deleteLink already noted as wired)
- `lib/features/notes/screens/note_view_screen.dart` — backlinks section
- Editor: `[[note-title]]` autocomplete — non-trivial in Quill (custom embed);
  defer until §6 editor decision is made.

**Endpoints:** `noteBacklinks(id)`, `noteLinks(id)`, `noteLink(id, target)`

---

### Phase 7 — Real-time sync (Reverb)

**Files to edit:**
- `lib/core/realtime/reverb_client.dart` — already present; wire subscription
- Subscribe to user channel `App.Models.User.{id}` + per-note `note.{id}`
- On `note.updated/created/deleted` → `ref.invalidate(noteListProvider/noteDetailProvider)`
- On `studytool.ready` → invalidate study tool providers
- Env: `REVERB_WS_URL`, `REVERB_KEY` already in `.env`

---

### Phase 8 — Polish

- **Home dashboard stats** — note/folder counts + recent grid
  (`lib/features/notes/screens/home_screen.dart`)
- **Settings screen** — `lib/features/settings/screens/settings_screen.dart`
  (theme toggle, account, logout, notification prefs) + `/settings` route
- **Notification deep-linking** — `lib/features/notifications/notification_service.dart`:
  tap → navigate to note; add in-app notification center
- **Folder rename** UI (create/delete exist)

---

## 5. Suggested Sequencing

```
Phase 1 Tags ──► Phase 2 Search ──► Phase 3 Study Tools ──► Phase 4 Sharing
                                          │
                                          └─ (resolve §6 editor format first if
                                             Study Tools must read web notes)
Phase 5 Attachments ─► Phase 6 Backlinks ─► Phase 7 Real-time ─► Phase 8 Polish
```

Editor-format fix (§6) should be scheduled **before** Backlinks (Phase 6) and any
feature that must faithfully render web-authored notes.

---

## 6. Editor Caveat — Research & Recommended Solution

### 6.1 The problem (recap)

- **Web → DB:** Tiptap serializes to **HTML**.
- **Mobile → DB:** flutter_quill serializes to **Quill Delta JSON**.
- The same `note.content` column holds two incompatible formats. flutter_quill
  cannot natively read HTML, and Tiptap cannot read Delta JSON. Per the official
  flutter_quill docs: *"It is not recommended to store Delta as HTML… Converting
  Delta to/from HTML is not a standard feature in Quill JS or Flutter Quill."*

### 6.2 Options considered

| Option | Description | Verdict |
|---|---|---|
| **A. Bridge at mobile boundary** (recommended) | Keep DB as **HTML** (web's format = source of truth). Mobile converts HTML→Delta on load and Delta→HTML on save, using community packages. | ✅ Lowest blast radius — web untouched, DB schema untouched |
| B. Switch DB to Delta JSON | Make Delta the canonical format; web converts instead. | ❌ Requires rewriting the mature Tiptap web editor + migrating existing notes |
| C. Dual-format column | Store both / store format flag. | ❌ Sync drift, doubles write logic |
| D. Markdown as interchange | Both sides convert to/from Markdown. | ⚠️ Lossy for highlights, alignment, embeds; viable only if rich features are dropped |

### 6.3 Recommended solution — Option A (convert at the mobile boundary)

Two maintained Dart packages handle the round-trip (both explicitly listed in
the official flutter_quill README under "Delta Conversion"):

- **HTML → Delta:** [`flutter_quill_delta_from_html`](https://pub.dev/packages/flutter_quill_delta_from_html)
  — supports bold/italic/underline/strike, sub/superscript, h1–h6, alignment,
  links, images, lists.
- **Delta → HTML:** [`vsc_quill_delta_to_html`](https://pub.dev/packages/vsc_quill_delta_to_html)
  — the standard Delta→HTML converter.

**pubspec.yaml additions:**
```yaml
dependencies:
  flutter_quill_delta_from_html: ^1.5.0   # HTML -> Delta (verify latest on pub.dev)
  vsc_quill_delta_to_html: ^1.0.5         # Delta -> HTML (verify latest)
```

**Create a converter utility** — `lib/core/editor/content_converter.dart`:
```dart
import 'dart:convert';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class ContentConverter {
  /// Backend stores HTML (Tiptap). Convert to a Quill Document for editing.
  static Document htmlToDocument(String html) {
    final delta = HtmlToDelta().convert(html);
    return Document.fromDelta(delta);
  }

  /// Convert the edited Quill Document back to HTML for the backend.
  static String documentToHtml(Document doc) {
    final converter = QuillDeltaToHtmlConverter(
      doc.toDelta().toJson().cast<Map<String, dynamic>>(),
    );
    return converter.convert();
  }
}
```

**Files to edit (replace the raw Delta JSON round-trip):**
- `lib/features/notes/screens/note_editor_screen.dart`
  - `initState` (line ~37–51): replace `Document.fromJson(jsonDecode(initialContent))`
    with `ContentConverter.htmlToDocument(widget.initialContent!)`
  - `_saveNote` (line ~73): replace
    `jsonEncode(_quillController.document.toDelta().toJson())`
    with `ContentConverter.documentToHtml(_quillController.document)`
- `lib/features/notes/screens/note_view_screen.dart`
  - wherever it does `Document.fromJson(...)` → use `ContentConverter.htmlToDocument(...)`

**Caveats to verify during implementation:**
1. **Lossiness** — round-tripping HTML→Delta→HTML may normalize markup. Test
   with real web-authored notes (especially highlights, code blocks, nested lists,
   the `[[wiki]]` link spans, and uploaded images).
2. **Custom Tiptap extensions** — web uses custom nodes (`[[note]]` backlinks,
   color highlight, image-upload node). These produce non-standard HTML/attributes
   the converter may drop. May need a `customBlocks` handler in `HtmlToDelta`
   (the package supports `blackNodesList` and custom block handlers).
3. **Migration of existing notes** — any notes already saved by mobile in raw
   Delta JSON must be detected (try-parse) and migrated, or the viewer must
   sniff format (`content.trimLeft().startsWith('[') || startsWith('{')` → Delta,
   else HTML) during a transition window.

### 6.4 Recommended sequencing for the editor fix

1. Add the two packages + `ContentConverter` utility.
2. Wire it into viewer + editor; add a format-sniffing fallback for legacy Delta notes.
3. Test round-trip against a set of real web notes; log/triage lossy cases.
4. (Optional) Add custom block handlers for Tiptap-specific nodes once Backlinks
   (Phase 6) is scoped.

</content>
</invoke>
