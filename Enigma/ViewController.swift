//
//  ViewController.swift
//  Enigma
//
//  Created by Sunhye Choi on 4/4/20.
//  Copyright © 2020 Sunhye Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordPicker: UIPickerView!
    @IBOutlet weak var info: UIScrollView!
    @IBOutlet weak var quitButton2: UIButton!
    @IBOutlet weak var menuOptions: UIView!
    @IBOutlet weak var multiLine: UITextView!
    @IBOutlet weak var copyText: UILabel!
    @IBOutlet weak var singleLine: UITextField!
    var hold: String = ""
    var copyCount: Double = 0.0
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var menu: UIView!
    @IBOutlet weak var button: UIButton!
    var code: [Int] = []
    @IBOutlet weak var secretDiary: UIView!
    @IBOutlet weak var passwordEncrypt: UIView!
    var count2 = 0.005
    var count: Double = 0
    @IBOutlet weak var titleView: UIStackView!
    override func viewDidLoad() {

        super.viewDidLoad()
        singleLine.backgroundColor = UIColor(hue: 180/360, saturation: 10/100, brightness: 99/100, alpha: 1.0)
        singleLine.textColor = UIColor(hue: 185/360, saturation: 17/100, brightness: 96/100, alpha: 1.0)
        copyText.layer.cornerRadius = 10
        button.layer.cornerRadius = 10
        quitButton2.layer.cornerRadius = 10
        passwordPicker.delegate = self as! UIPickerViewDelegate
        passwordPicker.dataSource = self as! UIPickerViewDataSource
    }
    struct defaultsKey {
        static let passwordName: Array<String> = Array<String>()
        static let password: Array<String> = Array<String>()
    }
    func textFieldShouldReturn(_textField: UITextField) {
        self.view.endEditing(true)
    }
    @IBAction func menuSelectButton(_ sender: UIButton) {
        menuOptions.alpha = 0
        if sender.currentTitle! == "Secret Diary" {
            secretDiary.alpha = 1
            passwordEncrypt.alpha = 0
            menuOptions.alpha = 0
            quitButton2.alpha = 1
            info.alpha = 0
        }
        else if sender.currentTitle! == "Password Encryption" {
            passwordEncrypt.alpha = 1
            secretDiary.alpha = 0
            info.alpha = 0
            menuOptions.alpha = 0
            quitButton2.alpha = 0
        }
        else {
            passwordEncrypt.alpha = 0
            menuOptions.alpha = 0
            info.alpha = 1
            menuOptions.alpha = 0
            quitButton2.alpha = 0
        }
        multiLine.isEditable = false
         multiLine.isEditable = true
        textFieldShouldReturn(_textField: singleLine)
        menuOptions.alpha = 0
    }
    
    @IBAction func quitEditing(_ sender: Any) {
        multiLine.isEditable = false
        multiLine.isEditable = true
       textFieldShouldReturn(_textField: singleLine)
        
    }
    @IBAction func encryptButton(_ sender: Any) {
        encrypt(messege: hold)
        copyCount = 1
    }
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        Timer.scheduledTimer(timeInterval: count2, target: self, selector: #selector(update), userInfo: nil, repeats : true)
    }
    @IBAction func menuButton(_ sender: UIButton) {
        secretDiary.alpha = 0
        passwordEncrypt.alpha = 0
        quitButton2.alpha = 0
        menuOptions.alpha = 1
        multiLine.isEditable = false
         multiLine.isEditable = true
        textFieldShouldReturn(_textField: singleLine)
    }
    @objc func update() {
        let passwordTitles = defaultsKey.passwordName
        
        if count <= 100 {
            titleView.alpha -= 0.01
        }
        else {
            if count == 101 {
                menuOptions.alpha = 1
            }
            count2 = 0.00001
            menu.alpha = 1
            if secretDiary.alpha == 1 {
                hold = multiLine.text
            }
            if passwordEncrypt.alpha == 1 {
                hold = singleLine.text ?? ""
            }
            if copyCount > 0 {
                copyCount += 1
                if copyCount == 300 {
                    copyCount = 0
                    copyText.alpha = 0
                }
                else if copyCount > 200 {
                    copyText.alpha = CGFloat((100 - (copyCount - 200)) * 0.01)
                }
                else if copyCount <= 100 {
                    copyText.alpha = CGFloat(copyCount * 0.01)
                }
                
            }
        }
        count += 1
    }
    func encrypt(messege: String) {
        let letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "!" , "@" , "#" , "$" , "%" , "^" , "&" , "*" , "(" , ")" , "_" , "-" , "+" , "=" , "{" , "[" , "]" , "}" , "\\" , "|" , ":" , ";" , "\"" , "\'" , "<" , "," , ">" , "." , "?" , "/" , "~" , "`", "A" , "B" , "C" , "D" , "E" , "F" , "G" , "H" , "I" , "J" , "K" , "L" , "M" , "N" , "O" , "P" , "Q" , "R" , "S" , "T" , "U" , "V" , "W" , "X" , "Y" , "Z", " "]
        var enText = ""
        var c = 0
        for i in messege {
            var enter = true
            code.append(Int.random(in: 1...letters.count-1))
            var count = 0
            for a in letters {
                if String(i) == a {
                    enText += String(letters[(count + code[c]) % letters.count])
                    enter = false
                    break
                }
                count += 1
            }
            c += 1
            if enter {
                enText += """


"""
            }
        }
        UIPasteboard.general.string = enText
    }
    
}

