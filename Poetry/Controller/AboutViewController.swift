//
//  AboutViewController.swift
//  Poetry
//
//  Created by 伍腾飞 on 2017/6/20.
//  Copyright © 2017年 wtf. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mail(_ sender: UITapGestureRecognizer) {
        UIApplication.shared.openURL(URL(string: "mailto://woodtengfei@gmail.com")!)
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
