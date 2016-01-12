//
//  Store.swift
//  Track
//
//  Created by Aaron Schubert on 08/01/2016.
//  Copyright © 2016 aaronschubert. All rights reserved.
//

import UIKit

struct Recorder {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    init(previousActions: [Action]) {
        actions = previousActions
    }
    
    var actions: [Action] {
        didSet {
            print("=======")
            print(self.JSONRepresentation()!)
            print("=======")
            textView.text = self.JSONRepresentation() as! String
            dispatch_async(dispatch_get_main_queue()) {
                let length = textView.text as NSString
                textView.scrollRangeToVisible(NSMakeRange(length.length, 0))
                textView.scrollEnabled = false
                textView.scrollEnabled = true
            }
        }
    }
    
    mutating func recordAction(action : Action) {
        actions.append(action)
    }
    
    func replayActions(actions: [Action], rootViewController: UIViewController) {
        let routableViewController = rootViewController as! RoutableViewController
        performAction(actions, initialController: routableViewController)
    }
    
    func performAction(var actions: [Action], initialController: RoutableViewController) {
        if actions.count > 0 {
            let firstAction = actions.removeAtIndex(0)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let controller = appDelegate.topViewController() as! RoutableViewController
            controller.replayAction(firstAction)
            let delayAmount = firstAction.hasDelay ? 0.45 : 0.0
            let delay = delayAmount * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.performAction(actions, initialController: controller)
            }
        }
    }
    
    func keyedValueRepresentation() -> [[String:AnyObject]]
    {
        var array = [[String:AnyObject]]()
        for action in actions {
            array.append(action.dictionaryRepresentation())
        }
        return array
    }
    
    func JSONRepresentation() -> NSString?
    {
        let array = self.keyedValueRepresentation()
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(array, options: NSJSONWritingOptions.PrettyPrinted)
            return NSString(data: data, encoding: NSUTF8StringEncoding)!
        }
        catch let error as NSError {
            print(error.description)
            return nil
        }
    }
    
    func save(){
        userDefaults.setObject(self.keyedValueRepresentation(), forKey: "recordings")
        userDefaults.synchronize()
    }
}

