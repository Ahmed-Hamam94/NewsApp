//
//  NetworkManager.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 31/10/2023.
//

import Foundation

final class NetworkManager {
    
//  static let shared = NetworkManager()
//    
//    private init(){
//        
//    }
 
    
    private func createRequest(endPoint: EndPoint,method: Methods,parameter: [String:Any]? = nil) -> URLRequest?{
        
        let url = EndPoint.base_url + endPoint.path
        guard let urll = url.encodeUrl().asURL else{return nil}
        print(urll)
        var urlRequest = URLRequest(url: urll)
       let headers = ["Content-Type": "application/json"]
    
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = "\(method)"
        
        if let parameter = parameter {
            switch method {
            case .Get:
                var urlComponent = URLComponents(string: url)
                urlComponent?.queryItems = parameter.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
            case .Post, .Delete, .Patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: parameter, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        print(parameter)
        return urlRequest
        
    }
    
     func request<T: Codable>(endPoint: EndPoint,method: Methods,parameters: [String: Any]? = nil,completion: @escaping(Result<T, APIError>) -> Void) {
        guard let request = createRequest(endPoint: endPoint, method: method,parameter: parameters) else {
            completion(.failure(APIError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            var result: Result<Data, Error>?
            
            if let data = data {
                result = .success(data)
               
                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
          //  print("The response is:\n\(responseString)")
                
            } else if let error = error {
                result = .failure(error)
                print("The error is: \(error.localizedDescription)")
            }
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")

            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }
    
    ///
    private func handleResponse<T: Codable>(result: Result<Data, Error>?,
                                            completion: (Result<T, APIError>) -> Void) {
        guard let result = result else {
            completion(.failure(APIError.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
              //  print(data)
                completion(.failure(APIError.errorDecoding))
                return
            }
           
            //        if let error = response. {
            //            completion(.failure(APIError.serverError))
            //            return
            //        }
            
            if let decodedData = response.articles {
             //  print(decodedData)
                completion(.success(decodedData))
            } else {
                completion(.failure(APIError.errorDecoding))
            }
        case .failure(let error):
            print("error@@@\(error.localizedDescription)")
            completion(.failure(APIError.parsingError))
            
        }
    }
    
}
