import UIKit

final class TopCoinsViewPresenter {
    weak var view: TopCoinsViewInput!
    weak var moduleOutput: TableModuleOutput!
    
    private var networkService = NetworkService(session: URLSession(configuration: .default))
    private var requestFactory = NetworkRequestFactory()
}

// MARK: - TopCoinsViewOutput

extension TopCoinsViewPresenter: TopCoinsViewOutput {
    func getURLRequestData(completion: @escaping (DataCoin) -> Void) {
        
        let request = requestFactory.getTopCoinsRequest()
        networkService.sendRequest(request) { result in
            switch result {
            case .failure(let error):
                print("Error: \(error)")
                
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let coinData = try decoder.decode(DataCoin.self, from: data)
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

