import RealmSwift

public protocol ObjectBase {
  associatedtype ObjectType: Object

  static var objects: Results<ObjectType> { get }
  static func find(_ primaryKey: Any) -> Self?
}

extension ObjectBase {
  public static var objects: Results<ObjectType> {
    return ActiveRecord.realm.objects(ObjectType.self)
  }

  public static func find(_ primaryKey: Any) -> Self? {
    return self.findFor(primaryKey) as? Self
  }

  private static func findFor<T: Object>(_ primaryKey: Any) -> T? {
    return ActiveRecord.realm.object(ofType: T.self, forPrimaryKey: primaryKey)
  }
}
