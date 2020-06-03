//
//  ViewControllerMarca.swift
//  appAlmacen
//
//  Created by clau93 on 5/30/20.
//  Copyright © 2020 clau93. All rights reserved.
//

import UIKit
import SQLite3

class ViewControllerMarca: UIViewController {

    var db: OpaquePointer?
    var Almacenes = [Almacen]()
    let dataJsonUrlClass = JsonClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    
    @IBAction func btnBosch(_ sender: UIButton) {
        Almacenes.removeAll()
        
        let datos_a_enviar = ["id": ""] as NSMutableDictionary
        
        
        
        dataJsonUrlClass.arrayFromJson(url:"/getBosch.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
            
            DispatchQueue.main.async
                {//proceso principal
                let cuenta = array_respuesta?.count
                
                for indice in stride(from: 0, to: cuenta!, by: 1)
                    {
                    let tarea = array_respuesta?.object(at: indice) as! NSDictionary
                    let idpro = tarea.object(forKey: "idProducto") as! String?
                    let pord = tarea.object(forKey: "nomProducto") as! String?
                    let marc = tarea.object(forKey: "marca") as! String?
                    let prec = tarea.object(forKey: "precio") as! String?
                    let exis = tarea.object(forKey: "existencia") as! String?
                        self.Almacenes.append(Almacen(idProducto: idpro!, producto: pord!, marca: marc!, precio: Int(prec!)!, existencia: Int(exis!)!))
                    
                    }

                self.performSegue(withIdentifier: "segueProd", sender: self)
                }
        }
    }
    @IBAction func btnHilti(_ sender: UIButton) {
        Almacenes.removeAll()
        
        let datos_a_enviar = ["id": ""] as NSMutableDictionary
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        
        dataJsonUrlClass.arrayFromJson(url:"/getHilti.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
            
            DispatchQueue.main.async
                {//proceso principal
                    let cuenta = array_respuesta?.count
                    
                    for indice in stride(from: 0, to: cuenta!, by: 1)
                    {
                        let tarea = array_respuesta?.object(at: indice) as! NSDictionary
                        let idPr = tarea.object(forKey: "idProducto") as! String?
                        let pord = tarea.object(forKey: "nomProducto") as! String?
                        let marc = tarea.object(forKey: "marca") as! String?
                        let prec = tarea.object(forKey: "precio") as! String?
                        let exis = tarea.object(forKey: "existencia") as! String?
                        self.Almacenes.append(Almacen(idProducto: idPr!,producto: pord!, marca: marc!, precio: Int(prec!)!, existencia: Int(exis!)!))
                        //.append(Producto(idProd: idprod, nomProd: nomprod, Existencia: existe, Precio: pre) )
                    }
                    
                    self.performSegue(withIdentifier: "segueProd", sender: self)
            }
        }
    }
    @IBAction func btnMakita(_ sender: UIButton) {
        Almacenes.removeAll()
        
        let datos_a_enviar = ["id": ""] as NSMutableDictionary
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        
        dataJsonUrlClass.arrayFromJson(url:"/getMakita.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
            
            DispatchQueue.main.async
                {//proceso principal
                    let cuenta = array_respuesta?.count
                    
                    for indice in stride(from: 0, to: cuenta!, by: 1)
                    {
                        let tarea = array_respuesta?.object(at: indice) as! NSDictionary
                        let idPr = tarea.object(forKey: "idProducto") as! String?
                        let pord = tarea.object(forKey: "nomProducto") as! String?
                        let marc = tarea.object(forKey: "marca") as! String?
                        let prec = tarea.object(forKey: "precio") as! String?
                        let exis = tarea.object(forKey: "existencia") as! String?
                        self.Almacenes.append(Almacen(idProducto: idPr!, producto: pord!, marca: marc!, precio: Int(prec!)!, existencia: Int(exis!)!))
                        //.append(Producto(idProd: idprod, nomProd: nomprod, Existencia: existe, Precio: pre) )
                    }
                    
                    self.performSegue(withIdentifier: "segueProd", sender: self)
            }
        }
    }
    @IBAction func btnTruper(_ sender: UIButton) {
        Almacenes.removeAll()
        
        let datos_a_enviar = ["id": ""] as NSMutableDictionary
        
        
        
        dataJsonUrlClass.arrayFromJson(url:"/getTruper.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
            
            DispatchQueue.main.async
                {//proceso principal
                    let cuenta = array_respuesta?.count
                    
                    for indice in stride(from: 0, to: cuenta!, by: 1)
                    {
                        let tarea = array_respuesta?.object(at: indice) as! NSDictionary
                        let idPr = tarea.object(forKey: "idProducto") as! String?
                        let pord = tarea.object(forKey: "nomProducto") as! String?
                        let marc = tarea.object(forKey: "marca") as! String?
                        let prec = tarea.object(forKey: "precio") as! String?
                        let exis = tarea.object(forKey: "existencia") as! String?
                        self.Almacenes.append(Almacen(idProducto: idPr!, producto: pord!, marca: marc!, precio: Int(prec!)!, existencia: Int(exis!)!))
                        
                    }
                    
                    self.performSegue(withIdentifier: "segueProd", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueProd" {
            let lista = segue.destination as! TableViewController
            lista.Almacenes = Almacenes
        }
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
