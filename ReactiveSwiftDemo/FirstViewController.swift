//
//  FirstViewController.swift
//  ReactiveSwiftDemo
//
//  Created by bp on 2016/10/31.
//  Copyright © 2016年 PPS. All rights reserved.
//

import UIKit
import Result
import ReactiveCocoa
import ReactiveSwift

class FirstViewController: UIViewController {
    @IBOutlet weak var name:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.name.rac_textSignal().skip(1).subscribeNext { (next) in
            print("what is \(next)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

