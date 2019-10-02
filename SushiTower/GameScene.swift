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
    let cat = SKSpriteNode(imageNamed: "character1")
    let sushiBase = SKSpriteNode(imageNamed:"roll")
    var ctr:Int = 7
    override func didMove(to view: SKView) {
        // add background
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        // add cat
        cat.position = CGPoint(x:self.size.width*0.25, y:100)
        addChild(cat)
        
        // add base sushi pieces
        sushiBase.position = CGPoint(x:self.size.width*0.5, y: 100)
        addChild(sushiBase)
        for index in 1...5 {
        addSushi()
        }
    }
    
    
   func addSushi()   {
    let currentSushi = SKSpriteNode(imageNamed: "roll")
    if(self.sushiTower.count == 0){
        currentSushi.position.x = sushiBase.position.x
        currentSushi.position.y = sushiBase.position.y + 100
    }
    else{
            let prevSushi = sushiTower[sushiTower.count - 1]
            currentSushi.position.x = prevSushi.position.x
            currentSushi.position.y = prevSushi.position.y + 100
            print("Current Sushi X: \(currentSushi.position.x)")
            print("Current Sushi Y: \(currentSushi.position.y)")
            print("BASE Sushi X: \(sushiBase.position.x)")
            print("Current Sushi Y: \(sushiBase.position.y)")
           }
        addChild(currentSushi)
        sushiTower.append(currentSushi)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

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
        })
        
        print(mousePosition)
    }
    
    
    
}
