import Foundation

struct Coin: Decodable {
    var baseId: String
    var quoteId: String
    var rate: Double
    
    enum CodingKeys: String, CodingKey {
        case baseId = "asset_id_base"
        case quoteId = "asset_id_quote"
        case rate
    }
}
