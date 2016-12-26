import ActiveRecord
import RealmSwift

Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "TestDatabase"

class TestModel: ActiveRecord, ObjectBase {
  typealias ModelType = TestModel

  dynamic var name: String = ""
}

TestModel.objects.count

let model = TestModel()
model.name = "Hello, World"
try! model.save()

TestModel.objects.count

if let managed = TestModel.objects.first {
  managed.name

  let unmanaged = TestModel(value: managed)
  unmanaged.name = "Copy, World"
  try! unmanaged.save()
}

TestModel.objects.count

