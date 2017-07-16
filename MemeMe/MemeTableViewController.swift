//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by jay raval on 7/12/17.
//  Copyright © 2017 jay raval. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes=[Meme]()
    override func viewDidLoad() {
        super.viewDidLoad()
        memes = appDelegate.memes

       

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "memeTableCell")!
        let meme=self.memes[(indexPath as NSIndexPath).row]
        cell.textLabel?.text=meme.topText!+meme.bottomText!
        cell.imageView?.image=meme.memeImage
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  self.memes.count==0{
            let createVC=self.storyboard!.instantiateViewController(withIdentifier: "ViewController")as! ViewController
            self.navigationController!.present(createVC, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        }
        return self.memes.count
    }
    

    @IBAction func addMemePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "tableToCreate", sender: self)
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
