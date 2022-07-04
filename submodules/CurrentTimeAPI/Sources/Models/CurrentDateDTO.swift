import Foundation

public struct CurrentDateDTO: Decodable {
    public let unixtime: TimeInterval
    
    enum CodingKeys: String, CodingKey {
        case unixtime
    }
}
