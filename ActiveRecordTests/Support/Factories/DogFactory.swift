struct DogFactory: Factory {
  typealias ModelType = Dog

  static func build(value: [String: Any] = [:]) -> Dog {
    let name = value["name"] as? String

    let dog = Dog()
    dog.name = name ?? "John"
    return dog
  }
}
