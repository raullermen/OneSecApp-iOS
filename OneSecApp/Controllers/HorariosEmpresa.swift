//
//  HorariosEmpresa.swift
//  OneSecApp
//
//  Created by Raul Lermen on 2/21/16.
//  Copyright © 2016 Raul Lermen. All rights reserved.
//

import UIKit
import JTCalendar

class HorariosEmpresa: UIViewController, JTCalendarDelegate {

    var _webservice = Webservice()
    
    @IBOutlet weak var _calendarContentView: JTHorizontalCalendarView!
    @IBOutlet weak var _tableAppointments: UITableView!
    @IBOutlet weak var _headerView: UIView!
    
    var _calendarManager = JTCalendarManager()
    var _dateSelected = NSDate()
    
    var _listaHorario = Array<HorarioEmpresaDTO>()
    var _listaHorarioDoDia = Array<HorarioEmpresaDTO>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AjustaLayout()
        
        _calendarManager.delegate = self
        _calendarManager.contentView = _calendarContentView
        _calendarManager.setDate(NSDate())
        _calendarManager.reload()
        
        _listaHorario = _webservice.RetornaListaHorarios()
        
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
    
    func AtualizaHorariosDoDia(){
        _listaHorarioDoDia = _listaHorario.filter { c in c.isSameDateThan(self._dateSelected) }
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
                    self.AtualizaHorariosDoDia()
                    calendar.reload()
                    self._tableAppointments.reloadData()
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
}

//# MARK: - TABLE DELEGATE
extension HorariosEmpresa: UITableViewDelegate, UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = NSBundle.mainBundle().loadNibNamed("ReservaTableViewHeader", owner: nil, options: nil)[0] as! ReservaTableViewHeader
        
        containerView.TextoHeader.text = "Horarios da Terça-Feira - 28/04/2016"
        containerView.TextoHeader.textAlignment = .Center
        
        return containerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if _listaHorarioDoDia.count > 0 {
            //return _listaHorarioDoDia.count
            return 5
        }else{
            return 5
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        if  true == true /*  _dateSelected.timeIntervalSinceDate(NSDate()) > 0  */ {
            if _listaHorarioDoDia.count == 0 { //MUDAR CONDICAO PARA > 0 NO FINAL
                //cell._centerTitle.text = _listaHorarioDoDia[indexPath.row].retornaData()
                
                tableView.registerNib(UINib(nibName: "CalendarioBotaoReservarViewCell", bundle: nil), forCellReuseIdentifier: "CalendarioBotaoReservarViewCell")
                
                let cell = tableView.dequeueReusableCellWithIdentifier("CalendarioBotaoReservarViewCell", forIndexPath: indexPath) as! CalendarioBotaoReservarViewCell
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DefaultTableViewCell
                
                if (indexPath.row == 3){
                    cell._centerTitle.text = "nao tem nada marcado"
                }else{
                    cell._centerTitle.text = ""
                }
            }
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DefaultTableViewCell
            
            if (indexPath.row == 3){
                cell._centerTitle.text = "Selecione uma data"
            }else{
                cell._centerTitle.text = ""
            }
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DefaultTableViewCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! DefaultTableViewCell
        
        let alert:UIAlertController = UIAlertController(title: "Alerta!", message: "Deseja reservar horario?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Sim", style: UIAlertActionStyle.Default, handler: {
            action in
            
            
            let reserva = ReservaDTO()
            reserva.EmpresaId = 1
            reserva.EmpresaNome = "Empresa teste"
            reserva.ReservaId =  1 //Estatus que vai dizer "enviado para aprovacao"
            reserva.ServicoNome = "Corte de cabelo"
            reserva.ReservaData = NSDate()
            
            //ReservaNSManagedObject.save
            
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    
}
