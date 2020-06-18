//
//  HomeView.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/15.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI

var screenWidth = UIScreen.main.bounds.width
var screenHeight = UIScreen.main.bounds.height


struct HomeView: View {
        let main_color = Color(red: 233/255, green: 241/255, blue: 250/255)
        let shadow_light = Color(red: 207/255, green: 215/255, blue: 224/255)
        let shadow_dark = Color(red: 255/255, green: 255/255, blue: 255/255)
        let mode_color = "hoge"
        let comment = "あと30歩歩けば\nモードがリセットされます"

        var body: some View {
            ZStack(){
                
                main_color.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center){
                    Text("現在のモード")
                        .font(.title)
                        .foregroundColor(Color(red:88/255,green:88/255,blue:88/255))
                        .frame(width:screenWidth)
                    
                    ZStack(){
                        Circle()
                            .fill(main_color)
                            .frame(width:screenWidth/3,height:screenWidth/3)
                            .shadow(color: shadow_light, radius: 10, x: 10, y: 10)
                            .shadow(color: shadow_dark, radius: 10, x: -5, y: -5)
                        
                        Circle()
                            .fill(LinearGradient(
                                gradient: Gradient(colors:[Color.pink,Color.yellow]), startPoint: .top, endPoint: .bottom
                            ))
                            .frame(width:screenWidth/3-15,height:screenWidth/3-15)
                    }
                                    
                    Text(comment)
                        .foregroundColor(Color(red:88/255,green:88/255,blue:88/255))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(width:screenWidth)
                        .padding(EdgeInsets(top:20.0,leading:0.0,bottom:30.0,trailing:0.0))
                                    
                    //button wrap
                    VStack(spacing:20){
                        //light on/off
                        Button(action: {
                            print("power button")
                        }) {
                          Image("power")
                            .frame(width: 90, height: 90)
                            .imageScale(.large)
                            .foregroundColor(Color(red:88/255,green:88/255,blue:88/255))
                        }
                        .background(main_color)
                        .clipShape(Circle())
                        .shadow(color: shadow_light, radius: 10, x: 10, y: 10)
                        .shadow(color: shadow_dark, radius: 10, x: -5, y: -5)

                        //AR
                        Button(action: {
                            print("AR button")
                        }) {
                          Image("AR")
                            .frame(width: 90, height: 90)
                            .imageScale(.large)
                            .foregroundColor(Color(red:88/255,green:88/255,blue:88/255))
                            }
                            .background(main_color)
                            .clipShape(Circle())
                            .shadow(color: shadow_light, radius: 10, x: 10, y: 10)
                            .shadow(color: shadow_dark, radius: 10, x: -5, y: -5)

                        //疲れ度
                        Button(action: {
                            print("approve button")
                        }) {
                          Image("approve")
                            .frame(width: 90, height: 90)
                            .imageScale(.large)
                            .foregroundColor(Color(red:88/255,green:88/255,blue:88/255))
                            }
                            .background(main_color)
                            .clipShape(Circle())
                            .shadow(color: shadow_light, radius: 10, x: 10, y: 10)
                            .shadow(color: shadow_dark, radius: 10, x: -5, y: -5)
                        }
                    }   //button wrap
                }   //VStack wrap
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
    }

struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            Group{
                HomeView().previewDevice(PreviewDevice(rawValue: "iPhone 7 Plus"))
                HomeView().previewDevice(PreviewDevice(rawValue: "iPhone 7"))
            }
        }
    }
