//
//  ViewController.swift
//  Copy the Bunny
//
//  Created by 陳佩琪 on 2023/7/3.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageList[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        imageItem = imageList[row]
        
        if imageItem != "" {
            print(imageItem)
            imagePickerButton.setTitle(imageItem, for: .normal)
            hideButton.isHidden = false
            
            bunnyImage.imageContent.image = UIImage(named: imageItem)
            updateBunny()
        }
    }
    
//pickerView區
    let imageList = ["愛心","珍珠奶茶","小籠包","芒果冰","鳳梨酥","台灣啤酒","臭豆腐","肉燥飯","夜市","茄芷袋","藍白拖","悠遊卡","大同電鍋","台北101","三合院","寺廟","新台幣","春聯","旗袍","腳底按摩","考卷","台灣地圖","注音","繁體中文"]
    var imageItem = ""
    let imagePickerButton = UIButton(type: .system)
    let hideButton = UIButton(type: .system)
    
//兔兔文字顯示區
    let bunnyLabel = UILabel()
    var faceString = "(  •_•)\n"
    
    var bunnySymbol = BunnySymbol(ear: "(\\_/)\n", face: "(  •_•)\n", actionleft: "/>", emojiContent: "❤️", actionRight: ">")
    var bunnyImage = BunnyImage(ear: NSMutableAttributedString(string: "(\\_/)\n"), face: NSMutableAttributedString(string: "( •_•)\n"), actionleft: NSMutableAttributedString(string: "/>"), imageContent:NSTextAttachment(image: UIImage(named: "愛心")!)  , actionRight: NSMutableAttributedString(string: ">"))

    let facialExpressionArray = [Emotion.general,Emotion.glad,Emotion.speechless,Emotion.angry]
    let actionArray = [Action.holding,Action.handingOut,Action.carrying,Action.takingBack]
    var bodyActionIndex = 0

    var emojiSize = 48.0
    var emojiLocation = 0.0

    var imageSize = 48.0
    var imageLocation = -8.0
    
//設定選項區
    let sizeSlider = UISlider()
    let emojiOrImage = UISegmentedControl()
    
//關閉鍵盤
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
           view.endEditing(true)
       }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 390, height: 844))
        backgroundView.backgroundColor = UIColor(red: 249/255, green: 237/255, blue: 229/255, alpha: 1)
        view.addSubview(backgroundView)
        
//兔兔label
        bunnyLabel.frame = CGRect(x: 50, y: 69, width: 290, height: 290)
        backgroundView.addSubview(bunnyLabel)
        bunnyLabel.backgroundColor = UIColor.white
        bunnyLabel.layer.cornerRadius = 20
        bunnyLabel.clipsToBounds = true
        bunnyLabel.numberOfLines = 0
        bunnyLabel.font = UIFont.systemFont(ofSize: 48)
        bunnyLabel.textAlignment = .center
        
//符號
        bunnyLabel.attributedText = NSAttributedString(bunnySymbol.makeBunny())

//圖片
        bunnyImage.imageContent.image = UIImage(named: imageList[0])
        bunnyImage.imageContent.bounds = CGRect(x: 0, y: imageLocation, width: imageSize, height: imageSize)
        
        
//一鍵複製按鈕
        let copyButton = UIButton(type: .system)
        backgroundView.addSubview(copyButton)
        copyButton.frame = CGRect(x: 252, y: 334, width: 84, height: 24)
        copyButton.backgroundColor = .gray
        copyButton.tintColor = .white
        copyButton.layer.cornerRadius = 12
        copyButton.clipsToBounds = true
        copyButton.setTitle("複製！", for: .normal)
        
        copyButton.addAction(UIAction { [self]action in
            UIPasteboard.general.string = bunnyLabel.text
            copyButton.setTitle("已複製", for: .highlighted)
        }, for: .touchUpInside)
        
        
//標題文字
        let titleLabel = UILabel(frame: CGRect(x: 30, y: 389, width: 330, height: 400))
        backgroundView.addSubview(titleLabel)
        var titleContent = AttributedString()
        
        var line1 = AttributedString("換掉這隻兔子手上的東西\n")
        var line2 = AttributedString("然後複製牠貼到任何地方\n\n\n\n\n")
        line1.font = UIFont.boldSystemFont(ofSize: 24)
        line2.font = UIFont.systemFont(ofSize: 20)
        titleContent += line1
        titleContent += line2
        
        var options = AttributedString("物品：\n表情：\n動作：\n大小：\n上下：                                      關燈：")
        options.font = UIFont.boldSystemFont(ofSize: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 36
        options.paragraphStyle = paragraphStyle
        titleContent += options
        
        titleLabel.attributedText = NSAttributedString(titleContent)
        titleLabel.numberOfLines = 0
        
        
//切換符號 or 圖片 segmented control
        emojiOrImage.frame = CGRect(x: 60, y: 464, width: 270, height: 36)
        backgroundView.addSubview(emojiOrImage)
        let option = ["輸入符號","選擇圖片"]
        for i in 0...1 {
            emojiOrImage.insertSegment(withTitle: option[i], at: i, animated: true)
        }
        emojiOrImage.selectedSegmentIndex = 0
        emojiOrImage.addAction(UIAction{ [self] action in
            
            switch emojiOrImage.selectedSegmentIndex {
            case 0:
                imagePickerButton.isHidden = true
                copyButton.setTitle("複製！", for: .normal)
                copyButton.isEnabled = true
                updateBunny()
            default:
                imagePickerButton.isHidden = false
                copyButton.setTitle("無法複製", for: .normal)
                copyButton.isEnabled = false
                updateBunny()
                
            }
            
        }, for: .valueChanged)
        
        
//符號輸入 text field
        let emojiInput = UITextField(frame: CGRect(x: 100, y:529, width: 260, height: 40))
        backgroundView.addSubview(emojiInput)
        emojiInput.borderStyle = .roundedRect
        emojiInput.placeholder = "輸入 emoji"
        emojiInput.addAction(UIAction{ [self] action in
            if emojiInput.attributedText != NSAttributedString("") {
                bunnySymbol.emojiContent = AttributedString(emojiInput.attributedText!)
            } else {
                bunnySymbol.emojiContent = "❤️"
            }
            updateBunny()
            
        }, for: .editingChanged)
        
        
//切換表情 segmentedControl
        let facialSegment = UISegmentedControl(frame: CGRect(x: 100, y: 585, width: 260, height: 40))
        backgroundView.addSubview(facialSegment)
        for i in 0...3 {
            facialSegment.insertSegment(withTitle: facialExpressionArray[i].name, at: i, animated: true)
        }
        
        facialSegment.selectedSegmentIndex = 0
        facialSegment.addAction(
            UIAction { [self] action in
                let index = facialSegment.selectedSegmentIndex
                
                let emotionString = facialExpressionArray[index].icon
                faceString = "( " + emotionString + ")\n"
                
                updateBunny()
            }, for: .valueChanged
        )
        
  
//切換動作 segmentedControl
        let actionSegment = UISegmentedControl(frame: CGRect(x: 100, y: 641, width: 260, height: 40))
        backgroundView.addSubview(actionSegment)
        for i in 0...3 {
            actionSegment.insertSegment(withTitle: actionArray[i].name, at: i, animated: true)
        }
        actionSegment.selectedSegmentIndex = 0
        actionSegment.addAction(UIAction(handler: {[self] action in
            bodyActionIndex = actionSegment.selectedSegmentIndex
            updateBunny()
            
        }), for: .valueChanged)
        

//調整大小 slider
        sizeSlider.frame = CGRect(x: 100, y: 700, width: 225, height: 40)
        backgroundView.addSubview(sizeSlider)
        sizeSlider.minimumValue = 36
        sizeSlider.maximumValue = 60
        sizeSlider.value = 48
        sizeSlider.minimumTrackTintColor = .darkGray
        sizeSlider.addAction(UIAction{ [self] action in
            emojiSize = Double(sizeSlider.value)
            imageSize = Double(sizeSlider.value)
            updateBunny()
        }, for: .valueChanged)
        
        
        let sizeResetButton = UIButton(type: .system)
        backgroundView.addSubview(sizeResetButton)
        sizeResetButton.frame = CGRect(x: 320, y: 699, width: 50, height: 40)
        sizeResetButton.setImage(UIImage(systemName: "arrow.uturn.left.circle"), for: .normal)
        sizeResetButton.tintColor = .darkGray
        sizeResetButton.addAction(UIAction{ [self]action in
            emojiSize = 48
            imageSize = 48
            updateBunny()
            sizeSlider.setValue(Float(emojiSize), animated: true)
        }, for: .touchUpInside)
        
        
        
        
//調整高低 stepper
        let locationStepper = UIStepper(frame: CGRect(x: 100, y: 762, width: 80, height: 40))
        backgroundView.addSubview(locationStepper)
        locationStepper.minimumValue = -20
        locationStepper.maximumValue = 20
        locationStepper.stepValue = 2
        locationStepper.value = 0
        locationStepper.setIncrementImage(UIImage(systemName: "chevron.up"), for: .normal)
        locationStepper.setDecrementImage(UIImage(systemName: "chevron.down"), for: .normal)
        locationStepper.tintColor = .black
        locationStepper.addAction(UIAction{ [self]action in
            emojiLocation = locationStepper.value
            imageLocation = locationStepper.value - 8
            updateBunny()
        }, for: .valueChanged)
        
        
        let locationResetButton = UIButton(type: .system)
        backgroundView.addSubview(locationResetButton)
        locationResetButton.frame = CGRect(x: 190, y: 756, width: 50, height: 40)
        locationResetButton.setImage(UIImage(systemName: "arrow.uturn.left.circle"), for: .normal)
        locationResetButton.tintColor = .darkGray
        locationResetButton.addAction(UIAction{ [self]action in
            locationStepper.value = 0
            emojiLocation = 0
            imageLocation = -8
            updateBunny()
        }, for: .touchUpInside)
        
        
        
        
//明暗切換 switch
        let darkToggle = UISwitch(frame: CGRect(x: 308, y: 762, width: 80, height: 40))
        backgroundView.addSubview(darkToggle)
        darkToggle.addAction(UIAction{ [self]action in
            if darkToggle.isOn {
                bunnyLabel.textColor = .white
                bunnyLabel.backgroundColor = .black
            } else {
                bunnyLabel.textColor = .black
                bunnyLabel.backgroundColor = .white
            }
        }, for: .valueChanged)
        
        
//圖片選擇 pickerView
        let imagePickerView = UIPickerView(frame: CGRect(x: 0, y: 577, width: 390, height: 267))
        backgroundView.addSubview(imagePickerView)
        imagePickerView.delegate = self
        imagePickerView.dataSource = self
        imagePickerView.backgroundColor = .systemGray4
        imagePickerView.alpha = 1
        imagePickerView.isHidden = true
        
//pickerView 隱藏按鈕
        backgroundView.addSubview(hideButton)
        hideButton.isHidden = true
        hideButton.frame = CGRect(x: 310, y: 587, width: 60, height: 40)
        hideButton.setTitle("Hide", for: .normal)
        hideButton.addAction(UIAction{ [self] action in
            imagePickerView.isHidden = true
            hideButton.isHidden = true
        }, for: .touchUpInside)
        
//呼叫 pickerView 按鈕
        backgroundView.addSubview(imagePickerButton)
        imagePickerButton.frame = CGRect(x: 100, y: 529, width: 260, height: 40)
        imagePickerButton.setTitle("選擇圖片", for: .normal)
        imagePickerButton.tintColor = .darkGray
        imagePickerButton.backgroundColor = .white
        imagePickerButton.layer.cornerRadius = 8
        imagePickerButton.clipsToBounds = true
        imagePickerButton.isHidden = true
        imagePickerButton.addAction(UIAction{ [self]action in
            imagePickerView.isHidden = false
            hideButton.isHidden = false
        }, for: .touchUpInside)

    }
    
    
    
    fileprivate func updateBunny() {
        
        bunnyLabel.text = ""
        
        switch emojiOrImage.selectedSegmentIndex {
         case 1:
            bunnyImage.face = NSMutableAttributedString(string: faceString)
            bunnyImage.actionleft = NSMutableAttributedString(string: actionArray[bodyActionIndex].leftIcon)
            bunnyImage.actionRight = NSMutableAttributedString(string: actionArray[bodyActionIndex].rightIcon)
            
            bunnyImage.imageContent.bounds = CGRect(x: 0, y: imageLocation, width: imageSize, height: imageSize)
            bunnyLabel.attributedText = NSAttributedString(attributedString: bunnyImage.makeBunny())
        default:
            bunnySymbol.face = AttributedString(faceString)
            bunnySymbol.actionleft = AttributedString(actionArray[bodyActionIndex].leftIcon)
            bunnySymbol.actionRight = AttributedString(actionArray[bodyActionIndex].rightIcon)
            
            bunnySymbol.emojiContent.font = UIFont.systemFont(ofSize: emojiSize)
            bunnySymbol.emojiContent.baselineOffset = emojiLocation
            
            bunnyLabel.attributedText = NSAttributedString(bunnySymbol.makeBunny())
        }
    }
    
}
