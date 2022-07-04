import Foundation
import APIFetcher

public extension API {
    enum CurrentTime {
        case time
    }
}

extension API.CurrentTime: RequestRepresentable {
    
    public var baseURL: URL {
        return URL(string: "http://worldtimeapi.org/api")!
    }
    
    public var path: String {
        return "/timezone/Europe/Moscow"
    }
    
    public var method: HTTPMethod {
        return .get
    }
}
