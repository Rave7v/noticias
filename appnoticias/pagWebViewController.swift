
import UIKit

class pagWebViewController: UIViewController {
    var recibirUrl:String?
    
    @IBOutlet weak var paginaWeb: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let urlCargar = URL(string: recibirUrl)
        // Do any additional setup after loading the view.
    }

}
