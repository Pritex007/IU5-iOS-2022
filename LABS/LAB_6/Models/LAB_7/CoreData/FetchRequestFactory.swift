import Foundation
import CoreData

protocol FetchRequestFactoryProtocol {
    func coinDataRequest() -> NSFetchRequest<DataCoinModel>
    func removeAllRequest() -> NSBatchDeleteRequest
    func coinRequest(title : String) -> NSFetchRequest<CoinModel>
}

final class FetchRequestFactory: FetchRequestFactoryProtocol {
    
    func coinDataRequest() -> NSFetchRequest<DataCoinModel> {
        let request = NSFetchRequest<DataCoinModel>(entityName: DataCoinModel.entity().name ?? "")
        return request
    }
    
    func removeAllRequest() -> NSBatchDeleteRequest {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: DataCoinModel.entity().name ?? "")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        return deleteRequest
    }
    
    func coinRequest(title: String) -> NSFetchRequest<CoinModel> {
        let request = NSFetchRequest<CoinModel>(entityName: CoinModel.entity().name ?? "")
        
        let titlePredicate = NSPredicate(format: "%K == %@", #keyPath(CoinModel.title), title)
        
        request.predicate = titlePredicate
        
        return request
    }
}
