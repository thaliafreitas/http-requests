//
//  ViewController.swift
//  HTTPS
//
//  Created by Ada 2018 on 20/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //getRequest()
        //doPostRequest()
//        deleteRequest()
        puto()
        getRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBOutlet weak var lbNumChar: UILabel!
    
    @IBOutlet weak var textViewHTML: UITextView!
    
    @IBAction func button(_ sender: Any) {
        self.textViewHTML.text = "Carregando..."
        doDownloadWebPage()
    }
    
    func doDownloadWebPage (){
        
        let httpURL = URL(string: "https://www.ifce.edu.br")!
        let httpTask = URLSession.shared.dataTask(with: httpURL) {
            (data, response, erro) in
            guard let validData = data, erro == nil else {
                print ("Erro obtendo o website \(httpURL) \n")
                return
            }
            let results = String.init(data: validData, encoding: String.Encoding.utf8) ?? "Erro decodificando o website \(httpURL) \n"
            
            DispatchQueue.main.async {
                self.lbNumChar.text = String (results.count)
                self.textViewHTML.text = results
            }
        }
        DispatchQueue.global(qos: .background).async {
            httpTask.resume()
        }
    }
    
    func getRequest(){
        
        let getUrl = URL(string: "https://ios-twitter.herokuapp.com/api/v1/message")!
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
                        print("Results \(getRequest) :\n \(resultObjt)")
                    }
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
    
    
    
    func doPostRequest(){
        
        let postURL = URL(string: "https://ios-twitter.herokuapp.com/api/v1/message")!
        var postRequest = URLRequest(url: postURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        postRequest.httpMethod = "POST"
        postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        postRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let parameters : [String: Any] = ["text": "E bota uma moda boa, vamos curtir a noite de patroa"]
        
        do {
            let JSONParams = try JSONSerialization.data(withJSONObject: parameters, options: [])
            postRequest.httpBody = JSONParams
            
        }catch {
            print("Error: unable to add parameters to POST request in \(postRequest)")
        }
        
        let postTask = URLSession.shared.dataTask(with: postRequest) {
            (data, response, error) in
            if error != nil {
                print("POST Request in \(postRequest) Error: \(error)")
            }
            
            if data == nil {
                DispatchQueue.main.async {
                    print("Received empty response.")
                }
            } else {
                do {
                    let resultObject = try JSONSerialization.jsonObject(with: data!, options: [])
                    DispatchQueue.main.async {
                        print("Results from POST \(postRequest) :\n \(resultObject)")
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("Unable to parse JSON response")
                    }
                }
            }
        }
        DispatchQueue.global(qos: .background).async {
            postTask.resume()
        }

        }
    func deleteRequest(){
        let id = "5ba3a812faf1620004704797"
        let deleteUrl = URL(string: "https://ios-twitter.herokuapp.com/api/v1/message/"+id)!
        var deleteRequest = URLRequest.init(url: deleteUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        deleteRequest.httpMethod = "DELETE"
        
        let deleteTask = URLSession.shared.dataTask(with: deleteRequest){
            (data,response,err) in
            if err != nil{
                print("GET Request in \(deleteRequest) Error: \(err!)")}
            if data != nil{
                do{
                    let resultObjt = try JSONSerialization.jsonObject(with: data!, options: [])
                    DispatchQueue.main.async {
                        print("Results \(deleteRequest) :\n \(resultObjt)")
                    }
                }catch{
                    DispatchQueue.main.async {
                        print("Nao foi possivel dar parse no json \(deleteRequest)")
                    }
                }
            }else{
                print("Recebeu requisicao vazia resposta do \(deleteRequest)")
            }
            
        }
        DispatchQueue.global(qos: .background).async {
            deleteTask.resume()
        }
    }
    
    
    func puto(){
        let id = "5ba3ac0cfaf16200047047a6"
        let deleteUrl = URL(string: "https://ios-twitter.herokuapp.com/api/v1/message/"+id)!
        var deleteRequest = URLRequest.init(url: deleteUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        deleteRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        deleteRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        deleteRequest.httpMethod = "PUT"
        
        let parameters : [String: Any] = ["text": "Vote Cabo Daciolo. Gloria a Deux!"]
        
        do {
            let JSONParams = try JSONSerialization.data(withJSONObject: parameters, options: [])
            deleteRequest.httpBody = JSONParams
            
        }catch {
            print("Error: unable to add parameters to POST request in \(deleteRequest)")
        }
        
        let postTask = URLSession.shared.dataTask(with: deleteRequest) {
            (data, response, error) in
            if error != nil {
                print("POST Request in \(deleteRequest) Error: \(error!)")
            }
            
            if data == nil {
                DispatchQueue.main.async {
                    print("Received empty response.")
                }
            } else {
                do {
                    let resultObject = try JSONSerialization.jsonObject(with: data!, options: [])
                    DispatchQueue.main.async {
                        print("Results from POST \(deleteRequest) :\n \(resultObject)")
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("Unable to parse JSON response")
                    }
                }
            }
        }
        DispatchQueue.global(qos: .background).async {
            postTask.resume()
        }
    }
}
