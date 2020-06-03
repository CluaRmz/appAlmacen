//
//  jsonClass.swift
//  appAlmacen
//
//  Created by clau93 on 5/30/20.
//  Copyright © 2020 clau93. All rights reserved.
//

import Foundation
import UIKit

class JsonClass: NSObject {
    
    //constantes de nuestra clase
    let urlBase = "https://webserviceclaudio.000webhostapp.com/"//url del servidor remoto
    
    let key = "123456abcde"//key que autoriza nuestra app para extrauer datos
    let model = UIDevice.current.model//modelo del dispositivo iPhone / iPod / iPad
    let iddevice = UIDevice.current.identifierForVendor!.uuidString//
    let langStr = Locale.current.languageCode!//idioma del dispositivo
    let fecha = "2020-01-01"
    
    func arrayFromJson(url:String,datos_enviados:NSMutableDictionary, comletionHandler: @escaping (NSArray?) -> Void){
        
        let url = URL(string: "\(urlBase)/\(url)")!
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: datos_enviados)
        
        //realizamos la petición al servidor remoto
        
        let task = URLSession.shared.dataTask(with: request) { datos_recibidos, response, error in
            if error != nil{//detectamos un error y devolvemos el array vacío
                comletionHandler(nil)
            }
            else{
                do {
                    print("datos recibidos: \(String(describing: String(data: datos_recibidos!, encoding: .utf8))) - datos enviados: \(datos_enviados)")
                    if let array = try JSONSerialization.jsonObject(with: datos_recibidos!) as? NSArray {
                        
                        comletionHandler(array)
                    }
                } catch let parseError {
                    
                    print("error servidor PHP \(String(data: datos_recibidos!, encoding: .utf8)) \(parseError)")
                    
                    comletionHandler(nil)
                }
            }
        }
        task.resume()
    }
    
}
