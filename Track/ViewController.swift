//
//  ViewController.swift
//  Track
//
//  Created by Aaron Schubert on 08/01/2016.
//  Copyright © 2016 aaronschubert. All rights reserved.
//

import UIKit

class ViewController: RoutableViewController {

    let button = UIButton(type: .System)
    
    override init() {
        button.setTitle("Next", forState: .Normal)
        button.frame = CGRectMake(20, 200, 300, 44)
        super.init()
        button.addTarget(self, action: "next", forControlEvents: .TouchUpInside)
        view.addSubview(button)
        view.backgroundColor = UIColor.whiteColor()
        title = "First"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func next() {
        recorder.recordAction(Action(identifier: self.identifier, action: ViewControllerActions.Next, delay: true))
        self.navigationController?.pushViewController(SecondViewController(), animated: true)
    }

    //MARK: Replay
    override func replayAction(action: Action) {
        if action.action == ViewControllerActions.Next {
            next()
        }
        else if action.action == GlobalActions.Pop {
            self.navigationController?.popViewControllerAnimated(true)
        }
        else {
            //THROW
            NSException(name: "Can't replay Action", reason: "\(self.identifier) doesn't have replay support for the \(action.action) action", userInfo: nil).raise()
        }
    }
}

