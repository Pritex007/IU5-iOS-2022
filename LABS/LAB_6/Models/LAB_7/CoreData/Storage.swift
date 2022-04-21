
import Foundation

enum StorageError: Error {
    case noData
}

protocol StorageProtocol {
    func save(coinData: DataCoin, completion: @escaping (Result<DataCoin, Error>) -> Void)
    func obtainCoinData(completion: @escaping (Result<DataCoin, Error>) -> Void)
}

final class Storage: StorageProtocol {
    
    // MARK: Private properties
    
    private let coreDataManager: CoreDataManagerProtocol!
    private let storageRequestFactory: FetchRequestFactoryProtocol!
    
    // MARK: Lifecycle
    
    init(coreDataManager: CoreDataManagerProtocol, storageRequestFactory: FetchRequestFactoryProtocol) {
        self.coreDataManager = coreDataManager
        self.storageRequestFactory = storageRequestFactory
    }
    
    // MARK: Internal
    
    func save(coinData: DataCoin, completion: @escaping (Result<DataCoin, Error>) -> Void) {
        let context = coreDataManager.writeContext
        context.perform {
            _ = DataCoinModel.convert(dto: coinData, into: context)
            do {
                try context.save()
                completion(.success(coinData))
            } catch {
                assertionFailure("Error when saving context \(error)")
                context.rollback()
                completion(.failure(error))
            }
        }
    }
    
    func obtainCoinData(completion: @escaping (Result<DataCoin, Error>) -> Void) {
        let context = coreDataManager.readContext
        context.perform { [weak self] in
            guard let strongSelf = self else { return }
            let request = strongSelf.storageRequestFactory.coinDataRequest()
            do {
                let fetchRequestResults = try context.fetch(request)
                guard let coinData = fetchRequestResults.first else { return }
                let dtoModel = coinData.convertToDTO()
                completion(.success(dtoModel))
            } catch {
                assertionFailure("Error to obtain CoinData \(error)")
                completion(.failure(error))
            }
        }
    }
}
