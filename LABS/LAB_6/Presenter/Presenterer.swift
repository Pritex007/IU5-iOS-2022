import UIKit

final class TopCoinsViewPresenter {
    
    weak var view: TopCoinsViewInput!
    weak var moduleOutput: TableModuleOutput!
    
    // MARK: - Private properties
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: NetworkRequestFactoryProtocol
    private let coreDataManager: CoreDataManagerProtocol
    private let storageRequestFactory: FetchRequestFactoryProtocol
    private let storage: StorageProtocol
    
    init() {
        requestFactory = NetworkRequestFactory()
        networkService = NetworkService(session: URLSession(configuration: .default))
        coreDataManager = CoreDataManager()
        storageRequestFactory = FetchRequestFactory()
        storage = Storage(coreDataManager: coreDataManager, storageRequestFactory: storageRequestFactory)
    }
    
    private func saveCoinsData(_ coinData: DataCoin) {
        storage.save(coinData: coinData) { result in
            switch result {
            case .failure(let error):
                print("SaveCoin Failed \(error)")
            case .success:
                print("Successfully saved to cached")
            }

        }
    }
    
    private func obtainCoinDataFromCache(completion: @escaping (Result<DataCoin, Error>) -> Void) {
        storage.obtainCoinData(completion: completion)
    }
    
    private func obtainCoinDataFromServer() {
        
        let request = requestFactory.getTopCoinsRequest()
        networkService.sendRequest(request) {[weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .failure(let error):
                print("Error: \(error)")
                
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let coinData: DataCoin = try decoder.decode(DataCoin.self, from: data)
                    strongSelf.view.reloadData(data: coinData)
                    strongSelf.saveCoinsData(coinData)
                } catch {
                    assertionFailure("\(error)")
                }
            }
        }
    }
}

// MARK: - TopCoinsViewOutput

extension TopCoinsViewPresenter: TopCoinsViewOutput {

    func loadData() {
        obtainCoinDataFromCache() {[weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let coinData):
                strongSelf.view.reloadData(data: coinData)
            case .failure(let error):
                print(error)
            }
            strongSelf.obtainCoinDataFromServer()
        }
    }
    
    func reloadData() {
        obtainCoinDataFromServer()
    }
}

// MARK: - TopCoinsModuleInput

extension TopCoinsViewPresenter: TopCoinsModuleInput {
}
