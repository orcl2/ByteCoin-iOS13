import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var currentPickerView: UIPickerView!
    @IBOutlet weak var btcValueLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    
    // MARK: - Public Variables
    var coinManager = CoinManager()
    
    // MARK: - Life Cyle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        delegates()
    }
    
    // MARK: Private Methods
    private func delegates() {
        currentPickerView.delegate = self
        currentPickerView.dataSource = self
        coinManager.delegate = self
    }
    
    private func updateUI(with coin: Coin) {
        btcValueLabel.text = String(format: "%.2f", coin.rate)
        quoteLabel.text = coin.quoteId
    }
}


//MARK: - UIPickerViewDelegate Implementation

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let currency = coinManager.currencyArray[row]
        
        coinManager.fetchQuote(currency: currency)
    }
}


// MARK: - UIPickerViewDataSource Implementation

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return view.frame.width
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
}

// MARK: - CoinManagerDelegate Implementation

extension ViewController: CoinManagerDelegate {
    func didUpdate(_ coin: Coin) {
        updateUI(with: coin)
    }
}

