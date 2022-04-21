import CoreData
import Foundation

extension DataCoinModel {
    static func convert(dto: DataCoin, into context: NSManagedObjectContext) -> DataCoinModel {
        let model = DataCoinModel(context: context)
        
        var dataArray: [CoinModel] = []
        dto.data.forEach {
            dataArray.append(CoinModel.convert(dto: $0, into: context))
        }
        
        model.coins = NSSet(array: dataArray)
        return model
    }
    
    func convertToDTO() -> DataCoin {
        var dataArray: [Coin] = []
        coins?.forEach { dataElement in
            guard let dataElement = dataElement as? CoinModel else { return }
            dataArray.append(dataElement.convertToDTO())
        }
        
        return DataCoin(data: dataArray)
    }
}
