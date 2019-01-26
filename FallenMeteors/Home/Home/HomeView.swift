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
    
    func presentViewController(_ viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func dismissCurrentChildVC() {
        self.dismiss(animated: true, completion: nil)
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

        let meteor = meteors![indexPath.row]
        
        if let cellName = meteor.name {
            cell.name.text = cellName
        }
        
        if let cellMass = meteor.mass {
            cell.mass.text = cellMass
        }
        
        if let fellAtDate = meteor.fellAtDate {
            cell.fellAtDate.text = fellAtDate
        }
        
        if meteor.geoLocation == nil {
            cell.locationIcon.image = UIImage(named: "noLocationIcon")
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let meteor = meteors?[indexPath.row], meteor.geoLocation != nil else {return}
        delegate.didSelectMeteor(meteor: meteor)
    }

}
