//
//  Almacen.swift
//  appAlmacen
//
//  Created by clau93 on 5/30/20.
//  Copyright © 2020 clau93. All rights reserved.
//

import Foundation
class Almacen{
    var idProd : String
    var Prod: String
    var marca: String
    var precio: Int
    var exist: Int
    init (idProducto: String, producto: String,marca: String,precio: Int, existencia:Int){
        self.idProd = idProducto
        self.Prod = producto
        self.marca = marca
        self.precio = precio
        self.exist = existencia
    }
    
}
