//
//  TableViewController.swift
//  appAlmacen
//
//  Created by clau93 on 5/30/20.
//  Copyright © 2020 clau93. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    //---------------------------------llena editar--------------------------------------
    var agEdit : Almacen?
    
    var Almacenes = [Almacen]()

    @IBOutlet var tabla: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Almacenes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda") as! TableViewCell
        let alm : Almacen
        alm = Almacenes[indexPath.row]
        
        cell.lblProducto.text = alm.Prod
        cell.lblPrecio.text = String(alm.precio)
        cell.lblExistencia.text = String(alm.exist)
        return cell    }
//---------------------------------llena editar--------------------------------------
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        agEdit = Almacenes[indexPath.row]
        self.performSegue(withIdentifier: "segueEditar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEditar"{
            let vce = segue.destination as! ViewControllerEditar
            vce.vcEdit = self.agEdit
        }
    }

}
