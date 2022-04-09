import CoreData
import Foundation

extension QuoteModel {
    static func convert(dto: Quote, into context: NSManagedObjectContext) -> QuoteModel {
        let model = QuoteModel(context: context)
        model.valute = NumbersModel.convert(dto: dto.valute, into: context)
        return model
    }
    
    func convertToDTO() -> Quote {
        Quote(valute: valute?.convertToDTO() ?? Numbers(price: 0,
                                                        percentChange1H: 0,
                                                        priceChange1H: 0))
    }
}
