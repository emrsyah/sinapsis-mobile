class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';
  static const String lastOpened = '/auth/me/last-opened';

  // Native Google sign-in: exchange a Google ID token for a Sanctum token.
  static const String googleToken = '/auth/google/token';

  // Notes
  static const String notes = '/notes';
  static const String notesTrashed = '/notes/trash';
  static String note(String id) => '/notes/$id';
  static String noteRestore(String id) => '/notes/$id/restore';
  static String noteForce(String id) => '/notes/$id/force';
  static String notePublish(String id) => '/notes/$id/publish';

  // Note sub-resources
  static String noteBacklinks(String id) => '/notes/$id/backlinks';
  static String noteLinks(String id) => '/notes/$id/links';
  static String noteLink(String id, String target) =>
      '/notes/$id/links/$target';
  static String noteAttachments(String id) => '/notes/$id/attachments';
  static String noteStudyTools(String id) => '/notes/$id/study-tools';
  // Backend expects the tag id in the path: POST/DELETE /notes/{note}/tags/{tag}
  static String noteTagAttach(String id, String tagId) =>
      '/notes/$id/tags/$tagId';
  static String noteTagDetach(String id, String tagId) =>
      '/notes/$id/tags/$tagId';

  // Folders
  static const String folders = '/folders';
  static String folder(String id) => '/folders/$id';

  // Tags
  static const String tags = '/tags';
  static String tag(String id) => '/tags/$id';

  // Study tools
  static String studyTool(String id) => '/study-tools/$id';
  static String studyToolStatus(String id) => '/study-tools/$id/status';

  // Attachments
  static String attachment(String id) => '/attachments/$id';

  // Public
  static String shared(String token) => '/shared/$token';
}
