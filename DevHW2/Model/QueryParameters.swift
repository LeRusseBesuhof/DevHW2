import Foundation

struct QueryParameters {
    let name : Name
    let status : Status
    let gender : Gender
    
    init(name: Name, status: Status, gender: Gender) {
        self.name = name
        self.status = status
        self.gender = gender
    }
}

enum Name : String {
    case rick = "rick"
    case morty = "morty"
    case beth = "beth"
    case jerry = "jerry"
    case summer = "summer"
}

enum Status : String {
    case alive = "alive"
    case dead = "dead"
}

enum Gender : String {
    case male = "male"
    case female = "female"
}
