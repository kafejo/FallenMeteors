import Foundation
import UIKit.UIViewController

class HomeView: UIViewController, HomeViewProtocol {
    
    @IBOutlet var tableView: UITableView!
    
    weak var delegate: HomeViewDelegate!
    var meteors: [MeteorData]? {
        didSet{
            //TODO look into this threading issue more 
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        delegate.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    func showMeteorData(_ meteorData: [MeteorData]) {
        meteors = meteorData
    }
    
}
extension HomeView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meteors?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"MeteorTableViewCell", for: indexPath) as! MeteorTableViewCell

        if let cellName = meteors?[indexPath.row].name {
            cell.name.text = cellName
        }
        
        if let cellMass = meteors?[indexPath.row].mass {
            cell.mass.text = cellMass
        }
        
        if let fellAtDate = meteors?[indexPath.row].fellAtDate {
            cell.fellAtDate.text = fellAtDate
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}
