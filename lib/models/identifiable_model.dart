library models;

/// Base Class for all Models that have to be stored
abstract class IdentifiableModel {
  /// The Identifier which is used to identify the Beginning or
  /// a new Instance of this Object in the Storage
  final String identifier;

  /// Used to separate the single fields of an Object while reading
  /// it from the Storage
  /// Usually an [RegExp]
  final Pattern regExp;

  const IdentifiableModel(this.identifier, this.regExp);
}
