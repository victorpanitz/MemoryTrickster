import MemoryTrickster
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let viewController = UIViewController()
//        viewController.view.backgroundColor = .yellow
//        
//        present(viewController, animated: true) {
//            
//            let viewController2 = UIViewController()
//            viewController2.view.backgroundColor = .red
//            
//            viewController.present(viewController2, animated: true) {
//                
//                let viewController3 = UIViewController()
//                viewController3.view.backgroundColor = .gray
//                viewController2.present(viewController3, animated: true) {
//                    
//                }
//            }
//        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("MEMORY WARNING")
    }

}

