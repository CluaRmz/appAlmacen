//
//  ViewController.swift
//  appAlmacen
//
//  CCreated by clau93 on 5/30/20.
//  Copyright © 2020 clau93. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    var db : OpaquePointer?
    var Almacenes = [Almacen]()
    let dataJsonUrlClass = JsonClass()
    //-----------------------------dropdown----------------------------------
    let marcas = ["Bosch","Hilti","Makita","Truper"]
    let pickerView = UIPickerView()
    
    @IBOutlet weak var txtProducto: UITextField!
    @IBOutlet weak var txtMarca: UITextField!
    @IBOutlet weak var txtPrecio: UITextField!
    @IBOutlet weak var txtExistencia: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //----------------------------dropdown---------------------------------
        pickerView.delegate = self
        pickerView.dataSource = self
        txtMarca.inputView = pickerView
        txtMarca.textAlignment = .center
        txtMarca.placeholder = "Select of Marca"
        
    }//viewdidloa
    @IBAction func btnGuardar(_ sender: UIButton) {
        if txtProducto.text!.isEmpty || txtMarca.text!.isEmpty || txtPrecio.text!.isEmpty
            || txtExistencia.text!.isEmpty
            
        {
            alerta(title: "Validacion de datos", message: "Faltan llenar campos")
            txtProducto.becomeFirstResponder()
        }
        else
        {
            let pro = txtProducto.text
            let mar = txtMarca.text
            let pre = txtPrecio.text
            let exi = txtExistencia.text
            
            let datos_a_enviar = ["nomProducto": pro!,"marca": mar,"precio":pre,"existencia":exi] as NSMutableDictionary
            
            dataJsonUrlClass.arrayFromJson(url:"/insertAlmacen.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
                
                DispatchQueue.main.async {//proceso principal
                    let diccionario_datos = array_respuesta?.object(at: 0) as! NSDictionary
                    
                    //ahora ya podemos acceder a cada valor por medio de su key "forKey"
                    if let msg = diccionario_datos.object(forKey: "message") as! String?
                    {
                        self.alerta(title: "Guardado", message: msg)
                    }
                    self.txtProducto.text = ""
                    self.txtMarca.text = ""
                    self.txtPrecio.text = ""
                    self.txtExistencia.text = ""
                }
            }
            
        }//else
        
    }
    @IBAction func btnNext(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueMarca", sender: self)
    }
    //-------------------dropDown---------------------------------------
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return marcas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return marcas[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        txtMarca.text = marcas[row]
        txtMarca.resignFirstResponder()
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

