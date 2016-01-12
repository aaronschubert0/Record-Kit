//
//  RoutableViewController.swift
//  Track
//
//  Created by Aaron Schubert on 08/01/2016.
//  Copyright © 2016 aaronschubert. All rights reserved.
//

import UIKit

class RoutableViewController: UIViewController, Replayable {

    var popped: Action!
    var type: RoutableViewController.Type!
    var identifier: String!
    init(){
        super.init(nibName: nil, bundle: nil)
        type = RoutableViewController.self
        identifier = NSStringFromClass(self.classForCoder).stringByReplacingOccurrencesOfString("Track.", withString: "")
        popped = Action(identifier: identifier, action: GlobalActions.Pop, delay: true)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        if ((self.navigationController?.viewControllers.contains(self)) == nil) {
            recorder.recordAction(self.popped)
        }
    }
    
    func replayAction(action: Action) {
        // Sub classes override this
        NSException(name: "Fatal Error", reason: "Subclass hasn't overriden replay Action function", userInfo: nil).raise()
    }
}