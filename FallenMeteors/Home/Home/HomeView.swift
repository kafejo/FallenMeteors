import Foundation
import UIKit.UIViewController

class HomeView: UIViewController, HomeViewProtocol {
    
    @IBOutlet var tableView: UITableView!
    
    weak var delegate: HomeViewDelegate!
    var meteors: [MeteorData]?
    
    override func viewDidLoad() {
        delegate.viewDidLoad()
    }
    
    func showMeteorData(_ meteorData: [MeteorData]) {
        meteors = meteorData
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        tableView.reloadData()
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

        if let cellName = meteors?[indexPath.row].mass {
            cell.name.text = cellName
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}
