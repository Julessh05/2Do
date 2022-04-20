library exceptions;

/// Exception thrown when you try to duplicate a Tag
/// or try to add a Tag that has already been added
class DuplicateTagException implements Exception {
  const DuplicateTagException({
    this.message = '',
  });

  final String? message;
}
