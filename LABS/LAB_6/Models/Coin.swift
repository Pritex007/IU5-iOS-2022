struct Coin: Decodable {
    let title: String
    let subtitle: String
    let quoteData: Quote
    
    enum CodingKeys: String, CodingKey {
        case title = "symbol"
        case subtitle = "name"
        case quoteData = "quote"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try values.decode(String.self, forKey: .title)
        subtitle = try values.decode(String.self, forKey: .subtitle)
        quoteData = try values.decode(Quote.self, forKey: .quoteData)
    }
    
    init(title: String, subtitle: String, quote: Quote) {
        self.title = title
        self.subtitle = subtitle
        self.quoteData = quote
    }
}
