

import UIKit
import ImageSlideshow

class SnapVC: UIViewController {

    
    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedSnap : Snap?
    
    
    
    var inputArray = [SDWebImageSource] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
    
        if let snap = selectedSnap {
            
            //To reach the urls registered in the DB
            for imageUrl in snap.imageUrlArray {
                
                timeLabel.text = "Time Left: \(snap.timeDifference)"
                inputArray.append(SDWebImageSource(urlString: imageUrl)!)
            }
            
            
           
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width*0.95, height: self.view.frame.height * 0.90))
            imageSlideShow.backgroundColor = UIColor.white
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            
           
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
            pageIndicator.pageIndicatorTintColor = UIColor.black
            imageSlideShow.pageIndicator = pageIndicator
            
            .
            imageSlideShow.setImageInputs(inputArray)
            
            self.view.addSubview(imageSlideShow)
            
            self.view.bringSubviewToFront(timeLabel) 
        }
        
    }
    

}
