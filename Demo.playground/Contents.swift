import ActiveRecord
import RealmSwift

Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "TestDatabase"

class Owner: ActiveRecord, ObjectBase {
  typealias ModelType = Owner

  dynamic var name: String = ""
  dynamic var car: Car?
  let pets = List<Pet>()

  override func destroyDependencies() -> [Any?] {
    return [car, pets]
  }
}

class Car: ActiveRecord, ObjectBase {
  typealias ModelType = Car

  dynamic var name: String = ""
  let owner = LinkingObjects(fromType: Owner.self, property: "car").first
}

class Pet: ActiveRecord, ObjectBase {
  typealias ModelType = Pet

  dynamic var name: String = ""
  let owner = LinkingObjects(fromType: Owner.self, property: "pets").first
}

/*
 * Cascading destroy
 */
let pet = Pet()
pet.name = "Feyris"
let car = Car()
car.name = "BMW"

let owner = Owner()
owner.name = "Tarou"
owner.car = car
owner.pets.append(pet)
try! owner.save()

Owner.objects.count
Car.objects.count
Pet.objects.count

try! owner.destroy()

Owner.objects.count
Car.objects.count
Pet.objects.count
