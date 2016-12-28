import Realm
import RealmSwift

public protocol Base: Validations, Callbacks, Relationable {
  func save() throws
  func destroy() throws
  func destroyDependencies() -> [Relationable?]
}

extension Base where Self: ActiveRecord {
  public func save() throws {
    guard isValid() else { return }

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

  public func cascadingDestroy() throws {
    try destroyDependencies().forEach { try $0?.cascadingDestroy() }
    type(of: self).realm.delete(self)
  }
}
