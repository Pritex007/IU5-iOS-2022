import CoreData
import Foundation

extension CoinModel {
    static func convert(dto: Coin, into context: NSManagedObjectContext) -> CoinModel {
        let model = CoinModel(context: context)
        model.quote = QuoteModel.convert(dto: dto.quoteData, into: context)
        model.subtitle = dto.subtitle
        model.title = dto.title
        return model
    }
    
    func convertToDTO() -> Coin {
        Coin(title: title ?? "",
             subtitle: subtitle ?? "",
             quote: quote?.convertToDTO() ?? Quote(valute: Numbers(price: 0,
                                                                   percentChange1H: 0,
                                                                   priceChange1H: 0)))
    }
}
