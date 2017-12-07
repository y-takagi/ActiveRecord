import RealmSwift

open class ActiveRecord: Object, Relationable {
  public static var realm: Realm = try! Realm()
  public var errors: [String: String] = [:]

  @objc public dynamic var id: String = UUID().uuidString
  @objc public dynamic var createdAt: Date = Date()
  @objc public dynamic var updatedAt: Date = Date()

  override open static func primaryKey() -> String? {
    return "id"
  }

  override open static func ignoredProperties() -> [String] {
    return ["errors"]
  }

  open func destroyDependencies() -> [Relationable?] {
    return []
  }

  open func runValidateCallbacks() {
  }
}
