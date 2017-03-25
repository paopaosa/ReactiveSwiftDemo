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
    @IBOutlet weak var count:UILabel!
    let property = MutableProperty("0")
    let tapRec = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        self.name.rac_textSignal().skip(1).subscribeNext { (next) in
//            print("what is \(next)")
//        }
//        count.text <~ property;
        //字数统计
        name.reactive.continuousTextValues.map{ $0?.characters.count }
        .observe { [weak self](event) in
            switch event {
            case let .value(results):
                //self?.count.text = "\(results!)"
                self?.property.value = "\(results!)"
            case .completed, .interrupted:
                break
            default:
                break
            }
        }
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
//        self.property <~ self.name.text
        name.reactive.text <~ self.property
        let textfield:UITextField = UITextField(frame: CGRect(x: 10, y: 30, width: 120, height: 30))
        textfield.backgroundColor = .purple
        self.view.addSubview(textfield)
        textfield.reactive.controlEvents(.editingDidBegin)
            .observe(on: UIScheduler())
            .observe { event in
                switch event {
                case let .value(results):
                    print(">>>>>name input is \(results)")
                case let .failed(error):
                    print(">>>>name input error \(error)")
                case .completed, .interrupted:
                    break
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

