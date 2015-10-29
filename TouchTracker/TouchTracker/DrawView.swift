//
//  DrawView.swift
//  TouchTracker
//
//  Created by Kelly Yamamoto on 10/29/15.
//  Copyright © 2015 Kelly Yamamoto. All rights reserved.
//

import UIKit
class DrawView: UIView, UIGestureRecognizerDelegate {
    var currentLines = [NSValue:Line]()
    
    var finishedLines = [Line]()
    var selectedLineIndex: Int? {
        didSet {
            if selectedLineIndex == nil {
                let menu = UIMenuController.sharedMenuController()
                menu.setMenuVisible(false, animated: true)
            }
        }
    }
    
    var moveRecognizer: UIPanGestureRecognizer!
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.blackColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var currentLineColor: UIColor = UIColor.redColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self,
            action: "doubleTap:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(doubleTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "tap:")
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
        addGestureRecognizer(tapRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
        addGestureRecognizer(longPressRecognizer)
        
        moveRecognizer = UIPanGestureRecognizer(target: self, action: "moveLines:")
        moveRecognizer.delegate = self
        moveRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(moveRecognizer)
    }
    
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = CGLineCap.Round
        path.moveToPoint(line.begin)
        path.addLineToPoint(line.end)
        path.stroke()
    }
    
    func doubleTap(gestureRecognizer: UIGestureRecognizer){
        print("Recognized a double tap")
        
        selectedLineIndex = nil
        currentLines.removeAll(keepCapacity: false)
        finishedLines.removeAll(keepCapacity: false)
        setNeedsDisplay()
    }
    
    func tap(gestureRecognizer: UIGestureRecognizer){
        print("Recognized a tap")
        
        let point = gestureRecognizer.locationInView(self)
        selectedLineIndex = indexOfLineAtPoint(point)
        
        //Grab the menu controller
        let menu = UIMenuController.sharedMenuController()
        
        if selectedLineIndex != nil {
            // make drawview the target of the menu item action messages
            becomeFirstResponder()
            
            //create a new delete UIMenuItem
            let deleteItem = UIMenuItem(title: "Delete", action: "deleteLine:")
            menu.menuItems = [deleteItem]
            
            //tell menu where it should come from and show it
            menu.setTargetRect(CGRect(x: point.x, y: point.y, width: 2, height: 2), inView: self)
            menu.setMenuVisible(true, animated: true)
        } else {
            //Hide the menu if no line is selected
            menu.setMenuVisible(false, animated: true)
        }
        
        setNeedsDisplay()
    }
    
    func longPress(gestureRecognizer: UIGestureRecognizer){
    print("Recognized a long press")
        
        if gestureRecognizer.state == .Began {
            let point = gestureRecognizer.locationInView(self)
            selectedLineIndex = indexOfLineAtPoint(point)
            
            if selectedLineIndex != nil {
                currentLines.removeAll(keepCapacity: false)
            }
        } else if gestureRecognizer.state == .Ended {
            selectedLineIndex = nil
        }
        
        setNeedsDisplay()
    }
    
    func moveLines(gestureRecognizer: UIPanGestureRecognizer){
        print("Recognized a pan")
        
        //If a line s selected..
        if let index = selectedLineIndex {
            //When pan recognizer changes its position...
            if gestureRecognizer.state == .Changed {
                // how far has the pan moved?
                let translation = gestureRecognizer.translationInView(self)
                
                //add translation to current beggining
                finishedLines[index].begin.x += translation.x
                finishedLines[index].begin.y += translation.y
                finishedLines[index].end.x += translation.x
                finishedLines[index].end.y += translation.y
                
                gestureRecognizer.setTranslation(CGPoint.zero, inView: self)
                
                //redraw the screen
                setNeedsDisplay()
            }
            
        } else {
            // if no line is selected, don't do anything
            return
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func drawRect(rect: CGRect) {
        finishedLineColor.setStroke()
        for line in finishedLines {
            strokeLine(line)
        }
        currentLineColor.setStroke()
        for (_, line) in currentLines {
            strokeLine(line)
        }
        
        if let index = selectedLineIndex {
            UIColor.greenColor().setStroke()
            let selectedLine = finishedLines[index]
            strokeLine(selectedLine)
        }
    }
    
    func indexOfLineAtPoint(point: CGPoint) -> Int? {
        //Find a line close to point
        for (index, line) in finishedLines.enumerate() {
            let begin = line.begin
            let end = line.end
            
            //check for a few points on the line
            for t in CGFloat(0).stride(to: 1.0, by: 0.05){
                let x = begin.x + ((end.x - begin.x) * t)
                let y = begin.y + ((end.y - begin.y) * t)
                
                //If the tapped point if within 20 points, let's reutrn this line
                if hypot(x-point.x, y-point.y) < 20.0 {
                    return index
                }
            }
        }
        
        //If nothing is close enough to the tapped point, then we did not select a line
        return nil
    }
    
    func deleteLine(sender: AnyObject) {
        //remove selected line from list of finishedLines
        if let index = selectedLineIndex {
            finishedLines.removeAtIndex(index)
            selectedLineIndex = nil
            
            //redraw everything
            setNeedsDisplay()
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Let's put in a log statement to see the order of events
        print(__FUNCTION__)
        
        for touch in touches {
            let location = touch.locationInView(self)
            let newLine = Line(begin: location, end: location)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Let's put in a log statement to see the order of events
        print(__FUNCTION__)
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.locationInView(self)
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Let's put in a log statement to see the order of events
        print(__FUNCTION__)
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                line.end = touch.locationInView(self)
                finishedLines.append(line)
                currentLines.removeValueForKey(key)
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        // Let's put in a log statement to see the order of events
        print(__FUNCTION__)
        currentLines.removeAll()
        setNeedsDisplay()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
}