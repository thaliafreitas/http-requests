//
//  BitCoinViewController.swift
//  HTTPS
//
//  Created by Ada 2018 on 20/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit
struct moeda{
    let tipo: String
    let simbolo: String
    let valor: String
}
class BitCoinViewController: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var labelPreco: UILabel!
    var moedas = [moeda]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func getCoins(_ moeda: String){
        let getUrl = URL(string: "https://blockchain.info/ticker")!
        var getRequest = URLRequest.init(url: getUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        getRequest.httpMethod = "GET"
        
        let getTask = URLSession.shared.dataTask(with: getRequest){
            (data,response,err) in
            if err != nil{
                print("GET Request in \(getRequest) Error: \(err!)")}
            if data != nil{
                do{
                    let resultObjt = try JSONSerialization.jsonObject(with: data!, options: [])
                    DispatchQueue.main.async {
                        var jsonResult: Dictionary = try JSONSerialization.jsonObject(with: resultObjt, options: .mutableLeaves)
//                        } as! @convention(block) () -> Void as! @convention(block) () -> Void as! @convention(block) () -> Void
                }catch{
                    DispatchQueue.main.async {
                        print("Nao foi possivel dar parse no json \(getRequest)")
                    }
                }
            }else{
                print("Recebeu requisicao vazia resposta do \(getRequest)")
            }
            
        }
        DispatchQueue.global(qos: .background).async {
            getTask.resume()
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
    }
}
