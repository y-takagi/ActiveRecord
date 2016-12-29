struct PersonFactory: Factory {
  typealias ModelType = Person

  static func build(value: [String: Any] = [:]) -> Person {
    let name = value["name"] as? String
    let age = value["age"] as? Int
    let tel = value["tel"] as? String
    let car = value["car"] as? [String: Any]

    let person = Person()
    person.name = name ?? "Tarou"
    person.age = age ?? 12
    person.tel = tel ?? "080-1122-3344"
    person.car = CarFactory.build(value: car ?? [:])
    return person
  }

  static func createAll() throws -> Person {
    let person = PersonFactory.build()
    let dog = DogFactory.build()
    person.dogs.append(dog)
    try person.save()
    return person
  }
}
