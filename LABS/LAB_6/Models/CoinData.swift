
import Foundation

struct DataCoin: Decodable {
    let data: [Coin]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        data = try values.decode([Coin].self, forKey: .data)
    }
}




