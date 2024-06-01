import Foundation

struct QueryParameters {
    let name : Name
    let status : Status
    
    init(name: Name, status: Status) {
        self.name = name
        self.status = status
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
