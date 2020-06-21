//
//  HomeView.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI

var screenWidth = UIScreen.main.bounds.width
var screenHeight = UIScreen.main.bounds.height


struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    
    let main_color = Color(red: 233/255, green: 241/255, blue: 250/255)
    let shadow_light = Color(red: 207/255, green: 215/255, blue: 224/255)
    let shadow_dark = Color(red: 255/255, green: 255/255, blue: 255/255)
    let gradient_start = UnitPoint.init(x: 0, y: 0)
    let gradient_end = UnitPoint.init(x: 1, y: 1)
    let mode_color = "hoge"
    let comment = "Walk 30 steps"
    let hamutaro = Color(red:0/255,green:158/255,blue:250/255)
    
    var body: some View {
        NavigationView{
            ZStack(){
                main_color.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center){
                    
                    ZStack(){
                        Circle()
                            .fill(main_color)
                            .frame(width:screenWidth/2+40,height:screenWidth/2+40)
                            .shadow(color: shadow_light, radius: 10, x: 10, y: 10)
                            .shadow(color: shadow_dark, radius: 10, x: -5, y: -5)
                        
                        Circle()
                            .fill(LinearGradient(
                                gradient: Gradient(colors:[Color.pink,Color.yellow]), startPoint: .top, endPoint: .bottom
                            ))
                            .frame(width:screenWidth/2+20,height:screenWidth/2+20)
                        
                        Text(comment)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    .padding(.top, 20.0)
                    
                    Spacer()
                    
                    //button wrap
                    VStack(spacing:20){
                        ZStack{
                            //light off
                            Circle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors:[Color(red:195/255,green:202/255,blue:210/255),Color(red:249/255,green:255/255,blue:255/255)]), startPoint: gradient_start, endPoint: gradient_end
                                ))
                                .frame(width: 90, height: 90)
//                                .shadow(color: shadow_light, radius: 10, x: 10, y: 10)
//                                .shadow(color: shadow_dark, radius: 10, x: -5, y: -5)
                            
                            Image(systemName: "power")
                                .foregroundColor(Color(red:82/255,green:191/255,blue:255/255))
                                .font(.system(size: 30))
                                .shadow(color: hamutaro, radius: 7, x: 0, y: 0)
                            
                        }
                        
                        //light on
                        //                        ZStack{
                        //                            Circle()
                        //                                .fill(main_color)
                        //                                .frame(width: 90, height: 90)
                        //                                .shadow(color: shadow_light, radius: 10, x: 10, y: 10)
                        //                                .shadow(color: shadow_dark, radius: 10, x: -5, y: -5)
                        //
                        //                            Image("power")
                        //                        }
                        
                        //AR
                        self.presenter.arLink(){
                            ZStack{
                                Circle()
                                    .fill(main_color)
                                    .frame(width: 90, height: 90)
                                    .shadow(color: shadow_light, radius: 10, x: 10, y: 10)
                                    .shadow(color: shadow_dark, radius: 10, x: -5, y: -5)
                                
                                Image("AR")
                                    .foregroundColor(Color(red:88/255,green:88/255,blue:88/255))
                            }
                            
                        }
                        
                        //Check
                        self.presenter.checkLink(){
                            ZStack{
                                Circle()
                                    .fill(main_color)
                                    .frame(width: 90, height: 90)
                                    .shadow(color: shadow_light, radius: 10, x: 10, y: 10)
                                    .shadow(color: shadow_dark, radius: 10, x: -5, y: -5)
                                
                                Image("approve")
                                    .foregroundColor(Color(red:88/255,green:88/255,blue:88/255))
                            }
                        }
                    }   //button wrap - ZStack
                    Spacer()
                }   //ZStack
            }   //VStack
                .navigationBarTitle(Text("Teepod"), displayMode: .inline)
        }   //ZStack
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }   //navigation view
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = HomePresenter()
        return Group{
            HomeView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7 Plus"))
            HomeView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7"))
        }
    }
}
