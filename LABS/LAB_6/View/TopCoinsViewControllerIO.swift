protocol TopCoinsViewInput: AnyObject {
    func reloadData(data: DataCoin)
}

protocol TopCoinsViewOutput: AnyObject {
    func loadData()
    func reloadData()
}
