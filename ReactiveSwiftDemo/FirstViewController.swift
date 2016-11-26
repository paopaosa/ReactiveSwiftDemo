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

class ViewModel {
    let username = MutableProperty("")
}

class FirstViewController: UIViewController {
    @IBOutlet weak var name:UITextField!
    @IBOutlet weak var count:UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
//    var property = MutableProperty("")
    var username:String = ""
    let tapRec = UITapGestureRecognizer()
    var nameDispose:Disposable?
    var allowsCookies:Bool = false
    var vm = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        self.name.rac_textSignal().skip(1).subscribeNext { (next) in
//            print("what is \(next)")
//        }
//        let property = DynamicProperty<String>(object: self,
//                                               keyPath: #keyPath(self.username))
        // Update `allowsCookies` whenever the toggle is flipped.
        self.usernameLabel.reactive.text <~ vm.username

        print("view mode is \(vm)")
//        let label = UILabel()
//        label.reactive.text <~ self.username
        let nameSignal = self.name.reactive.continuousTextValues
        let signalA = nameSignal.map{ $0?.characters.count }
        
//        property.signal.observeValues { value in
//            print("property is \(value)")
//        }
        
//        self.property.value = "2"
//        self.property.value = "3"
        //字数统计
        signalA
            .observe { [weak self](event) in
                switch event {
                case let .value(results):
                    self?.count.text = "\(results!)"
                case .completed, .interrupted: break
                default:
                    break
                }
        }
        nameDispose = nameSignal
            .observe(on: UIScheduler())
            .observe { [unowned self] event in
                switch event {
                case let .value(results):
                    print("name input is \(results!)")
                    if let name = results as String? {
                        self.vm.username.value = name
                    }
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
    
    deinit {
        nameDispose?.dispose()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

