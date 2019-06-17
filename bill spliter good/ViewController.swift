//
//  ViewController.swift
//  bill spliter good
//
//  Created by Ellie Sekine on 2019-06-14.
//  Copyright © 2019 Ellie Sekine. All rights reserved.
//

import UIKit


class ViewController: UIViewController{
    
    @IBOutlet weak var totalLabel: UILabel!
    var labelString:String = ""

    @IBOutlet weak var billLabel: UILabel!
    var billLabelString:String = ""
    
    @IBOutlet weak var tipLabel: UILabel!
    var tipLabelString:String = ""
    
    @IBOutlet weak var tipAmtLabel: UILabel!
    var tipAmtString:String = ""
    
    @IBOutlet weak var friendsLabel: UILabel!
   
    @IBOutlet weak var sliderFriendsLabel: UILabel!
   
    @IBOutlet weak var slider: UISlider!
    
  
    @IBAction func splitBill(_ sender: UIButton) {
    }
    
    @IBOutlet weak var personOneLabel: UILabel!
    
    
    @IBOutlet weak var personTwoLabel: UILabel!
    
    
    @IBOutlet weak var personThreeLabel: UILabel!
    
    
    @IBOutlet weak var personFourLabel: UILabel!
    
    @IBOutlet weak var splitView: UIView!
    
    var splitPrice:String = ""
    
    @IBOutlet weak var hideCell3: UIView!
    
    @IBOutlet weak var hideCellFour: UIView!
    
    override func viewDidLayoutSubviews() {
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        splitView.isHidden = true
        hideCell3.isHidden = true
        hideCellFour.isHidden = true
    }
    

    //Responds to a number or decimal place being pressed
    @IBAction func didPressNumber(_ sender: UIButton) {
        
        let stringValue:String? = sender.titleLabel?.text
        
        labelString = labelString.appending(stringValue!)
        billLabelString = billLabelString.appending(stringValue!)
        updateTotalLabel()
        updateBillLabel()
    }
    

    //responds to delete being pressed
    @IBAction func didPressDelete(_ sender: UIButton) {
        labelString = String(labelString.dropLast())
        billLabelString = String(billLabelString.dropLast())
        updateTotalLabel()
        updateBillLabel()
    }
    
    //responds to a tip being pressed
    @IBAction func didPressTip(_ sender: UIButton) {
        var tipString: String = sender.titleLabel!.text!
        tipString = String((tipString.dropLast()))
        
        //calculates tip multiplier
        let tipInt:Float = 1 + Float(tipString)!/100
       
        guard let labelNum:Float = Float(labelString)
        else{
            return
        }
        
        tipAmtString = "TIP (" + sender.titleLabel!.text! + ")"
        
        tipLabelString = String(format:"%.02f",(labelNum * tipInt) - labelNum)
        
        labelString = String(format:"%.02f",labelNum * tipInt)
        
        updateTipAmtLabel()
        updateTotalLabel()
        updateTipLabel()
        
    }
    
    //responds to slider being changed
    @IBAction func didChangeSlider(_ sender: UISlider) {
        slider.value = roundf(slider.value)
        let numFriends:String = String(format:"%.00f",sender.value)
        friendsLabel.text = "\(numFriends)"
        sliderFriendsLabel.text = "\(numFriends)"
    }
    
    //updates the label showing the tip amount
    func updateTipAmtLabel(){
        tipAmtLabel.text = tipAmtString
    }
    
    //updates the label showing the total (includinf bill and tip)
    func updateTotalLabel(){
        totalLabel.text = labelString
    }
    
    //updates bill label
    func updateBillLabel(){
        billLabel.text = billLabelString
    }
    
    //updates label that shows what percentage of tip was used
    func updateTipLabel(){
        tipLabel.text = tipLabelString
    }
    
    //updates label that shows how much each person owes
    func updatePersonLabel(){
        let splitPriceNum:Float =  Float(totalLabel.text!)! / Float(sliderFriendsLabel.text!)!
         splitPrice = "$" + String(format:"%.02f", splitPriceNum)
        
        personOneLabel.text = splitPrice
        personTwoLabel.text = splitPrice
        personThreeLabel.text = splitPrice
        personFourLabel.text = splitPrice
    }
    
    //shows the view that displays how much each person owns
    func showCells(){
        splitView.isHidden = false
        
        //hides cells depending on how many people the bill is split with
        if Int(sliderFriendsLabel.text!)! < 4 {
            hideCellFour.isHidden = false
        
            if Int(sliderFriendsLabel.text!)! < 3 {
                hideCell3.isHidden = false
            }
        }
    
    }
    
    //calls showCells when split bill is clicked
   @IBAction func didPressSplitBill(){
    if totalLabel.text != ""{
            showCells()
            updatePersonLabel()
    }
    }

//hides view that shows how much each person owes once bacl is pressed
  @IBAction func didPressBack(){
        splitView.isHidden = true
        hideCellFour.isHidden = true
        hideCell3.isHidden = true
    
        tipAmtString = "TIP"
        tipLabelString = ""
        labelString = ""
        billLabelString = ""

        updateTipAmtLabel()
        updateTotalLabel()
        updateTipLabel()
        updateBillLabel()
    
   }

    
}


