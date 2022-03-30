
import UIKit

struct Noticias: Codable {
    var articles: [Noticia]
}

struct Noticia: Codable {
    var title: String?
    var description: String?
    //var urlToImage: String
    //var url: String
}

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    //para guardar los articulos y llenar la tabla
    var noticias = [Noticia]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = "Noticia1"
        return celda
    }
    

    @IBOutlet weak var tablaNoticias: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablaNoticias.delegate = self
        tablaNoticias.dataSource = self
        
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2022-02-28&sortBy=publishedAt&apiKey=888ffbdfb918461a9b071045e1f3ae1f"
        
        func analizarJSON(json:Data){
            let decodificador = JSONDecoder()
            if let datosDecodificados = try? decodificador.decode(Noticias.self, from: json){
                print("Los articulos son: \(datosDecodificados.articles.count)")
                print("Los articulos son: \(datosDecodificados.articles)")
            }
        }
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                analizarJSON(json: data)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
}
//llave
//https://newsapi.org/v2/everything?q=tesla&from=2022-02-28&sortBy=publishedAt&apiKey=888ffbdfb918461a9b071045e1f3ae1f
