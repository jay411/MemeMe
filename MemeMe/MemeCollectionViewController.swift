//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by jay raval on 7/12/17.
//  Copyright © 2017 jay raval. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes=[Meme]()
    var selectedMeme:Meme?
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var memeCollectionView: UICollectionView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = appDelegate.memes
        memeCollectionView.reloadData()
        
        
    }

    @IBAction func addNewMeme(_ sender: Any) {
        let createVC=self.storyboard!.instantiateViewController(withIdentifier: "ViewController")as! ViewController
        self.present(createVC, animated: true, completion: nil)

    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        super.collectionView(collectionView, section)
        print(self.memes.count)
        return self.memes.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MemeCollectionCell
        let meme=self.memes[(indexPath as NSIndexPath).row]
        cell.memeImage?.image=meme.memeImage
        return cell
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedMeme=self.memes[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "memeDetail", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="memeDetail" {
            
            let controller=segue.destination as! MemeDetailViewController
            controller.meme=self.selectedMeme
        }
        
        
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
