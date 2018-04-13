//
//  ViewController.swift
//  MedicalCalendar
//
//  Created by Jamee Krzanich on 3/17/18.
//  Copyright © 2018 Jamee Krzanich. All rights reserved.
//


import JTAppleCalendar
import UIKit

class ViewController: UIViewController {
  
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    let outsideMonthColor = UIColor(hex: 0x584a66)
    let monthColor = UIColor.white
    let selectedMonthColor = UIColor(hex: 0x3a294b)
    let currentDateSelectedViewColor = UIColor(hex: 0x4e3f5d)
    let formatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setupCalendarView()
    {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState){
         guard let validCell = view as? CustomCell else{return}
        if cellState.isSelected{
            validCell.selectedView.isHidden = false
        }else{
            validCell.selectedView.isHidden = true
        }
        
    }
    func handletextColor(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? CustomCell else{return}
        
        if cellState.isSelected{
            validCell.dateLabel.textColor = selectedMonthColor
        }else{
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = monthColor
            }else{
                validCell.dateLabel.textColor = outsideMonthColor
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension ViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        print("here we go")
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = formatter.date(from: "2018 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let myCustomCell = cell as! CustomCell
        myCustomCell.dateLabel.text = cellState.text
    }
}
extension ViewController: JTAppleCalendarViewDelegate{
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dateLabel.text = cellState.text
       handleCellSelected(view: cell, cellState: cellState)
        handletextColor(view: cell, cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handletextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
       handleCellSelected(view: cell, cellState: cellState)
        handletextColor(view: cell, cellState: cellState)
    }
}

extension UIColor{
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}





