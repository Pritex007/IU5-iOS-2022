struct Numbers: Decodable {
    let price: Double
    let percentChange1H: Double
    let priceChange1H: Double
        
    enum CodingKeys: String, CodingKey {
        case price
        case percentChange1H
    }
        
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        price = try values.decode(Double.self, forKey: .price)
        percentChange1H = try values.decode(Double.self, forKey: .percentChange1H)
        priceChange1H = (price / (1 + percentChange1H / 100)) * percentChange1H / 100
    }
    
    init(price: Double,
     percentChange1H: Double,
     priceChange1H: Double) {
        self.price = price
        self.percentChange1H = percentChange1H
        self.priceChange1H = priceChange1H

    }
}
