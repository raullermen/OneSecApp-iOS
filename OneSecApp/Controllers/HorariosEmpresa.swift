//
//  HorariosEmpresa.swift
//  OneSecApp
//
//  Created by Raul Lermen on 2/21/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

//    func AtualizaHorariosDoDia(){
//        _listaHorarioDoDia = _listaHorario.filter { c in c.isSameDateThan(self._dateSelected) }
//    }

import UIKit
import JTCalendar
import EVReflection

class HorariosEmpresa: UIViewController, JTCalendarDelegate {

    var _webservice = Webservice()
    var _isWaitingResponse = Bool()
    
    @IBOutlet weak var _calendarContentView: JTHorizontalCalendarView!
    @IBOutlet weak var _tableAppointments: UITableView!
    @IBOutlet weak var _headerView: UIView!
    
    var _calendarManager = JTCalendarManager()
    var _dateSelected = NSDate()
    var _listaHorarioDoDia = Array<MobileReservationDTO>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AjustaLayout()
        
        _calendarManager.delegate = self
        _calendarManager.contentView = _calendarContentView
        _calendarManager.setDate(NSDate())
        _calendarManager.reload()
        
        [NSUserDefaults .standardUserDefaults() .setInteger(0, forKey: "idProfissional")]
    }
    
    // MARK: LAYOUT
    func AjustaLayout(){
        self.navigationController?.navigationBar.translucent = true
        
        let font = UIFont(name: "GothamBold", size: 22.0)
        if let font = font {
            let titleDict: NSDictionary = [NSForegroundColorAttributeName: Util.AppVermelho(), NSFontAttributeName: font]
            self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 225/255, green: 41/255, blue: 61/255, alpha: 1)
        
        //Ajusta Header
        let nib = NSBundle.mainBundle().loadNibNamed("CalendarioEmpresaHeaderView", owner: self, options: nil).first as! UIView
        
        if UIScreen.mainScreen().bounds.size.height == 736.0 {
            nib.frame = CGRect(x: 15, y: 0, width: _headerView.frame.width, height: _headerView.frame.height)
        }else{
            nib.frame = CGRect(x: 0, y: 0, width: _headerView.frame.width, height: _headerView.frame.height)
        }
        _headerView.addSubview(nib)
        
        //Ajusta Header da tableview
        _tableAppointments.contentInset = UIEdgeInsetsMake(-65, 0, 0, 0);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calendar(calendar: JTCalendarManager!, canDisplayPageWithDate date: NSDate!) -> Bool {
        let dataFim = NSDate(timeInterval: 7776000, sinceDate: NSDate())
        return _calendarManager.dateHelper.date(date, isEqualOrAfter: NSDate(), andEqualOrBefore: dataFim)
    }
    
    func calendar(calendar: JTCalendarManager!, prepareDayView dayView: UIView!) {
        if let castDayView = dayView as? JTCalendarDayView {
            castDayView.hidden = false
            
            castDayView.circleView.backgroundColor = UIColor.whiteColor()
            
            if castDayView.isFromAnotherMonth {
                castDayView.dotView.hidden = true
                castDayView.textLabel.textColor = UIColor.grayColor()
            }
            // Today
            else if(calendar.dateHelper.date(NSDate(), isTheSameDayThan: castDayView.date)){
                castDayView.circleView.hidden = false;
                castDayView.circleView.backgroundColor = UIColor.grayColor();
                castDayView.dotView.backgroundColor = UIColor.whiteColor();
                castDayView.textLabel.textColor = UIColor.whiteColor();
            }
            //Selected date
            else if(calendar.dateHelper.date(_dateSelected, isTheSameDayThan: castDayView.date)){
                castDayView.circleView.hidden = false;
                castDayView.circleView.backgroundColor = UIColor.redColor()
                castDayView.dotView.backgroundColor = UIColor.whiteColor()
                castDayView.textLabel.textColor = UIColor.whiteColor()
            }
            // Another day of the current month
            else{
                castDayView.circleView.hidden = false;
                castDayView.textLabel.textColor = UIColor.blackColor()
                
                castDayView.dotView.hidden = false
                castDayView.dotView.backgroundColor = UIColor.redColor()
            }
        }
    }
    
    func calendar(calendar: JTCalendarManager!, didTouchDayView dayView: UIView!) {
        // Use to indicate the selected date
        
        if let castDayView = dayView as? JTCalendarDayView {
            
            _dateSelected = castDayView.date
            
            // Animation for the circleView
            castDayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)
            UIView.transitionWithView(castDayView, duration: 0.3, options: [],
                animations: {
                    castDayView.circleView.transform = CGAffineTransformIdentity
                    calendar.reload()
                    
                    if self._dateSelected.timeIntervalSinceDate(NSDate()) > 0 {
                        self.GetMobileReservations(calendar)
                    }else{
                        self._listaHorarioDoDia.removeAll()
                        self._tableAppointments.reloadData()
                    }
                    
                },
                completion: { (Bool) -> Void in
                
                }
            )
            
            // Load the previous or next page if touch a day from another month
            if (!calendar.dateHelper.date(_calendarContentView.date, isTheSameMonthThan: castDayView.date)) {
                if(_calendarContentView.date.compare(castDayView.date) == NSComparisonResult.OrderedAscending){
                    _calendarContentView.loadNextPageWithAnimation()
                }
                else{
                    _calendarContentView.loadPreviousPageWithAnimation()
                }
            }
        }
    }
    
    //MARK: WEBSERVICE
    func GetMobileReservations(calendar: JTCalendarManager){
        
        _isWaitingResponse = true
        _listaHorarioDoDia.removeAll()
        _tableAppointments.reloadData()
        
        self._webservice.GetMobileReservations(1, resourceId: 1, dataReserva: self._dateSelected) { (erro, listaReservas) in
            self._isWaitingResponse = false
            
            if erro != nil {
                print(erro)
            }else{
                self._listaHorarioDoDia = listaReservas!
                dispatch_async(dispatch_get_main_queue(),{
                    self._tableAppointments.reloadData()
                })
            }
        }
    }
    
    func PostMobileReservation(reservaPost: ReservaDTO){
        self._webservice.PostMobileReservation(reservaPost) { (erro, reserva) in
            if erro != nil {
                print(erro)
                
            }else{
                
            }
            self._tableAppointments.reloadRowsAtIndexPaths([NSIndexPath(forRow: reservaPost.RowIndex, inSection: 0)], withRowAnimation: .Fade)
        }
    }
}

//# MARK: - TABLE DELEGATE
extension HorariosEmpresa: UITableViewDelegate, UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = NSBundle.mainBundle().loadNibNamed("ReservaTableViewHeader", owner: nil, options: nil)[0] as! ReservaTableViewHeader
        
        containerView.TextoHeader.text = Util.FormataDataParaTituloHeader(self._dateSelected)
        containerView.TextoHeader.textAlignment = .Center
        
        return containerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if _listaHorarioDoDia.count > 0 {
            return _listaHorarioDoDia.count
        }else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        if _dateSelected.timeIntervalSinceDate(NSDate()) > 0 {
            
            if _listaHorarioDoDia.count > 0 {
                
                self._tableAppointments.allowsSelection = true
                
                tableView.registerNib(UINib(nibName: "CalendarioBotaoReservarViewCell", bundle: nil), forCellReuseIdentifier: "CalendarioBotaoReservarViewCell")
                
                let cell = tableView.dequeueReusableCellWithIdentifier("CalendarioBotaoReservarViewCell", forIndexPath: indexPath) as! CalendarioBotaoReservarViewCell
                
                cell._HorarioReserva.text = Util.FormataDataParaTituloReserva(_listaHorarioDoDia[indexPath.row].Start) + "-" + Util.FormataDataParaTituloReserva(_listaHorarioDoDia[indexPath.row].End)
                
                if self._listaHorarioDoDia[indexPath.row].isAvailable {
                    cell._TextoReserva.text = "Reservar"
                    cell._BackgroundView.backgroundColor = UIColor.greenColor()
                }else{
                    cell._TextoReserva.text = "Reservado"
                    cell._BackgroundView.backgroundColor = UIColor.grayColor()
                }
                
                return cell
            }else{
                self._tableAppointments.allowsSelection = false
                
                let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DefaultTableViewCell
                
                if (_isWaitingResponse){
                    cell._centerTitle.text = ""
                    cell._actIcon.hidden = false
                    cell._actIcon.startAnimating()
                }else{
                    cell._centerTitle.text = "Selecione uma data."
                    cell._actIcon.hidden = true
                }
                
                return cell
            }
        }else{
            self._tableAppointments.allowsSelection = false
            
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DefaultTableViewCell
            
            cell._centerTitle.text = "Selecione uma data futura."
            cell._actIcon.hidden = true
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CalendarioBotaoReservarViewCell
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        if self._listaHorarioDoDia[indexPath.row].isAvailable {
            let alert:UIAlertController = UIAlertController(title: "Alerta!", message: "Deseja reservar horario?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Sim", style: UIAlertActionStyle.Default, handler: {
                action in
                
                cell._TextoReserva.text = "Reservando..."
                
                let reserva = ReservaDTO()
                reserva.ReservationStatus = 1
                reserva.ReservationType = 2
                reserva.Start = Util.FormataDataParaEnvioPost(self._listaHorarioDoDia[indexPath.row].Start)
                reserva.End = Util.FormataDataParaEnvioPost(self._listaHorarioDoDia[indexPath.row].End)
                reserva.ClientId = 1
                reserva.CompanyId = 1
                reserva.ResourceId = 1
                reserva.ServiceId = 1
                reserva.RowIndex = indexPath.row
                
                self.PostMobileReservation(reserva)
                
            }))
            alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

}
