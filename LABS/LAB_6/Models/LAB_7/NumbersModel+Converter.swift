import CoreData
import Foundation

extension NumbersModel {
    static func convert(dto: Numbers, into context: NSManagedObjectContext) -> NumbersModel {
        let model = NumbersModel(context: context)
        model.percentChange1H = dto.percentChange1H
        model.price = dto.price
        model.priceChange1H = dto.priceChange1H
        return model
    }
    
    func convertToDTO() -> Numbers {
        Numbers(price: price,
                percentChange1H: percentChange1H,
                priceChange1H: priceChange1H)
    }
}
