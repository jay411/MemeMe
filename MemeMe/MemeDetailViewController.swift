//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by jay raval on 7/25/17.
//  Copyright © 2017 jay raval. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var memeImage: UIImageView!
    var meme:Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeImage.image=self.meme?.memeImage
        self.tabBarController?.tabBar.isHidden=true
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print("\n view appeared")
//        
//    }
//    
    override func viewWillDisappear(_ animated: Bool) {
    
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden=false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
