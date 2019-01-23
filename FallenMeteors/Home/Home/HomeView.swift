import Foundation
import UIKit.UITableViewController

class HomeView: UITableViewController, HomeViewProtocol {
    
    weak var delegate: HomeViewDelegate!
    var tableViewData: [Dictionary<String, Any>]?
    
    func showMeteorData(_ meteorData: [Dictionary<String, Any>]) {
        tableViewData = meteorData
    }
    
}
extension HomeView {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"MeteorTableViewCell", for: indexPath) as! MeteorTableViewCell

        if let cellName = tableViewData?[indexPath.row]["mass"] as? String {
            cell.name.text = cellName
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
