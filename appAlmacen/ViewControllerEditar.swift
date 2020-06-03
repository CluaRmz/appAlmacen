//
//  ViewControllerEditar.swift
//  appAlmacen
//
//  Created by clau93 on 5/30/20.
//  Copyright © 2020 clau93. All rights reserved.
//

import UIKit
import SQLite3

class ViewControllerEditar: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    var vcEdit: Almacen?
    var Almacenes = [Almacen]()
    var db : OpaquePointer?
    let dataJsonUrlClass = JsonClass()
    @IBOutlet weak var txtidProd: UITextField!
    @IBOutlet weak var txtProd: UITextField!
    @IBOutlet weak var txtPrecio: UITextField!
    @IBOutlet weak var txtMarcas: UITextField!
    @IBOutlet weak var txtExistencia: UITextField!
    
    //-----------------------------dropdown----------------------------------
    let marca = ["Bosch","Hilti","Makita","Truper"]
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //-----------------------Dropdown--------------------------
        pickerView.delegate = self
        pickerView.dataSource = self
        txtMarcas.inputView = pickerView
        txtMarcas.textAlignment = .center
        txtMarcas.placeholder = "Select marca"
        //------------------------LlenaCampos---------------------------
        
        txtidProd.text = vcEdit!.idProd
        txtProd.text = vcEdit?.Prod
        txtMarcas.text = vcEdit?.marca
        let precio = Int(vcEdit!.precio)
        txtPrecio.text = String(precio)
        let existe = Int(vcEdit!.exist)
        txtExistencia.text = String(existe)
    }
    @IBAction func btnActualizar(_ sender: UIButton)
    {
        if txtidProd.text!.isEmpty || txtProd.text!.isEmpty || txtMarcas.text!.isEmpty || txtPrecio.text!.isEmpty ||
            txtExistencia.text!.isEmpty
        {
            alerta(title: "Faltan Datos", message: "Completar")
            txtidProd.becomeFirstResponder()
            return
        }else
        {
        
            let idPr = txtidProd.text!
            let prod = txtProd.text!
            let marc = txtMarcas.text!
            let prec = txtPrecio.text!
            let exis = txtExistencia.text!
            
            let datos_a_enviar = ["idProducto":idPr, "nomProducto": prod,"marca":marc,"precio":prec,"existencia":exis] as NSMutableDictionary
            
            dataJsonUrlClass.arrayFromJson(url:"/updateAlmacen.php",datos_enviados:datos_a_enviar)
            { (array_respuesta) in
                
                DispatchQueue.main.async
                    {//proceso principal
                        let diccionario_datos = array_respuesta?.object(at: 0) as! NSDictionary
                        
                        
                        if let msg = diccionario_datos.object(forKey: "message") as! String?
                        {
                            self.alerta(title: "Guardando", message: msg)
                        }
                        
                        self.txtidProd.text=""
                        self.txtProd.text = ""
                        self.txtMarcas.text = ""
                        self.txtPrecio.text = ""
                        self.txtExistencia.text = ""
                }
            }
        }
        self.performSegue(withIdentifier: "segueHome", sender: self)
    }
    @IBAction func btnEliminar(_ sender: UIButton) {
        if (txtidProd.text?.isEmpty)!{
            alerta(title: "Faltan Datos", message: "Completar")
            txtidProd.becomeFirstResponder()
        }else{
            let idAl = txtidProd.text!
            
            let datos_a_enviar = ["idProducto":idAl] as NSMutableDictionary
            
            
            
            dataJsonUrlClass.arrayFromJson(url:"/deleteAlmacen.php",datos_enviados:datos_a_enviar)
            { (array_respuesta) in
                
                DispatchQueue.main.async
                    {
                        
                        let diccionario_datos = array_respuesta?.object(at: 0) as! NSDictionary
                        
                        //ahora ya podemos acceder a cada valor por medio de su key "forKey"
                        if let msg = diccionario_datos.object(forKey: "message") as! String?
                        {
                            self.alerta(title: "Eliminando", message: msg)
                            
                        }
                        
                        self.txtidProd.text=""
                        self.txtProd.text = ""
                        self.txtMarcas.text = ""
                        self.txtPrecio.text = ""
                        self.txtExistencia.text = ""
                        
                }
            }
            
        }//else
        self.performSegue(withIdentifier: "segueHome", sender: self)
    }
    
    //-------------------dropDown---------------------------------------
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return marca.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return marca[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        txtMarcas.text = marca[row]
        txtMarcas.becomeFirstResponder()
    }
    func alerta (title: String, message: String){
        //Crea una alerta
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //Agrega un boton
        alert.addAction(UIAlertAction(title: "Aceptar",style: UIAlertAction.Style.default, handler: nil))
        //Muestra la alerta
        self.present(alert, animated: true, completion: nil)
    }

}
