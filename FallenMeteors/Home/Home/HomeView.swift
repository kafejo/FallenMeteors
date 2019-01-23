import Foundation
import UIKit.UITableViewController

class HomeView: UITableViewController, HomeViewProtocol {
    
    weak var delegate: HomeViewDelegate!
    var tableViewData: [Dictionary<String, Any>]?
    
    func showMeteorData(_ meteorData: [Dictionary<String, Any>]) {
        tableViewData = meteorData
        
        //self.tableView.reloadData()
    }
    
}
extension HomeView {
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
}
