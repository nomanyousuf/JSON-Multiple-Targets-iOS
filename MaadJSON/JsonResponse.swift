import Foundation
import UIKit



enum objectError:Error{
    case noDataAvailable
    case canNotProcessData
}


struct jsonRequest{
        
        let resourceURL:URL
    
    init() {
        
        var getAppURL: String {
            #if ipad
            return "https://api.duckduckgo.com/?q=the+wire+characters&format=json"
            #else
            return "https://api.duckduckgo.com/?q=simpsons+characters&format=json"
            #endif
        }
        
        guard let resourceURL = URL(string: getAppURL) else {fatalError()}
        self.resourceURL = resourceURL
    }


    func getRelatedRecords(completion: @escaping(Result<[RelatedTopic], objectError>) ->  Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in

            guard let jsonData = data else{
                completion(.failure(.noDataAvailable))
                return
            }


            do {
                let decorder = JSONDecoder()
                let objectResponse = try decorder.decode(Welcome.self, from: jsonData)
                let objectResponseAnother = objectResponse.relatedTopics
                completion(.success(objectResponseAnother))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }

}



