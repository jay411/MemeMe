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
    var selectedMeme: Meme?
    override func viewDidLoad() {
        super.viewDidLoad()

       

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = appDelegate.memes
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "memeTableCell") as! MemeTableCell
        let meme=self.memes[(indexPath as NSIndexPath).row]
        cell.cellImage.image=meme.memeImage
        cell.cellLabel.text=meme.topText

        

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  self.memes.count==0{
            let createVC=self.storyboard!.instantiateViewController(withIdentifier: "ViewController")as! ViewController
            self.navigationController!.present(createVC, animated: true, completion: nil
            )
        }
        return self.memes.count
    }
    

    @IBAction func addMemePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "tableToCreate", sender: self)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        self.selectedMeme=self.memes[(indexPath as NSIndexPath).row]
//         let storyboard = UIStoryboard (name: "Main", bundle: nil)
        self.performSegue(withIdentifier: "memeDetail", sender: self)
//        let detailVC=storyboard.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
//        
//        detailVC.meme=self.memes[(indexPath as NSIndexPath).row]
//        print("present called detail meme \(detailVC.meme?.topText)")
//        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let controller=segue.destination as! MemeDetailViewController
        controller.meme=self.selectedMeme
        
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
