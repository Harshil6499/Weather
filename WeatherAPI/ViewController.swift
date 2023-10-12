//
//  ViewController.swift
//  WeatherAPI
//
//  Created by Apple on 11/08/23.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var MyWatherImageView: UIImageView!
    @IBOutlet weak var PrintTamplbl: UILabel!
    @IBOutlet weak var CurrentTime: UILabel!
    @IBOutlet weak var WishForGoodDay: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Weather_API()
  
    }
        //API_CALLING__________________-
        
    func Weather_API (){
        
        let Weather_API_URL = "https://api.openweathermap.org/data/2.5/weather?lat=23.033863&lon=72.585022&appid=0a122e8d92134ba4d08b15ae799ab9a1"
        
        AF.request(Weather_API_URL).responseJSON{(response) in
            switch response.result{
                
            case .success:
                
                let weatherdata = try? JSON (data: response.data!)
                let weather_data = weatherdata!["main"]
                   // print(weather_data)
                  let temp = weather_data["temp"].doubleValue
                let a = temp - 273.15
                let final_Temp = Int(a)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm a"
                //dateFormatter.timeZone = TimeZone.current
                let currentTime = dateFormatter.string(from: Date())
                self.CurrentTime.text = currentTime
                
                let Hour = Calendar.current.component(.hour, from: Date())
                
    
                // Good Mroning
                if (Hour >= 6 && Hour <= 8){
                    self.MyWatherImageView.image = UIImage(named: "Sunrise.jpg")
                    
                    
                }
                //Good Morning 2
                else if(Hour >= 9 && Hour <= 11){
                    if (final_Temp >= 30){
                        self.MyWatherImageView.image = UIImage(named: "Sun.jpg")
                    }
                    else{
                        self.MyWatherImageView.image = UIImage(named: "Sun&Cloud.jpg")
                    }
                }
                //Good Afternoon
                else if (Hour >= 12 && Hour <= 17){
                    if (final_Temp >= 30){
                        self.MyWatherImageView.image = UIImage(named: "Sun.jpg")
                    }
                    else{
                       
                        self.MyWatherImageView.image = UIImage(named: "Sun&Cloud.jpg")
                    }
                }
               //Good Evening
               else if (Hour >= 18 && Hour <= 20 ){
                        self.MyWatherImageView.image = UIImage(named: "Sunset.jpg")
                }
                //Good Night
                else{
                    if (final_Temp <= 30){
                        self.MyWatherImageView.image = UIImage(named: "Moon.jpg")
                        //self.view.backgroundColor = .black
                    }
                    else {
                        self.MyWatherImageView.image = UIImage(named: "Full Moon.jpg")
                       // self.view.backgroundColor = .black
                    }
                }
                
                if (Hour >= 5 && Hour <= 11){
                    self.WishForGoodDay.text = ("ɢᴏᴏᴅ ᴍᴏʀɴɪɴɢ")
                }
                else if (Hour >= 12 && Hour <= 18){
                    self.WishForGoodDay.text = ("ɢᴏᴏᴅ ᴀꜰᴛᴇʀɴᴏᴏɴ")
                }
                else if(Hour >= 19 && Hour <= 24){
                    self.WishForGoodDay.text = ("ɢᴏᴏᴅ ᴇᴠᴇɴɪɴɢ")
                }
                else{
                    self.WishForGoodDay.text = ("ɢᴏᴏᴅ ɴɪɢʜᴛ")
                }

                    self.PrintTamplbl.text = ("\(final_Temp)°")
                    break
            case .failure:
                break
            }
        }
    }
}

