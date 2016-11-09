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

    let property = MutableProperty(0)
    let tapRec = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        self.name.rac_textSignal().skip(1).subscribeNext { (next) in
//            print("what is \(next)")
//        }
        self.name.reactive.continuousTextValues
            .observe(on: UIScheduler())
            .observe { event in
                switch event {
                case let .value(results):
                    print("name input is \(results!)")
                case let .failed(error):
                    print("name input error \(error)")
                case .completed, .interrupted:
                    break
                }
        }
        
        self.view.addGestureRecognizer(tapRec)
        tapRec.reactive.stateChanged
        .observe { [unowned self](event) in
            switch event {
            case let .value(results):
                print("tap is \(results)")
                self.name.resignFirstResponder()
            case let .failed(error):
                print("tap failed \(error)")
            case .completed, .interrupted:
                break
            }
        }
//        self.property <~ self.name.reactive.continuousTextValues

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

