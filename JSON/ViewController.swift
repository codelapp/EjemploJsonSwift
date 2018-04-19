import UIKit

struct User: Codable {
    let id: Int
    let name : String
    let email: String
    let address: Address
}

struct Address: Codable {
    let city :String
    let geo: Geo
}

struct Geo: Codable {
    let lat: String
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tabla: UITableView!
    
    var usuarios = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabla.delegate = self
        tabla.dataSource = self
        
        datos()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let usuario = usuarios[indexPath.row]
        cell.textLabel?.text = usuario.name
        cell.detailTextLabel?.text = usuario.address.geo.lat
        return cell
    }
    
    func datos(){
        
        let datos = "https://jsonplaceholder.typicode.com/users"
        let url = URL(string: datos)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            do{
                
                self.usuarios = try JSONDecoder().decode([User].self, from: data!)
                DispatchQueue.main.async {
                    self.tabla.reloadData()
                }
                
            }catch{
                print("error al conectar")
            }
            
        }.resume()
        
    }

}

