
import UIKit
import SafariServices

struct Noticias: Codable {
    var articles: [Noticia]
}

struct Noticia: Codable {
    var title: String?
    var description: String?
    var urlToImage: String?
    var url: String?
    var source: Source?
}

struct Source: Codable {
    var name: String?
}


var articulosNoticias: [Noticia] = []
var urlMandar :String?

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    //para guardar los articulos y llenar la tabla
    var noticias = [Noticia]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articulosNoticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! NoticiaTableViewCell
        celda.tituloNoticia?.text = articulosNoticias[indexPath.row].title
        celda.descripcionNoticia?.text = articulosNoticias[indexPath.row].description
        celda.Fuente?.text = "Fuente: \((articulosNoticias[indexPath.row].source?.name)!)"
        
        let urlimagen = articulosNoticias[indexPath.row].urlToImage ?? ""
        celda.imagenNoticia.cargarDesdeSitio(direcciones: urlimagen)
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(articulosNoticias[indexPath.row].url)
        
        urlMandar = articulosNoticias[indexPath.row].url
        tablaNoticias.deselectRow(at: indexPath, animated: true)
        
        
        let url = URL(string: urlMandar ?? "")!
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
        performSegue(withIdentifier: "navegarSitioWeb", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navegarSitioWeb"{
            let objDestino = segue.destination as! pagWebViewController
            objDestino.recibirUrl = urlMandar
        }
    }

    
    
    
    /////////////////estar
    @IBOutlet weak var tablaNoticias: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //registrar la nueva celda
        tablaNoticias.register(UINib(nibName: "NoticiaTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        tablaNoticias.delegate = self
        tablaNoticias.dataSource = self
        
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=f0797ef3b62d4b90a400ed224e0f82b7&country=mx"
        
        func analizarJSON(json:Data){
            let decodificador = JSONDecoder()
            if let datosDecodificados = try? decodificador.decode(Noticias.self, from: json){
                articulosNoticias = datosDecodificados.articles
                print("Los articulos son: \(datosDecodificados.articles.count)")
                print("Los articulos son: \(datosDecodificados.articles)")
            }
        }
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                analizarJSON(json: data)
            }
        }
    }
}


extension UIImageView{
    func cargarDesdeSitio(direcciones: String) {
        guard let url = URL(string: direcciones) else {return}
        
        DispatchQueue.main.async {
            if let imagenData = try? Data(contentsOf: url){
                if let imagenCargada = UIImage(data: imagenData){
                    self.image = imagenCargada
                }
            }
        }
    }
}
//llave
//https://newsapi.org/v2/everything?q=tesla&from=2022-02-28&sortBy=publishedAt&apiKey=888ffbdfb918461a9b071045e1f3ae1f
