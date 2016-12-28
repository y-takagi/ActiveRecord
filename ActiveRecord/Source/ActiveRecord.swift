import RealmSwift

open class ActiveRecord: Object, Base {
  public static var realm: Realm = try! Realm()
  public var errors: [String: String] = [:]

  public dynamic var id: String = UUID().uuidString
  public dynamic var createdAt: Date = Date()
  public dynamic var updatedAt: Date = Date()

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
