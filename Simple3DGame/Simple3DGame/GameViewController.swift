//
//  GameViewController.swift
//  Simple3DGame
//
//  Created by M07 on 10/06/2020.
//  Copyright © 2020 M07. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class GameViewController: UIViewController, SCNSceneRendererDelegate {
    
    var gameView: SCNView!
    var gameScene: SCNScene!
    var cameraNode: SCNNode!
    var targetCreationTime: TimeInterval = 0
    
    let attemptsLabel = UILabel()
    let tapStreakLabel = PaddingLabel(withInsets: 0, 15, 0, 0)
    let topScoreLabel = UILabel()
    let countdownLabel = UILabel()
    let redBallsHitLabel = UILabel()
    
    let detailsView = UIView()
    
    var blueBallsMissed: Int = 0
    var redBallsHit: Int = 0
    var touchStreak: Int = 0
    var topScore: Int = 0
    
    let gameOverLabel = UILabel()
    let playAgainButton = UIButton()
    let backToMenuButton = UIButton()
    
    var isNewGame: Bool = true
    var timer = Timer()
    var countdown = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initScene()
        initCamera()
        initLabels()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdownLabel), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountdownLabel() {
        if countdown != 0 {
            countdownLabel.text = "\(countdown)"
            countdown -= 1
            countdownLabel.font = UIFont(name: "Helvetica", size: 48.0)
            countdownLabel.textColor = .systemPink
            
            //gameOverLabel.lineBreakMode = .byWordWrapping
            countdownLabel.numberOfLines = 0
            //gameOverLabel.frame = .init(x: 20, y: self.view.frame.height / 2, width: self.view.frame.width - 40, height: 300)
            countdownLabel.frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: self.view.frame.width, height: 100)
            countdownLabel.center = self.view.center
            countdownLabel.textAlignment = .center
            //gameOverLabel.sizeToFit()
            countdownLabel.isEnabled = false
            view.addSubview(countdownLabel)
        }
    }
    
    @objc func restartGame() {
        blueBallsMissed = 0
        touchStreak = 0
        countdown = 3
        isNewGame = true
        
        playAgainButton.removeFromSuperview()
        gameOverLabel.removeFromSuperview()
        backToMenuButton.removeFromSuperview()

        initView()
        initScene()
        initCamera()
        initLabels()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdownLabel), userInfo: nil, repeats: true)
    }
    
    @objc func backToMenu() {
        dismiss(animated: true) {
            self.restartGame()
        }
    }
    
    func initView() {
        gameView = self.view as! SCNView
        gameView.allowsCameraControl = true
        gameView.autoenablesDefaultLighting = true
        
        gameView.delegate = self
    }
    
    func initScene() {
        gameScene = SCNScene()
        gameView.scene = gameScene
        
        gameView.isPlaying = true
    }
    
    func initCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        cameraNode.position = SCNVector3(0.0, 5.0, 10.0)
        gameScene.rootNode.addChildNode(cameraNode)
        gameView.allowsCameraControl = false
        
    }
    
    func initLabels() {
        
        detailsView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 230)
        //detailsView.backgroundColor = .black
        view.addSubview(detailsView)
        
        tapStreakLabel.text = "\(touchStreak)"
        tapStreakLabel.font = UIFont(name: "comic andy", size: 100.0)
        tapStreakLabel.textColor = .black
        tapStreakLabel.textAlignment = .center
        tapStreakLabel.lineBreakMode = .byWordWrapping
        tapStreakLabel.numberOfLines = 1
        //tapStreakLabel.frame = CGRect(x: self.view.center.x, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        tapStreakLabel.frame.size.width = 200
        tapStreakLabel.frame.size.height = 75
        tapStreakLabel.center = self.detailsView.center
        
        //touchStreakLabel.sizeToFit()
        tapStreakLabel.isEnabled = false
        //tapStreakLabel.backgroundColor = .red
        detailsView.addSubview(tapStreakLabel)
        
        let streakLabelY = tapStreakLabel.frame.maxY
        
        attemptsLabel.text = "Blue balls missed: \(blueBallsMissed)"
        attemptsLabel.font = UIFont(name: "Helvetica Neue Light", size: 30.0)
        attemptsLabel.textColor = .black
        attemptsLabel.textAlignment = .center
        attemptsLabel.lineBreakMode = .byWordWrapping
        attemptsLabel.numberOfLines = 1
        //attemptsLabel.frame = .init(x: 20, y: 60, width: 150, height: 25)
        attemptsLabel.frame = CGRect(x: self.detailsView.center.x, y: streakLabelY, width: 200, height: 25)
        //attemptsLabel.sizeToFit()
        //tapStreakLabel.frame.size.width = 150
        //tapStreakLabel.frame.size.height = 25
        attemptsLabel.center.x = detailsView.center.x
        attemptsLabel.isEnabled = false
        //attemptsLabel.backgroundColor = .yellow
        detailsView.addSubview(attemptsLabel)
        
        let ballsMissedLabelY = attemptsLabel.frame.maxY
        
        redBallsHitLabel.text = "Red balls hit: \(redBallsHit)"
        redBallsHitLabel.font = UIFont(name: "Helvetica Neue Light", size: 30.0)
        redBallsHitLabel.textColor = .black
        redBallsHitLabel.textAlignment = .center
        redBallsHitLabel.lineBreakMode = .byWordWrapping
        redBallsHitLabel.numberOfLines = 1
        //attemptsLabel.frame = .init(x: 20, y: 60, width: 150, height: 25)
        redBallsHitLabel.frame = CGRect(x: self.detailsView.center.x, y: ballsMissedLabelY, width: 200, height: 25)
        //attemptsLabel.sizeToFit()
        //tapStreakLabel.frame.size.width = 150
        //tapStreakLabel.frame.size.height = 25
        redBallsHitLabel.center.x = detailsView.center.x
        redBallsHitLabel.isEnabled = false
        //redBallsHitLabel.backgroundColor = .yellow
        detailsView.addSubview(redBallsHitLabel)
        
        
        view.sendSubviewToBack(detailsView)
        
    }
    
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func showGameOverText() {
        
        gameOverLabel.text = "Game Over"
        gameOverLabel.font = UIFont(name: "Helvetica", size: 48.0)
        gameOverLabel.textColor = .systemPink
        
        //gameOverLabel.lineBreakMode = .byWordWrapping
        gameOverLabel.numberOfLines = 0
        //gameOverLabel.frame = .init(x: 20, y: self.view.frame.height / 2, width: self.view.frame.width - 40, height: 300)
        gameOverLabel.frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: self.view.frame.width, height: 100)
        gameOverLabel.center = self.view.center
        gameOverLabel.textAlignment = .center
        //gameOverLabel.sizeToFit()
        gameOverLabel.isEnabled = false
        view.addSubview(gameOverLabel)
        
        let labelY = gameOverLabel.frame.maxY
        print(labelY)
        
        
        
        playAgainButton.setTitle("Play again", for: .normal)
        playAgainButton.setTitleColor(.black, for: .normal)
        playAgainButton.frame = CGRect(x: 0, y: labelY, width: self.view.frame.width, height: 45)
        //playAgainButton.backgroundColor = .black
        playAgainButton.isUserInteractionEnabled = true
        
        playAgainButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        
        view.addSubview(playAgainButton)
        
        let playAgainButtonY = playAgainButton.frame.maxY
        
        backToMenuButton.setTitle("Back to menu", for: .normal)
        backToMenuButton.setTitleColor(.black, for: .normal)
        backToMenuButton.frame = CGRect(x: 0, y: playAgainButtonY, width: self.view.frame.width, height: 45)
         
        backToMenuButton.isUserInteractionEnabled = true
        
        backToMenuButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
        
        view.addSubview(backToMenuButton)
    
        
    }
    
    func createTarget() {
        let geometry: SCNGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 10)
        
        let randomColor = arc4random_uniform(2) == 0 ? UIColor.systemTeal : UIColor.systemPink
        
        geometry.materials.first?.diffuse.contents = randomColor
        
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        if randomColor == UIColor.systemPink {
            geometryNode.name = "enemy"
        } else {
            geometryNode.name = "friend"
        }
        
        
        
        gameScene.rootNode.addChildNode(geometryNode)
        
        let randomDirection: Float = arc4random_uniform(2) == 0 ? -1.0 : 1.0
        
        let force = SCNVector3(randomDirection, 15.0, 0)
        
        geometryNode.physicsBody?.applyForce(force, at: SCNVector3(0.05, 0.05, 0.05), asImpulse: true)
    }
    
    func cleanUp() {
        for node in gameScene.rootNode.childNodes {
            if node.presentation.position.y < -2 {
                node.removeFromParentNode()
                if node.name == "friend" {
                    DispatchQueue.main.async {
                        self.blueBallsMissed += 1
                        if self.blueBallsMissed < 5 {
                            
                            self.attemptsLabel.text = "Blue balls missed: \(self.blueBallsMissed)"
                        } else {
                            self.attemptsLabel.text = "Blue balls missed: \(self.blueBallsMissed)"
                            
                            if self.isKeyPresentInUserDefaults(key: "TopScore") == true {
                                if self.touchStreak > UserDefaults.standard.integer(forKey: "TopScore") {
                                    UserDefaults.standard.set(self.touchStreak, forKey: "TopScore")
                                }
                            }
                            self.gameScene.isPaused = true
                            self.showGameOverText()
                        }
                    }
                }
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        if isNewGame == true {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.countdownLabel.removeFromSuperview()
                self.timer.invalidate()
                if time > self.targetCreationTime {
                    self.createTarget()
                    self.targetCreationTime = time + 0.6
                }
                self.isNewGame = false
            }
        } else {
            
            if touchStreak < 20 {
                if time > targetCreationTime {
                    createTarget()
                    targetCreationTime = time + 0.6
                    print("LEVEL 1: \(targetCreationTime)")
                    
                }
            } else if touchStreak >= 20 && touchStreak < 40 {
                if time > targetCreationTime {
                    createTarget()
                    targetCreationTime = time + 0.55
                    print("LEVEL 2: \(targetCreationTime)")
                }
            } else if touchStreak >= 40 && touchStreak < 60 {
                if time > targetCreationTime {
                    createTarget()
                    targetCreationTime = time + 0.5
                    print("LEVEL 3: \(targetCreationTime)")
                }
            } else if touchStreak >= 60 && touchStreak < 80 {
                if time > targetCreationTime {
                    createTarget()
                    targetCreationTime = time + 0.45
                    print("LEVEL 4: \(targetCreationTime)")
                }
            } else if touchStreak >= 80 && touchStreak < 100 {
                if time > targetCreationTime {
                    createTarget()
                    targetCreationTime = time + 0.4
                    print("LEVEL 5: \(targetCreationTime)")
                }
            } else if touchStreak >= 100 && touchStreak < 150 {
                if time > targetCreationTime {
                    createTarget()
                    targetCreationTime = time + 0.3
                    print("LEVEL 6: \(targetCreationTime)")
                }
            } else if touchStreak >= 150 {
                if time > targetCreationTime {
                    createTarget()
                    targetCreationTime = time + 0.25
                    print("LEVEL 6: \(targetCreationTime)")
                }
            }
        }
        cleanUp()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        let location = touch.location(in: gameView)
        let hitList = gameView.hitTest(location, options: nil)
        
        if let hitObject = hitList.first {
            let node = hitObject.node
                
            if node.name == "friend" {
                //do whatever you want when touched here
                node.removeFromParentNode()
                touchStreak += 1
                tapStreakLabel.text = "\(touchStreak)"
                //topScoreLabel.sizeToFit()
            } else if node.name == "enemy"{
                node.removeFromParentNode()
                if isKeyPresentInUserDefaults(key: "TopScore") == true {
                    if touchStreak > UserDefaults.standard.integer(forKey: "TopScore") {
                        UserDefaults.standard.set(touchStreak, forKey: "TopScore")
                    }
                }
                redBallsHit += 1
                if redBallsHit < 3 {
                    redBallsHitLabel.text = "Red balls hit: \(redBallsHit)"
                } else {
                    redBallsHitLabel.text = "Red balls hit: \(redBallsHit)"
                    gameScene.isPaused = true
                    showGameOverText()
                }
            }
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

}
