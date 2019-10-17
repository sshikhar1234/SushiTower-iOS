//
//  GameScene.swift
//  SushiTower
//
//  Created by Parrot on 2019-02-14.
//  Copyright © 2019 Parrot. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var sushiTower : [SKSpriteNode] = []
    var chopsticks : [SKSpriteNode] = []
    let cat = SKSpriteNode(imageNamed: "character1")
    let sushiBase = SKSpriteNode(imageNamed:"roll")
    var stickPosition = 0
    
    var ctr:Int = 7
    override func didMove(to view: SKView) {
        // add background
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = -2
        addChild(background)
        
        // add cat
        cat.position = CGPoint(x:self.size.width*0.25, y:100)
        addChild(cat)
        
        // add base sushi pieces
        sushiBase.position = CGPoint(x:self.size.width*0.5, y: 100)
        sushiBase.zPosition = -1
        addChild(sushiBase)

        //Create the sushi tower
        for index in 1...6 {
        addSushi()
        }
        
        //add chopstick to the sushi pieces
        addChopStick()
        
    }
    func addChopStick(){
      
    }
    
   func addSushi()   {
    stickPosition = Int.random(in: 0...2)

    let currentSushi = SKSpriteNode(imageNamed: "roll")
    if(self.sushiTower.count == 0){
        currentSushi.position.x = sushiBase.position.x
        currentSushi.position.y = sushiBase.position.y + 100
    }
    else{
            let prevSushi = sushiTower[sushiTower.count - 1]
            currentSushi.position.x = prevSushi.position.x
            currentSushi.position.y = prevSushi.position.y + 100
           }
        addChild(currentSushi)
        sushiTower.append(currentSushi)
    
    
          //Generate numbers from 0 to 2
          //0??
          //Dont spwan chopstick
          //1??
          //Spawn it on right
          // stick.position.x = sushi.position.x + 100
          // stick.position.y = sushi.position.y - 10
          
          //2?
          //Spawn it on left
          // stick.position.x = sushi.position.x - 100
          // stick.position.y = sushi.position.y - 10
          
          if(stickPosition==0){
              //Do nothing
          }
          else if(stickPosition == 1){
               let stick = SKSpriteNode(imageNamed:"chopstick")
               stick.position.x = currentSushi.position.x + 100
               stick.position.y = currentSushi.position.y - 10
            // add chopstick to the screen
                addChild(stick)
            // add the chopstick to the array
                self.chopsticks.append(stick)
            // redraw stick facing other direciton
            let facingRight = SKAction.scaleX(to: -1, duration: 0)
            stick.run(facingRight)
          }
          else if(stickPosition == 2){
                let stick = SKSpriteNode(imageNamed:"chopstick")
                stick.position.x = currentSushi.position.x - 100
                stick.position.y = currentSushi.position.y - 10
              // add chopstick to the screen
                  addChild(stick)
              // add the chopstick to the array
                  self.chopsticks.append(stick)
          }

          sushiBase.zPosition = -1
          for currentSushi in sushiTower{
//              //Take new chopstick node
//              let chopstick = SKSpriteNode(imageNamed: "chopstick")
//
//              //Add it to the Array
//              chopsticks.append(chopstick)
//
//              //Set the X position of the chopstick
//              chopstick.position.x = currentSushi.position.x-100
//              chopstick.position.y = currentSushi.position.y
//              addChild(chopstick)
          }
    }
    
    //Cat hitting the base but the piece on top of base should be removed and the whole towert should come down
    func removeSuShi(){
        //Get the sushi on top of base
        let sushiToRemove = self.sushiTower[0]
        let stickToRemove = self.chopsticks[0]
//        let stickToRemove = self.chopsticks[0]
//        if(sushiToRemove != nil && stickToRemove != nil){
        if(sushiToRemove != nil ){
        //Bring the whole arrray down
            for _ in self.sushiTower{
        }
        for index in 0...(self.sushiTower.count)-1{
            let sushi = self.sushiTower[index]
            
            let dropAction  = SKAction.move(to: CGPoint(x: sushi.position.x, y: sushi.position.y-100), duration: 0.1)
            sushi.run(dropAction)

//            let dropActionChopStick  = SKAction.move(to: CGPoint(x: stickToRemove.position.x, y: stickToRemove.position.y-100), duration: 0.1)
//            stickToRemove.run(dropActionChopStick)
            
        }
        //Remove that sushi and chopstick from screen
        sushiToRemove.removeFromParent()
//        stickToRemove.removeFromParent()

        //Remove that sushi and chopstick from Array
        self.sushiTower.remove(at: 0)
  //      self.chopsticks.remove(at: 0)
            
          
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        // This is the shortcut way of saying:
        //      let mousePosition = touches.first?.location
        //      if (mousePosition == nil) { return }
        
        
        //Define animation images
        let imageOne = SKTexture(imageNamed: "character1")
        let imageTwo = SKTexture(imageNamed: "character2")
        let imageThree = SKTexture(imageNamed: "character3")
        
        //Animation Array
        let punchTexture = [imageOne,imageTwo,imageThree,imageOne]

        
        //Create Animation
        let punchAnimation = SKAction.animate(with: punchTexture, timePerFrame: 0.2)
     
        
        guard let mousePosition = touches.first?.location(in: self) else {
            return
        }
        
        //Right Punch
        if(mousePosition.x>size.width/2)
        {
            cat.position = CGPoint(x:self.size.width*0.75   , y:100)
//           self.cat.position.x = mousePosition.x
            
            //Flip the cat
            let showRight = SKAction.scaleX(to:-1,duration:0)
            self.cat.run(showRight)
            print("RIGHT")
        }
            //Left Punch
        else if(mousePosition.x<size.width/2)
        {
            cat.position = CGPoint(x:self.size.width*0.25, y:100)
//            self.cat.position.x = mousePosition.x

            let showLeft = SKAction.scaleX(to:1,duration:0)
            self.cat.run(showLeft)
            //Runn it
            print("LEFT")
        }
        self.cat.run(punchAnimation, completion: {
            //This gets executed when the animation is done running for 0.2 seconds
            self.removeSuShi()
        })
        
        print(mousePosition)
    }
    
    
    
}
