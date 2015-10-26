//
//  ViewController.swift
//  oop-game1
//
//  Created by Leonardo Amigoni on 10/25/15.
//  Copyright © 2015 Mozzarello. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var player1AttackButton: UIButton!
    @IBOutlet weak var player2AttackButton: UIButton!
    @IBOutlet weak var player1ButtonLbl: UILabel!
    @IBOutlet weak var player2ButtonLbl: UILabel!
    @IBOutlet weak var player1HpLbl: UILabel!
    @IBOutlet weak var player2HpLbl: UILabel!
    @IBOutlet weak var player1Img: UIImageView!
    @IBOutlet weak var player2Img: UIImageView!
    @IBOutlet weak var printLbl: UILabel!
    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var restartLbl: UILabel!
    
    @IBOutlet weak var introLbl: UILabel!
    @IBOutlet weak var soldierButton: UIButton!
    @IBOutlet weak var orcButton: UIButton!

    
    var attackSound: AVAudioPlayer!
    var deathSound: AVAudioPlayer!
    var game: Game!
    var pickPlayerTurn: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("Attack", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try attackSound = AVAudioPlayer(contentsOfURL: soundURL)
            attackSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        let path1 = NSBundle.mainBundle().pathForResource("Death", ofType: "wav")
        let soundURL1 = NSURL(fileURLWithPath: path1!)
        
        do {
            try deathSound = AVAudioPlayer(contentsOfURL: soundURL1)
            deathSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }

        //startGame()
        game = Game()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onPlayer1AttackButtonPressed(sender: AnyObject) {
        game.hit(game.player1, defendingPlayer: game.player2)
        player2HpLbl.text = "\(game.player2.hp) HP"
        printLbl.text = "\(game.player1.name) attacked for \(game.player1.attackPwr) HP"
        disableButton(player1AttackButton)
        playSound(attackSound)
        
        if !game.player2.isAlive {
            printLbl.text = "\(game.player1.name) Wins"
            player2HpLbl.text = "DEAD"
            player2Img.hidden = true
            gameOverDisplay()
            playSound(deathSound)
        }
    }
    
    @IBAction func onPlayer2AttackButtonPressed(sender: AnyObject) {
        game.hit(game.player2, defendingPlayer: game.player1)
        player1HpLbl.text = "\(game.player1.hp) HP"
        printLbl.text = "\(game.player2.name) attacked for \(game.player2.attackPwr) HP"
        disableButton(player2AttackButton)
        playSound(attackSound)
        
        if !game.player1.isAlive {
            printLbl.text = "\(game.player2.name) Wins"
            player1HpLbl.text = "DEAD"
            player1Img.hidden = true
            gameOverDisplay()
            playSound(deathSound)
        }
    }
    
    @IBAction func onRestartButtonPressed(sender: AnyObject) {
        startGame()
    }
    
    @IBAction func onSoldierButtonPressed(sender: AnyObject) {
        pickCharacter(Soldier())
    }
    
    @IBAction func onOrcButtonPressed(sender: AnyObject) {
        pickCharacter(Orc())
    }
    
    func pickCharacter(character: Character){
        var imageName: String = "player"
        if character.characterType == Character.CharacterType.Orc {
            imageName = "enemy"
        }
        
        if pickPlayerTurn == 1 {
            introLbl.text = "Player 2 - Tap to pick your character"
            game.player1 = character
            player1Img.image = UIImage(named: imageName)
            
            pickPlayerTurn++
        }
        else {
            game.player2 = character
            player2Img.image = UIImage(named: imageName)
            
            pickPlayerTurn = 1
            startGame()
            introLbl.text = "Player 1 - Tap to pick your character"
        }
    }

    func togglePickDisplay(hidden: Bool){
        introLbl.hidden = hidden
        orcButton.hidden = hidden
        soldierButton.hidden = hidden
    }
    
    func gameOverDisplay(){
        game.gameOver()
        player1AttackButton.hidden = true
        player2AttackButton.hidden = true
        player1ButtonLbl.hidden = true
        player2ButtonLbl.hidden = true
        restartButton.hidden = false
        restartLbl.hidden = false
        togglePickDisplay(false)
    }
    
    func startGame(){
        game.startGame()
        restartButton.hidden = true
        restartLbl.hidden = true
        player1Img.hidden = false
        player2Img.hidden = false
        player1AttackButton.hidden = false
        player2AttackButton.hidden = false
        player1ButtonLbl.hidden = false
        player2ButtonLbl.hidden = false
        player1HpLbl.hidden = false
        player2HpLbl.hidden = false
        player1HpLbl.text = "\(game.player1.hp) HP"
        player2HpLbl.text = "\(game.player2.hp) HP"
        printLbl.text = "Press Button to Attack"
        togglePickDisplay(true)
    }
    
    
    func enableButton(timer: NSTimer){
        let userInfo = timer.userInfo as! Dictionary<String, AnyObject>
        let button:UIButton = (userInfo["theButton"] as! UIButton)
        button.enabled = true
    }
    
    func disableButton(button: UIButton){
        button.enabled = false
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("enableButton:"), userInfo: ["theButton" : button], repeats: false)
    }
    
//    func loadSound(var sound: AVAudioPlayer, fileName: String){
//        var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "wav")
//        var soundURL = NSURL(fileURLWithPath: path!)
//        
//        do {
//            try sound = AVAudioPlayer(contentsOfURL: soundURL)
//            sound.prepareToPlay()
//        } catch let err as NSError {
//            print(err.debugDescription)
//        }
//
//    }
    
    func playSound(sound: AVAudioPlayer){
        if sound.playing {
            sound.stop()
        }
        
        sound.play()
    }
}

