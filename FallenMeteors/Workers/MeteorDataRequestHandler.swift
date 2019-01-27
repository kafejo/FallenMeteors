import Foundation

class MeteorDataRequestHandler {

    let endpointUrl = URL(string: "https://data.nasa.gov/resource/y77d-th95.json")

    func loadData(completionHandler: @escaping (Data) -> Void) {
        
        let request = NSMutableURLRequest(url: endpointUrl!)
        request.addValue("application/json", forHTTPHeaderField:"Accept")
        request.addValue("yx6khWrHi7unQhXqp88y2GiaV", forHTTPHeaderField: "X-App-Token")
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error ) in
            
            print("Getting Meteor data")
  
            guard error == nil else {
                print("An error occured while attemping to download meteor data \(error!.localizedDescription)");
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Attempt to retrieve backend data at \(NSDate().description)")
                
                if httpResponse.statusCode == 200 {
                    print("Successfully retrieved data")
                }
                else if httpResponse.statusCode/100 == 2 {
                    print("Success with issues")
                }
                else
                {
                    print("Something went wrong")
                }
                
                print("Response Status Code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {return}
            completionHandler(data)
            
            }.resume()
        
    }

}
