import Foundation
import SwiftSignalKit

public protocol APIFetcher: AnyObject {
    func execute<T: Decodable>(request: RequestRepresentable) -> Signal<T, Error>
}

public final class APIFetcherImp: APIFetcher {
    
    public init() { }
    
    public func execute<T: Decodable>(request: RequestRepresentable) -> Signal<T, Error> {
        return Signal { [weak self] subscriber in
            if let strongSelf = self {
                strongSelf.execute(request: request) { (result: Result<T, Error>) in
                    switch result {
                    case .success(let object):
                        subscriber.putNext(object)
                    case .failure(let error):
                        subscriber.putError(error)
                    }
                    subscriber.putCompletion()
                }
            }
            return EmptyDisposable
        }
    }
    
    private func execute<T: Decodable>(request: RequestRepresentable, completion: @escaping (Result<T, Error>) -> Void) {
        var urlRequest = URLRequest(url: request.baseURL.appendingPathComponent(request.path))
        urlRequest.httpMethod = request.method.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, let httpURLResponse = response as? HTTPURLResponse, 200...299 ~= httpURLResponse.statusCode else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.undefined))
                }
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}
