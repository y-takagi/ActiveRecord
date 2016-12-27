import Realm
import RealmSwift

public protocol Base: Validations, Callbacks {
  func save() throws
  func destroy() throws
  func destroyDependencies() -> [Any?]
}

extension Base where Self: ActiveRecord {
  public func save() throws {
    try type(of: self).realm.write {
      self.updatedAt = Date()
      type(of: self).realm.add(self, update: true)
    }
  }

  public func destroy() throws {
    try type(of: self).realm.write {
      try cascadingDestroy()
    }
  }

  private func cascadingDestroy() throws {
    try destroyDependencies().forEach { object in
      switch object {
      case let rel as ActiveRecord:
        try rel.cascadingDestroy()
      case let rels as Collectable:
        try rels.all.forEach {
          if let obj = $0 as? ActiveRecord {
            try obj.cascadingDestroy()
          }
        }
      default:
        assertionFailure("destroyDependecies() should return [ActiveRecord | List<ActiveRecord>]")
      }
    }
    type(of: self).realm.delete(self)
  }
}
