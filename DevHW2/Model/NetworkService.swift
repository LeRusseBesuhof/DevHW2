import Foundation

protocol NetworkProtocol : AnyObject {
    var url : URL! { get set }
    var request : URLRequest? { get set }
    func sendRequest(_ params: QueryParameters, completion: @escaping ([Character]) -> Void) -> Void
}

final class NetworkService : NetworkProtocol {
    
    internal var url: URL!
    
    // https://rickandmortyapi.com/api/character/
    
    internal var request: URLRequest?
    
    internal func sendRequest(_ params: QueryParameters, completion: @escaping ([Character]) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "rickandmortyapi.com"
        urlComponents.path = "/api/character/"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "name", value: params.name.rawValue),
            URLQueryItem(name: "status", value: params.status.rawValue)
        ]
        
        url = urlComponents.url
        request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request!) { data, response, err in
            guard err == nil else { print(err!.localizedDescription); return }
            
            if let jsonData = data {
                do {
                    let dataResponse = try JSONDecoder().decode(Result.self, from: jsonData)
                    
                    completion(dataResponse.results)
                    
                } catch {
                    print("no such data!")
                    print(err!.localizedDescription)
                }
            }
        }.resume()
    }
    
}

struct Result : Decodable {
    let results : [Character]
}

struct Character : Decodable {
    let name : String?
    let status : String?
    let gender : String?
    let image : String?
}
