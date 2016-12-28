import RealmSwift

public protocol ObjectBase {
  associatedtype ModelType: Object

  static var objects: Results<ModelType> { get }
  static func find(_ primaryKey: Any) -> ModelType?
}

extension ObjectBase where Self: ActiveRecord {
  public static var objects: Results<ModelType> {
    return realm.objects(ModelType.self)
  }

  public static func find(_ primaryKey: Any) -> ModelType? {
    return realm.object(ofType: ModelType.self, forPrimaryKey: primaryKey)
  }
}
