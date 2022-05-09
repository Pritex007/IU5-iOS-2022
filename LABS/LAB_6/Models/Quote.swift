struct Quote: Decodable {
   
    let valute: Numbers
        
    enum CodingKeys: String, CodingKey {
        case valute = "USD"
    }
        
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        valute = try values.decode(Numbers.self, forKey: .valute)
    }
}
