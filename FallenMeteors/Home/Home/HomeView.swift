import Foundation
import UIKit.UIViewController

class HomeView: UIViewController, HomeViewProtocol {
    
    @IBOutlet var tableView: UITableView!
    
    let numberOfSection = 2
    let meteorsOrderedByMassSection = 0
    let meteorsWithoutMassSection = 1
    
    weak var delegate: HomeViewDelegate!
    var meteorsOrderedByMass: [MeteorData]? {
        didSet{
            //TODO look into this threading issue more 
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var meteorsWithoutMass: [MeteorData]? {
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
    
    func showMeteorData(meteorsOrderedByMass: [MeteorData], meteorsWithoutMass: [MeteorData]) {
        self.meteorsOrderedByMass = meteorsOrderedByMass
        self.meteorsWithoutMass = meteorsWithoutMass
    }
    
    func presentViewController(_ viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func dismissCurrentChildVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
extension HomeView {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == meteorsOrderedByMassSection {
            return meteorsOrderedByMass?.count ?? 0
        } else {
            return meteorsWithoutMass?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"MeteorTableViewCell", for: indexPath) as! MeteorTableViewCell

        if indexPath.section == meteorsOrderedByMassSection{
            let meteor = meteorsOrderedByMass![indexPath.row]
            cell.setup(name: meteor.name, mass: meteor.mass, fellAtDate: meteor.fellAtDate, location: meteor.geoLocation)
            
        } else {
            let meteor = meteorsWithoutMass![indexPath.row]
            cell.setup(name: meteor.name, mass: meteor.mass, fellAtDate: meteor.fellAtDate, location: meteor.geoLocation)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == meteorsOrderedByMassSection {
            
            guard let meteor = meteorsOrderedByMass?[indexPath.row], meteor.geoLocation != nil
                    else {tableView.deselectRow(at: indexPath, animated: false); return}
            delegate.didSelectMeteor(meteor: meteor)
        } else if indexPath.section == meteorsWithoutMassSection {
            
            guard let meteor = meteorsWithoutMass?[indexPath.row], meteor.geoLocation != nil
                    else {tableView.deselectRow(at: indexPath, animated: false); return}
            delegate.didSelectMeteor(meteor: meteor)
        }
    }
}
