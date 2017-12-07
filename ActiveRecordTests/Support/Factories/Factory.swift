import ActiveRecord

protocol Factory {
  associatedtype ModelType: Base

  static func build(value: [String: Any]) -> ModelType
  static func create(value: [String: Any]) throws -> ModelType
}

extension Factory {
  static func create(value: [String: Any] = [:]) throws -> ModelType {
    let obj = build(value: value)
    try obj.save()
    return obj
  }
}
