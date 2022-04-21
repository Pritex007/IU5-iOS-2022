import UIKit

final class TopCoinsViewPresenter {
    weak var view: TopCoinsViewInput!
    weak var moduleOutput: TableModuleOutput!
    
    private var networkService: NetworkServiceProtocol!
    private var requestFactory: NetworkRequestFactoryProtocol!
}

// MARK: - TopCoinsViewOutput

extension TopCoinsViewPresenter: TopCoinsViewOutput {
    func getURLRequestData(completion: @escaping (DataCoin?) -> Void) {
        
        var coinData: DataCoin?
        
        requestFactory = NetworkRequestFactory()
        networkService = NetworkService(session: URLSession(configuration: .default))
        
        let request = requestFactory.getTopCoinsRequest()
        networkService.sendRequest(request) { result in
            switch result {
            case .failure(let error):
                print("Error: \(error)")
                
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    coinData = try decoder.decode(DataCoin.self, from: data)
                    completion(coinData)
                } catch {
                    assertionFailure("\(error)")
                }
            }
        }
    }
}

// MARK: - TopCoinsModuleInput

extension TopCoinsViewPresenter: TopCoinsModuleInput {
    
}

