//
//  SecondViewController.swift
//  Track
//
//  Created by Aaron Schubert on 08/01/2016.
//  Copyright © 2016 aaronschubert. All rights reserved.
//

import UIKit

class SecondViewController: RoutableViewController {

    let button = UIButton(type: .System)
    
    override init() {
        button.setTitle("Next", forState: .Normal)
        button.frame = CGRectMake(20, 200, 300, 44)
        super.init()
        button.addTarget(self, action: "next", forControlEvents: .TouchUpInside)
        view.addSubview(button)
        view.backgroundColor = UIColor.whiteColor()
        title = "Second"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func next() {
        recorder.recordAction(Action(identifier: self.identifier, action: SecondViewControllerActions.Next, delay: true))
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }

    override func replayAction(action: Action) {
        if action.action == SecondViewControllerActions.Next {
            next()
        }
        else if action.action == GlobalActions.Pop {
            self.navigationController?.popViewControllerAnimated(true)
        }
        else {
            NSException(name: "Can't replay Action", reason: "\(self.identifier) doesn't have replay support for the \(action.action) action", userInfo: nil).raise()
        }
    }
}
