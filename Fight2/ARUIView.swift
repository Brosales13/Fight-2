//
//  ARUIView.swift
//  Fight
//
//  Created by Brian Rosales on 5/25/22.
//

import UIKit
import SwiftUI

struct ARUIView: View {
    @EnvironmentObject var data: DataModel
    @State var currentProgress1: CGFloat = 0
    @State var currentProgress2: CGFloat = 0
    @State var didPlayerWin = false
    @State var isGameOver = false
    @State var enemyHealth = 300
    @State var userHealth = 300
    @State var buttonColor : Color = Color.red
    
    @State var isPad = UIDevice.current.userInterfaceIdiom == .pad
    
    
    func EnemyDamage(Damage: Int) {
        if Damage == 20 {
            (data.arView.scene.anchors[0] as? AllMightScene.Scene)?.notifications.worldpunch.post()
        } else {
            (data.arView.scene.anchors[0] as? AllMightScene.Scene)?.notifications.worldkick.post()
        }
        enemyHealth = enemyHealth - Damage
        if enemyHealth <= 0 {
            print("ENEMY HAS BEEN DEFEATED")
            isGameOver = true
            didPlayerWin = true
        }
        print("EnemyHealth: \(enemyHealth)")
        
        self.currentProgress2 += CGFloat(Damage)
                }
    
    func UserDamage(randomAttack: Int){
        userHealth = userHealth - randomAttack
        if userHealth <= 0 {
            print("USER HAS BEEN DEFEATED")
            isGameOver = true
            didPlayerWin = false
        }
        print("UserHealth: \(userHealth)")
        
        self.currentProgress1 += CGFloat(randomAttack)
       
    }
    
    func EnemyTypeAttack() {
        let secondsToDelay = 4.0
        DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
           print("This message is delayed")
           // Put any code you want to be delayed here
            let attackTypes = [50,15,0,10]
            let randomAttack = attackTypes.randomElement()!
            
            if randomAttack == 0{
                (data.arView.scene.anchors[0] as? AllMightScene.Scene)?.notifications.combo.post()
                print("Attack Missed")
            }
            if randomAttack == 50 {
                (data.arView.scene.anchors[0] as? AllMightScene.Scene)?.notifications.supriseattack.post()
                print("Damaged Recieved: \(randomAttack)")
            }
            if randomAttack == 15{
                (data.arView.scene.anchors[0] as? AllMightScene.Scene)?.notifications.flipkick.post()
                print("Damaged Recieved: \(randomAttack)")
            }
            if randomAttack == 10 {
                (data.arView.scene.anchors[0] as? AllMightScene.Scene)?.notifications.combo.post()            }
            
            UserDamage(randomAttack: randomAttack)
            
        }
        
    }
    
    var body: some View {
        HStack{
            VStack{
                if isGameOver && didPlayerWin {
                    Button(action: {
                        print("GAME RESTARTING")
                        self.enemyHealth = 300
                        self.userHealth = 300
                        self.isGameOver = false
                        self.didPlayerWin = false
                        self.currentProgress1 = 0
                        self.currentProgress2 = 0
                    
                    }, label: {
                        //everything pretaining to the button
                        Text("CONGRATS! TRY AGAIN?")
                            .foregroundColor(.white)
                            .frame(width: 500, height: 100)
                            .background(Color.black)
                            .cornerRadius(15)
                        
                    })
                    
                }else if isGameOver && didPlayerWin == false {
                    Button(action: {
                        print("GAME RESTARTING")
                        self.enemyHealth = 300
                        self.userHealth = 300
                        self.isGameOver = false
                        self.didPlayerWin = false
                        self.currentProgress1 = 0
                        self.currentProgress2 = 0
                    
                    
                    }, label: {
                        //everything pretaining to the button
                        Text("GAME OVER. TRY AGAIN?")
                            .foregroundColor(.white)
                            .frame(width: 500, height: 100)
                            .background(Color.black)
                            .cornerRadius(15)
                        
                    })
                }
            }
        }
        
        ZStack{
    
            HStack{
                VStack{
                    Text("User")
                        .fontWeight(.bold)
                    ZStack(alignment: .leading){
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.gray)
                            .frame(width: 300, height: 20)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.red)
                            .frame(width: 300 - currentProgress1, height: 20)
                    }
                    Spacer()
                }
                
                Spacer()
                    
                VStack{
                    Text("All-Might")
                        .fontWeight(.bold)
                    ZStack(alignment: .trailing){
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.gray)
                            .frame(width: 300, height: 20)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.blue)
                            .frame(width: 300 - currentProgress2, height: 20)
                    }
                    Spacer()
                }
            }
            
            // Button Location/size
            HStack{
                VStack{
                    Spacer()
                    Button(action: {
                        self.buttonColor = Color.gray
                        
                        DispatchQueue.global(qos: .background).async {
                            print("first attack")
                            self.EnemyDamage(Damage: 20)
                            self.EnemyTypeAttack()
                            let secondsToDelay = 7.0
                            DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                                self.buttonColor = Color.red
                            }
                            
                        }
                    }, label: {
                        //everything pretaining to the button
                        Text("First Attack")
                            .foregroundColor(.white)
                            .frame(width: isPad ? 500 : 250, height: isPad ? 100 : 50)
                            .background(buttonColor)
                            .cornerRadius(15)
                        
                    }).disabled(self.buttonColor == .gray)
                    .padding()
                    
                    
                    Button(action: {
                        self.buttonColor = .gray
                        DispatchQueue.global(qos: .background).async {
                            print("Second attack")
                            self.EnemyDamage(Damage: 30)
                            self.EnemyTypeAttack()
                            let secondsToDelay = 7.0
                            DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                                self.buttonColor = Color.red
                            }
                        }
                        
                    
                        
                    }, label: {
                        //everything pretaining to the button
                        Text("Second Attack")
                            .foregroundColor(.white)
                            .frame(width: isPad ? 500 : 250, height: isPad ? 100 : 50)
                            .background(self.buttonColor)
                            .cornerRadius(15)
                        
                    })
                    .disabled(self.buttonColor == .gray)
                }
            }
        }
     
    }
}


struct ARUIView_Previews: PreviewProvider {
    static var previews: some View {
        ARUIView()
    }
}
