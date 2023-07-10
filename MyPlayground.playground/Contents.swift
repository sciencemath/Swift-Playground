let celsiuis = 15.0;
print("Celsiuis: \(celsiuis)°C Fahrenheit: \(((celsiuis * 9) / 5) + 32)°F")

let myArray: [String] = ["string1", "string2", "string3", "string1"]
print(myArray.count)
let mySet: Set<String> = Set(myArray);
print(mySet.count)

// possibly easier to reason about than a if/ifelse/ifelse/else
// could have also used built in method `isMutiple(of:)`
for i in 1...100 {
    if i % 3 == 0 && i % 5 == 0 {
        print("FizzBuzz")
        continue
    }
    
    if i % 3 == 0 {
        print("Fizz")
        continue
    }
    
    if i % 5 == 0 {
        print("Buzz")
        continue
    }
    
    print(i)
}
/**
 * Checkpoint 4
 */
enum SquareNumber: Error {
    case outOfBounds
    case noRoot
}

func integerSquareRoot(_ number: Int) throws -> Int {
    var counter = 1
    if number < 1 || number > 10_000 {
        throw SquareNumber.outOfBounds
    }
    
    for i in 1...100 {
        if i * counter == number {
            return i
        }
        counter += 1
    }
    
    throw SquareNumber.noRoot
}

do {
    try integerSquareRoot(100)
} catch SquareNumber.noRoot {
    print("No root has been found")
} catch SquareNumber.outOfBounds {
    print("This function accepts numbers above 1 and below 10_000")
}

/**
 * Checkpoint 5
 */
let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
let formattedNumbers = luckyNumbers.filter { $0 % 2 != 0 }
    .sorted { $0 < $1 }
    .map { "\($0) is a lucky number" }
    .joined(separator: "\n")

print(formattedNumbers)

/**
 * Checkpoint 6
 */
struct Car {
    let model: String
    let numberOfSeats: Int
    static var currentGear: Int = 1 // maybe private(set)
    
    init(model: String, seats: Int) {
        self.model = model
        self.numberOfSeats = seats
    }
    
    mutating func changeGears(_ dir: String) {
        if Car.currentGear < 1 || Car.currentGear > 10 {
            print("Invalid Gear, either you went below 1 or over 10")
            return
        }
        
        if dir == "up" {
            Car.currentGear += 1
            return
        }
        
        Car.currentGear -= 1
    }
}

var myNewCar = Car(model: "Toyota", seats: 15)
myNewCar.changeGears("up")
myNewCar.changeGears("down")
myNewCar.changeGears("up")
myNewCar.changeGears("up")
print(Car.currentGear)
var myOtherNewCar = Car(model: "Tesla", seats: 2)
print(Car.currentGear)

/**
 * Checkpoint 7
 */
class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    init() {
        super.init(legs: 4)
    }
    func speak() {
        print("dog barking")
    }
}

class Corgi: Dog {
    override func speak() {
        print("bark I am a corgi")
    }
}

class Poodle: Dog {
    override func speak() {
        print("bark I am a poodle")
    }
}

class Cat: Animal {
    var isTame: Bool
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
    func speak() {
        print("cat meowing")
    }
}

class Persian: Cat {
    override func speak() {
        print("meow I am a persian")
    }
}

class Lion: Cat {
    override func speak() {
        print("meow I am a lion")
    }
}

/**
 * Checkpoint 8
 */
protocol Building {
    var rooms: Int {get set}
    var cost: Int {get set}
    var estateAgent: String {get set}
    func salesSummary()
}

struct House: Building {
    var rooms = 0
    var cost = 0
    var estateAgent: String
    func salesSummary() {
        print("building house summary: rooms \(rooms) cost \(cost) agent \(estateAgent)")
    }
}

struct Office: Building {
    var rooms = 0
    var cost = 0
    var estateAgent: String
    func salesSummary() {
        print("building office summary: rooms \(rooms) cost \(cost) agent \(estateAgent)")
    }
}

let office = Office(rooms: 1, cost: 34_000_000, estateAgent: "Mathias")
print(office.salesSummary())

/**
 * Checkpoint 9
 */
func randomInt(_ numbers: [Int]?) -> Int { numbers?.randomElement() ?? Int.random(in: 1...100) }
print(randomInt([]))
