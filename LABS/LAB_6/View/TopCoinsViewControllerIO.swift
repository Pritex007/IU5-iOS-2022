protocol TopCoinsViewInput: AnyObject {
    
}

protocol TopCoinsViewOutput: AnyObject {
    func getURLRequestData(completion: @escaping (DataCoin) -> Void)
}
