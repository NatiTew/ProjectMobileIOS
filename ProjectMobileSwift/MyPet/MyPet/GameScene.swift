//
//  GameScene.swift
//  Solo Mission
//
//  Created by Natthaphon on 1/8/61.
//  Copyright © พ.ศ. 2561 Natthaphon. All rights reserved.
//

import SpriteKit
import GameplayKit
import SQLite

class GameScene: SKScene ,SKPhysicsContactDelegate {
    var database: Connection!
    
    let usersTable = Table("petTest11")
    
    let chooseType = Expression<Int>("chooseType")
    let coin = Expression<Int>("coin")
    
    var viewController: UIViewController?
    
    var player = SKSpriteNode(imageNamed: "alien")
    
    var gameTimer: Timer!
    var gameTimerDisplay: Timer!
    var gameStopStatus:Bool = false
    var TimeCount:Int = 10
    var Timelabel = SKLabelNode(fontNamed: "The Bold Font")
    let tabToStartLabel = SKLabelNode(fontNamed: "The Bold Font")
    let tabToReStart = SKLabelNode(fontNamed: "The Bold Font")
    var touchz = 0
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(Min min: CGFloat,Max max: CGFloat) -> CGFloat {
        return random() * (max-min) + min
    }
    var gameArea: CGRect

    struct PhysicsCategories {
        static let None : UInt32 = 0
        static let Player : UInt32 = 0b1
        static let Enemy : UInt32 = 0b100
    }

    func updateCoin(coinUp: Int){
        var coinDB: Int = -100
        var typeDB: Int = 0
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                typeDB = user[self.chooseType]
                coinDB = user[self.coin]
                
                let payMoney = coinDB + coinUp
                
                let id = self.usersTable.filter(self.chooseType == typeDB)
                let updateMon = id.update(self.coin <- payMoney)
                
                do {
                    print("Updte Mon")
                    try self.database.run(updateMon)
                } catch {
                    print(error)
                }
            }
        } catch {
            print("what error priceFood")
            print(error)
        }
    }
    
    override init(size: CGSize) {
        let maxAspectRation: CGFloat = 16.0/9.0
        let playableWidth = size.width / maxAspectRation
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        super.init(size: size)
        
    }

    required init?(coder aDecoder: NSCoder) {
        self.gameArea = CGRect()
        super.init(coder: aDecoder)}
    
    override func didMove(to view: SKView) {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let  fileUrl = documentDirectory.appendingPathComponent("petTest11").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch  {
            print(error)
        }
//        let background = SKSpriteNode(imageNamed: "galaxy2")
//        background.size = CGSize.init(width: 1024, height: 2048)
//        background.position = CGPoint(x: 1 ,y: 1)
//        background.zPosition = 0
//        self.addChild(background)
        let hNum = ((self.frame.size.width/4)*2)-((self.frame.size.width/4)/2)
        player.setScale(0.5)
        print(hNum)
        player.position = CGPoint(x: self.size.width/20 ,y: -(hNum/2)-50 )
        player.size = CGSize(width: 150, height: 150)
        player.zPosition = 2
        
        
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody!.isDynamic = true
        player.physicsBody!.affectedByGravity = false
        
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        player.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        player.physicsBody!.usesPreciseCollisionDetection = true
        
        self.addChild(player)
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        Timelabel.text = "T i m e : \(TimeCount)"
        Timelabel.position = CGPoint(x:0,y:240)
        Timelabel.fontColor = SKColor.white
        self.addChild(Timelabel)
        
        tabToStartLabel.text = "TAB TO START"
        tabToStartLabel.fontSize = 72
        tabToStartLabel.fontColor = SKColor.white
        tabToStartLabel.zPosition = 1
        tabToStartLabel.position = CGPoint(x: 0.5, y: 0.5)
        self.addChild(tabToStartLabel)
        
    }
    
    func spawnEnemy() {
        let randomStart = random(Min : -(self.size.width/2),Max : (self.size.width/2))
        let randomEnd = random(Min : -(self.size.width/2),Max : (self.size.width/2))
        
        let startPoint = CGPoint(x: randomStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomEnd, y: -self.size.height * 0.4)
        
        let enemy = SKSpriteNode(imageNamed: "rockspace")
        enemy.setScale(1)
        enemy.position = startPoint
        enemy.zPosition = 2
        
        
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.isDynamic = true
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.categoryBitMask = PhysicsCategories.Enemy
        enemy.physicsBody!.collisionBitMask = PhysicsCategories.None
        enemy.physicsBody!.contactTestBitMask = PhysicsCategories.Player
        
        
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 2.5)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy])
        enemy.run(enemySequence)
        
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let amountToRotate = atan2(dy, dx)
        enemy.zRotation = amountToRotate
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask && !self.gameStopStatus
        {
            body1 = contact.bodyA
            body2 = contact.bodyB
        }
//        else{
//            body1 = contact.bodyB
//            body2 = contact.bodyA
//        }


        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Enemy && !self.gameStopStatus {
            //if the player has hit the enemy
            //print("IN")
            
            if body1.node != nil {
                spawnExplosion(spawnPosition: body1.node!.position)
            }
            
            if body2.node != nil {
                spawnExplosion(spawnPosition: body2.node!.position)
            }
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            if(!self.gameStopStatus){
                self.gameStopLose()
            }
            
            
        }
    }
    
    func spawnExplosion(spawnPosition: CGPoint){
        
        let explosion = SKSpriteNode(imageNamed: "bombber")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0.5)
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([ scaleIn,fadeOut,delete])

        explosion.run(explosionSequence)
        
        
    }
    
    @available(iOS 10.0, *)
    func startLevel() {
            if #available(iOS 10.0, *) {
                gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    self.spawnEnemy()
                }
                gameTimerDisplay = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    if(self.TimeCount<=0){
                        self.gameStopWin()
                    }else{
                        self.TimeCount-=1
                    }
                    self.Timelabel.text = "T i m e : \(self.TimeCount)"
                    
                }
            } else {
                // Fallback on earlier versions
            }
    
    }
    
    func gameStopWin(){
        gameStopStatus = true
        gameTimer.invalidate()
        gameTimer=nil
        self.gameTimerDisplay.invalidate()
        self.gameTimerDisplay = nil
        let ImgGameWin = SKSpriteNode(imageNamed: "winner")
        ImgGameWin.alpha = 0
        ImgGameWin.name = "winner"
        self.addChild(ImgGameWin)
        let fade = SKAction.fadeAlpha(to: 1, duration: 0.5)
        ImgGameWin.run(fade)
        
        tabToReStart.text = "Ending The Game"
        tabToReStart.fontSize = 50
        tabToReStart.fontColor = SKColor.white
        tabToReStart.zPosition = 1
        tabToReStart.position = CGPoint(x: 0, y: -220)
        updateCoin(coinUp: 20)
        //self.addChild(tabToReStart)
        
        //touchz = 0
        
    }
    func gameStopLose(){
        gameStopStatus = true
        gameTimer.invalidate()
        gameTimer=nil
        self.gameTimerDisplay.invalidate()
        self.gameTimerDisplay = nil
        let ImgGameOver = SKSpriteNode(imageNamed: "gameoverr")
        ImgGameOver.alpha = 0
        ImgGameOver.name = "GameOver"
        self.addChild(ImgGameOver)
        let fade = SKAction.fadeAlpha(to: 1, duration: 0.5)
        ImgGameOver.run(fade)
        
        tabToReStart.text = "Ending The Game"
        tabToReStart.fontSize = 50
        tabToReStart.fontColor = SKColor.white
        tabToReStart.zPosition = 1
        tabToReStart.position = CGPoint(x: 0, y: -205)
        //self.addChild(tabToReStart)
        
        //touchz = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchz += 1
        if touchz == 1 {
            tabToStartLabel.alpha = 0
            if #available(iOS 10.0, *) {
                self.startLevel()
            } else{
                // Fallback on earlier versions
                
            }
        }
//        for touch:UITouch in touches{
//            let pointOfTouch = touch.location(in:self)
//            let nodeTouch = self.nodes(at: pointOfTouch)
//            for TouchItem: SKNode in nodeTouch{
//                let node:SKSpriteNode? = TouchItem as? SKSpriteNode
//                if(node !== nil){
//                    if(TouchItem.name == "GameOver"){
//                        //touchz = 1
//                        //self.removeAllChildren()
//                        //let newScene = GameScene(size: self.scene!.size)
//                        //newScene.scaleMode = self.scaleMode
//                        //newScene.anchorPoint = CGPoint(x:0.5,y:0.5)
//                        //let animation = SKTransition.fade(withDuration: 1.0)
//                        //self.view?.presentScene(newScene, transition: animation)
//                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                        let nextpage = storyboard.instantiateViewController(withIdentifier: "Start")
//                        self.viewController?.present(nextpage,animated: true, completion: nil)
//
//                    }
//                    if(TouchItem.name == "winner"){
//                        //touchz = 1
//                        //self.removeAllChildren()
//                        //let newScene = GameScene(size: self.scene!.size)
//                        //newScene.scaleMode = self.scaleMode
//                        //newScene.anchorPoint = CGPoint(x:0.5,y:0.5)
//                        //let animation = SKTransition.fade(withDuration: 1.0)
//                        //self.view?.presentScene(newScene, transition: animation)
//
//                    }
//
//                }
//            }
//        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in:self)
            let previousPointOfTouch = touch.previousLocation(in:self)
            
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            if(!gameStopStatus){
                player.position.x += amountDragged
            }
        }
    }
}
