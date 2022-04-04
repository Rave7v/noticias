
import UIKit

class NoticiaTableViewCell: UITableViewCell {

    @IBOutlet weak var tituloNoticia: UILabel!
    @IBOutlet weak var descripcionNoticia: UILabel!
    @IBOutlet weak var Fuente: UILabel!
    @IBOutlet weak var imagenNoticia: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
