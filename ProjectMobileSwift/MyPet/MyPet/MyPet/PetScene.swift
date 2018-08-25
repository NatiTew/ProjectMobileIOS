//
//  PetScene.swift
//  MyPet
//
//  Created by NatiTew Munpholsri on 27/7/61.
//  Copyright © พ.ศ. 2561 Natthaphon. All rights reserved.
//

import UIKit
import SpriteKit
import SQLite

class ColliderType {
    static let pet: UInt32 = 1
    static let food: UInt32 = 2
}

class PetScene: SKScene, SKPhysicsContactDelegate {
    var database: Connection!
    
    let usersTable = Table("petTest11")
    
    let chooseType = Expression<Int>("chooseType")
    let staSceneHome = Expression<String>("staSceneHome")
    let staSceneBath = Expression<String>("staSceneBath")
    
    var stafood = "" {
        didSet {
            if !stafood.isEmpty {
                let foodNode = SKSpriteNode(imageNamed: stafood)
                foodNode.size = CGSize(width: 90, height: 90)
                foodNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                let location = CGPoint(x: randomBetweenNumbers(first: 200, second: self.frame.maxX - 200), y: self.frame.maxY + 50)
                foodNode.position = location
                foodNode.physicsBody = SKPhysicsBody(circleOfRadius: foodNode.size.height / 2)
                foodNode.physicsBody?.categoryBitMask = ColliderType.food
                foodNode.physicsBody?.contactTestBitMask = ColliderType.pet
                foodNode.name = "Food"
                foodNode.zPosition = 1
                addChild(foodNode)
            }
        }
    }
    
    

    private var test = SKSpriteNode()
    private var testWalkingFrames: [SKTexture] = []
    
    func randomBetweenNumbers(first: CGFloat, second: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(first - second) + min(first, second)
    }
    
    func loadSQLite() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let  fileUrl = documentDirectory.appendingPathComponent("petTest11").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch  {
            print(error)
        }

    }
    override func didMove(to view: SKView) {
        loadSQLite()
        backgroundColor = SKColor.white
        physicsWorld.contactDelegate = self
        
        var background = SKSpriteNode(imageNamed: " ")
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                if user[self.staSceneHome] == "liviingSet"{
                    var allBackground = [0: "livingroom2.png",
                                         1: "bedroom1.png",
                                         2: "kitchen2.png",
                                         3: "gardent2.png"]
                    
                    let numRan = Int(arc4random_uniform(12))
                     background = SKSpriteNode(imageNamed: allBackground[numRan%4]!)
                }
                else{
                    background = SKSpriteNode(imageNamed: user[self.staSceneHome])
                }
            }
        } catch {
            print("what error")
            print(error)
        }
        
        background.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
            
        buildTest()
        //animateTest()
        
        
        
        let ground = SKSpriteNode()
        ground.position = CGPoint(x: 0, y: 0)
        ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ground.size = CGSize(width: self.frame.maxX, height: self.frame.height / 2 - 50)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 3000, height: self.frame.height / 2 - 50))
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.isDynamic = false
        addChild(ground)
    }
    
    func testMoveEnded() {
        test.removeAllActions()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        //self.removeAllChildren()
        moveTest(location: location)
        
//        var multiplierForDirection: CGFloat
//        if location.x < frame.midX {
//            // walk left
//            multiplierForDirection = 1.0
//        } else {
//            // walk right
//            multiplierForDirection = -1.0
//        }
//
//        test.xScale = abs(test.xScale) * multiplierForDirection
        //animateTest()
    }

    
    func loadPet()->Int {
        var typeNum:Int = 0
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                typeNum = user[self.chooseType]
            }
        } catch {
            print("what error")
            print(error)
        }
        return typeNum
    }
    
    func buildTest() {
        
        var testAnimatedAtlas = SKTextureAtlas(named: "Walk")
        var walkFrames: [SKTexture] = []
//        let typeAni = (Int(arc4random_uniform(4)))+1
        let typeAni = loadPet()
        let ranSet = Int(arc4random_uniform(100))
        if typeAni == 2
        {
            if (ranSet%4) == 0{
                testAnimatedAtlas = SKTextureAtlas(named: "panSet1")
                print("panSet1")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Pan1Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }else if (ranSet%4) == 1{
                testAnimatedAtlas = SKTextureAtlas(named: "panSet2")
                print("panSet2")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Pan2Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }else if (ranSet%4) == 2{
                testAnimatedAtlas = SKTextureAtlas(named: "panSet3")
                print("panSet3")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Pan3Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }else if (ranSet%4) == 3{
                testAnimatedAtlas = SKTextureAtlas(named: "panSet4")
                print("panSet4")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Pan4Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }
        } else if typeAni == 4{
            if (ranSet%4) == 0{
                testAnimatedAtlas = SKTextureAtlas(named: "pinSet1")
                print("pinSet1")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Pin1Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }else if (ranSet%4) == 1{
                testAnimatedAtlas = SKTextureAtlas(named: "pinSet2")
                print("pinSet2")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Pin2Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }else if (ranSet%4) == 2{
                testAnimatedAtlas = SKTextureAtlas(named: "pinSet3")
                print("pinSet3")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Pin3Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }else if (ranSet%4) == 3{
                testAnimatedAtlas = SKTextureAtlas(named: "pinSet4")
                print("pinSet4")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Pin4Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }
        } else if typeAni == 1{
            if (ranSet%4) == 0{
                testAnimatedAtlas = SKTextureAtlas(named: "catSet1")
                print("catSet1")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Cat1Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }else if (ranSet%4) == 1{
                testAnimatedAtlas = SKTextureAtlas(named: "catSet2")
                print("catSet2")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Cat2Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }else if (ranSet%4) == 2{
                testAnimatedAtlas = SKTextureAtlas(named: "catSet3")
                print("catSet3")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Cat3Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }else if (ranSet%4) == 3{
                testAnimatedAtlas = SKTextureAtlas(named: "catSet4")
                print("catSet4")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Cat4Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }
        }else if typeAni == 3{
            if (ranSet%4) == 0{
                testAnimatedAtlas = SKTextureAtlas(named: "dogSet1")
                print("dogSet1")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Dog1Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }else if (ranSet%4) == 1{
                testAnimatedAtlas = SKTextureAtlas(named: "dogSet2")
                print("dogSet2")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Dog2Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }else if (ranSet%4) == 2{
                testAnimatedAtlas = SKTextureAtlas(named: "dogSet3")
                print("dogSet3")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Dog3Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }else if (ranSet%4) == 3{
                testAnimatedAtlas = SKTextureAtlas(named: "dogSet4")
                print("dogSet4")
                let numImages = testAnimatedAtlas.textureNames.count
                for i in 1...numImages {
                    let testTextureName = "Dog4Set0\(i)"
                    walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
                }
            }
        }
        
        //let numImages = testAnimatedAtlas.textureNames.count
//        for i in 1...8 {
//            let testTextureName = "panda_01_walk_0\(i)"
//            walkFrames.append(testAnimatedAtlas.textureNamed(testTextureName))
//        }
        testWalkingFrames = walkFrames
        
        let firstFrameTexture = testWalkingFrames[0]
        test = SKSpriteNode(texture: firstFrameTexture)
        //test.position = CGPoint(x: frame.midX, y: (((self.frame.size.height/4)*2)-((self.frame.size.height/4)*1) ) )
        let wNum = ((self.frame.size.width/5)*2)-((self.frame.size.width/5)/2)
        let hNum = ((self.frame.size.width/4)*2)-((self.frame.size.width/4)/2)
        if typeAni == 2{
            test.size = CGSize(width: 225, height: 225)
        }else{
            test.size = CGSize(width: wNum, height: hNum)
        }
        
        test.position = CGPoint(x: frame.midX, y: 439 )
        test.zPosition = 1
        test.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: test.frame.width, height: test.frame.height))
        test.physicsBody?.affectedByGravity = false
        test.physicsBody?.isDynamic = false
        test.physicsBody?.categoryBitMask = ColliderType.pet
        test.physicsBody?.contactTestBitMask = ColliderType.food
        test.name = "Pet"
        print("\(self.frame.size.height)")
        print("\(self.frame.size.width)")
        addChild(test)
        
        
    }
    
    func animateTest() {
        test.run(SKAction.repeatForever(
            SKAction.animate(with: testWalkingFrames,
                             timePerFrame: 0.15,
                             resize: false,
                             restore: true)),
                 withKey:"walkingInPlaceBear")
    }
    
    func moveTest(location: CGPoint) {
        // 1
        var multiplierForDirection: CGFloat
        
        // 2
        let testSpeed = frame.size.width / 3.0
        
        // 3
        let moveDifference = CGPoint(x: location.x - test.position.x, y: location.y - test.position.y)
        print("location.y")
        print(location.y)
        print("test.position.y")
        print(test.position.y)
        let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
        
        // 4
        let moveDuration = distanceToMove / testSpeed
        
        // 5
        if moveDifference.x < 0 {
            multiplierForDirection = 1.0
        } else {
            multiplierForDirection = -1.0
        }
        test.xScale = abs(test.xScale) * multiplierForDirection
        
        
        // 1
        if test.action(forKey: "walkingInPlaceBear") == nil {
            // if legs are not moving, start them
            animateTest()
        }
        
        // 2
        let moveAction = SKAction.move(to: location, duration:(TimeInterval(moveDuration)))
        
        
        // 3
        let doneAction = SKAction.run({ [weak self] in
            self?.testMoveEnded()
        })
        
        // 4
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        test.run(moveActionWithDone, withKey:"bearMoving")
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Pet" && contact.bodyB.node?.name == "Food" {
            // put your code when pet + food
            
            contact.bodyB.node?.removeFromParent()
        }
    }

    
    
//    let wNum = ((self.frame.size.width/5)*2)-((self.frame.size.width/5)/2)
//   let hNum = ((self.frame.size.width/4)*2)-((self.frame.size.width/4)/2)
    
    
}
