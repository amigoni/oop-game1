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
    
    var attackSound: AVAudioPlayer!
    var deathSound: AVAudioPlayer!
    var game: Game!
    
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

        startGame()
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

    
    func gameOverDisplay(){
        game.gameOver()
        player1AttackButton.hidden = true
        player2AttackButton.hidden = true
        player1ButtonLbl.hidden = true
        player2ButtonLbl.hidden = true
        restartButton.hidden = false
        restartLbl.hidden = false
    }
    
    func startGame(){
        game = Game()
        game.startGame()
        restartButton.hidden = true
        restartLbl.hidden = true
        player1Img.hidden = false
        player2Img.hidden = false
        player1AttackButton.hidden = false
        player2AttackButton.hidden = false
        player1ButtonLbl.hidden = false
        player2ButtonLbl.hidden = false
        player1HpLbl.text = "\(game.player1.hp) HP"
        player2HpLbl.text = "\(game.player2.hp) HP"
        printLbl.text = "Press Button to Attack"
    }
    
    
    func enableButton(button: UIButton){
        button.enabled = true
    }
    
    func disableButton(button: UIButton){
        button.enabled = false
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "enableButton", userInfo: nil, repeats: false)
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

