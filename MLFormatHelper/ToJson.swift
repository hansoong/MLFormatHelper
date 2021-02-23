import Foundation

class ToJson {
    //convert from vott json to create ML json
    func vottJsonToCreateMLJson(_ filepath: String) -> Void {
        //vott json
        let fromFileURL = URL(fileURLWithPath: filepath)
        //let filepath = Bundle.main.path(forResource: "hansoong2-export", ofType: "json")
        
        let data = try? Data(contentsOf: fromFileURL)
        let json = try? JSONSerialization.jsonObject(with: data!, options: [])

        //create ML json
        var toJson = [[String:Any]]()
        
        if let jsonRoot = json as? [String: Any] {
            if let assets = jsonRoot["assets"] as? [String: Any] {
                for (_, value) in assets {
                    if let content = value as? [String : Any] {
                        if let asset = content["asset"] as? [String: Any], let regions = content["regions"] as? Array<Any> {
                            var jsonItem = [String:Any]()
                            jsonItem["images"] = (asset["name"] as! String)
                            
                            var annotations = [[String:Any]]()
                            var annotationItem = [String:Any]()
                            
                            let region = regions.first as! [String:Any]
                            let labels = region["tags"] as! [String]
                            annotationItem["label"] = labels.first
                            
                            let boundingBox = region["boundingBox"] as! [String:Double]
                            let left = boundingBox["left"]!
                            let top = boundingBox["top"]!
                            let width = boundingBox["width"]!
                            let height = boundingBox["height"]!
                            
                            annotationItem["coordinates"] = [
                                "x" : Int(left + width / 2),
                                "y" : Int(top + height / 2),
                                "width" : Int(width),
                                "height" : Int(height)
                            ]
                            
                            annotations.append(annotationItem)
                            jsonItem["annotation"] = annotations
                            
                            toJson.append(jsonItem)
                            
                            //print(regions)
                            
                        }
                    }
                }

            }
        }
        if let theJSONData = try?
            JSONSerialization.data(
                withJSONObject: toJson,
                options: .prettyPrinted
              ),
           let theJSONText = String(
            data: theJSONData,
            encoding: String.Encoding.utf8)
        {
            print("JSON string = \n\(theJSONText)")
            let filename = "annotation.json"
            
            //if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let downloadURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
            let toFileURL = downloadURL.appendingPathComponent(filename)
            //let toFileURL = fromFileUrl.deletingLastPathComponent().appendingPathComponent(filename)
                print("\(toFileURL)")
                //writing
                do {
                    try theJSONText.write(to: toFileURL, atomically: true, encoding: String.Encoding.utf8)
                }
                catch {
                    /* error handling here */
                    print("cannot perform write file")
                    
                }
            //}

        }
    }
}
