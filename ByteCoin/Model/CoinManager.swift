import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "DEA9F8CA-3E70-4B71-A2A3-5CB1E0AC05DB"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func fetchQuote(currency: String) {
        
        let urlString = "\(baseURL)/\(currency)?apiKey=\(apiKey)"
        
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, urlResponse, error in
            
            if let data = data, error == nil {
                
                let coin = parseJson(data)
                
                DispatchQueue.main.async {
                    self.delegate?.didUpdate(coin)
                }
            }
        }
        
        task.resume()
    }
                                              
    private func parseJson(_ data: Data) -> Coin {
        let decoder = JSONDecoder()
        
        guard let coin = try? decoder.decode(Coin.self, from: data) else {
            return Coin(baseId: "?", quoteId: "?", rate: 0)
        }
        
        return coin
    }
}

