
import UIKit
import WebKit

class pagWebViewController: UIViewController {
    var recibirUrl:String?
    
    @IBOutlet weak var paginaWeb: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: recibirUrl!)else{return}
        paginaWeb.load(URLRequest(url: url))
        // Do any additional setup after loading the view.
    }
}
