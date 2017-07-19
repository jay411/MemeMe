//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by jay raval on 7/12/17.
//  Copyright © 2017 jay raval. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes=[Meme]()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = appDelegate.memes
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MemeCollectionCell
        let meme=self.memes[(indexPath as NSIndexPath).row]
        cell.memeImage?.image=meme.memeImage
        return cell
        
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
