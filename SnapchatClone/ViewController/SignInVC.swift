

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    // MARK: Buttons

    @IBAction func signInClicked(_ sender: Any) {
        
        
        if passwordText.text != "" && emailText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { result, error in
                if error != nil {
                    self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "An Error Occurred While Logging In...")
                }
                else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
        }
        }
        else {
            self.makeAlert(title: "ERROR", message: "Password/Email Check..")
        }
        
    }
    
    // MARK: user registration
    
    @IBAction func signUpClicked(_ sender: Any) {
        // Kullanıcı Oluşturma
        if usernameText.text != "" && emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { auth, Error in
                
                if Error != nil {
                    
                    self.makeAlert(title: "ERROR", message: Error?.localizedDescription ?? "An Error Occurred While Creating User...")
                
                }else{
                    
                   
                    let fireStore = Firestore.firestore()
                    let userDictionary = ["email" : self.emailText.text!,"username": self.usernameText.text] as [String : Any]
                   
                    fireStore.collection("UserInfo").addDocument(data: userDictionary) { (error) in
                        if error != nil {
                            
                        }
                    }
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else {
            makeAlert(title: "ERROR...", message: "Please Check Information")
        }
        
    }
    // MARK: Alert information for
        func makeAlert(title:String,message:String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    
}

