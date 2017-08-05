import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelStatus: UILabel!
    
    
    @IBAction func downloadImage(_ sender: Any) {
        downloadImageFromWeb()
        labelStatus.text = "Downloading Image from Internet..."
    }
    
    
    @IBAction func loadImage(_ sender: Any) {
        loadImageFromGallery()
        labelStatus.text = "Loaded from Gallery."
    }
    
    @IBAction func resetImage(_ sender: Any) {
        imageView.image = nil
        labelStatus.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func downloadImageFromWeb() {
        let url = URL(string: "https://pbs.twimg.com/media/DD79O1DUMAAI01Y.jpg")
        let request = NSMutableURLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print(error!)
            } else {
                
                //force unwrap if there is value
                if let data = data {
                    
                    //convert data into an image
                    if let bachImage = UIImage(data: data) {
                        self.imageView.image = bachImage        //display bachImage into imageView
                        self.labelStatus.text = "Downloaded Image from Internet."
                        print("Image set")
                        
                        //Search for document directory
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                        
                        if documentsPath.count > 0 {
                            print("document path found")
                            //Get specific path
                            let documentsDirectory = documentsPath[0]
                            
                            //if document path is found
                            let savePath = documentsDirectory + "/image.jpg"
                            
                            do {
                                print("Image saved")
                                try UIImageJPEGRepresentation(bachImage, 1)?.write(to: URL(fileURLWithPath: savePath))
                            } catch {
                                print("Image save error")
                                //process error
                            }
                        }
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func loadImageFromGallery () {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print("retrieving")
        if documentsPath.count > 0 {
            print("retrieved")
            let documentsDirectory = documentsPath[0]
            let restorePath = documentsDirectory + "/image.jpg"
            imageView.image = UIImage(contentsOfFile: restorePath)
            print("image set")
        } else {
            print("error retrieving")
        }
    }


}

