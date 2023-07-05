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
            
            imageContent.image = UIImage(named: imageItem)
            updateBunny()
        }
    }
    
    
    let imageList = ["愛心","珍珠奶茶","小籠包","芒果冰","鳳梨酥","台灣啤酒","臭豆腐","肉燥飯","夜市","茄芷袋","藍白拖","悠遊卡","大同電鍋","台北101","三合院","寺廟","新台幣","春聯","旗袍","腳底按摩","考卷","台灣地圖","注音","繁體中文"]
    var imageItem = ""
    let imagePickerButton = UIButton(type: .system)
    let hideButton = UIButton(type: .system)
    
    var earString = ""
    var faceString = ""
    var emojiString = ""
    
    var ear = AttributedString()
    let emotion = [" •_•","´▽`"," -_-","`Д´"]
    var face = AttributedString()
    var actionLeft = AttributedString()
    let actionLeftArray = ["/>","/>","/","/"]
    var actionRight = AttributedString()
    let actionRightArray = [">","","","<\\"]
    var bodyActionIndex = 0
    var body = AttributedString()
    
    var emojiContent = AttributedString()
    var emojiSize = 48.0
    var emojiLocation = 0.0
    
    var earMutable = NSMutableAttributedString()
    var faceMutable = NSMutableAttributedString()
    var actionLeftMutable = NSMutableAttributedString()
    var actionRightMutable = NSMutableAttributedString()
    var bodyMutable = NSMutableAttributedString()
    
    let imageContent = NSTextAttachment()
    var imageSize = 48.0
    var imageLocation = 0.0
    
    let bunnyLabel = UILabel()
    var bunnyText = AttributedString()
    var bunnyMutableText = NSMutableAttributedString()
    
    let sizeSlider = UISlider()
    let emojiOrImage = UISegmentedControl()
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
           view.endEditing(true)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 390, height: 844))
        backgroundView.backgroundColor = UIColor(red: 249/255, green: 237/255, blue: 229/255, alpha: 1)
        view.addSubview(backgroundView)
        
        
        bunnyLabel.frame = CGRect(x: 50, y: 69, width: 290, height: 290)
        backgroundView.addSubview(bunnyLabel)
        bunnyLabel.backgroundColor = UIColor.white
        bunnyLabel.layer.cornerRadius = 20
        bunnyLabel.clipsToBounds = true
        
        earString = "(\\_/)\n"  //兩個反斜線才會顯示為字元！
        faceString = "( \(emotion[0]))\n"
        emojiString = "❤️"
        
        
        //圖片
        
        earMutable = NSMutableAttributedString(string: earString)
        faceMutable = NSMutableAttributedString(string: faceString)
        actionLeftMutable = NSMutableAttributedString(string: actionLeftArray[bodyActionIndex])
        actionRightMutable = NSMutableAttributedString(string: actionRightArray[bodyActionIndex])
        
        imageSize = 48
        imageLocation = -8
        imageContent.image = UIImage(named: imageList[0])
        imageContent.bounds = CGRect(x: 0, y: imageLocation, width: imageSize, height: imageSize)
        updateBunny()
        
        
        //符號
        ear = AttributedString(earString)
        face = AttributedString(faceString)
        emojiContent = AttributedString(emojiString)
        
        updateBunny()
        bunnyLabel.numberOfLines = 0
        bunnyLabel.font = UIFont.systemFont(ofSize: 48)
        bunnyLabel.textAlignment = .center
        
        
        let copyButton = UIButton(type: .system)
        backgroundView.addSubview(copyButton)
        copyButton.frame = CGRect(x: 254, y: 334, width: 84, height: 24)
        copyButton.backgroundColor = .gray
        copyButton.tintColor = .white
        copyButton.layer.cornerRadius = 12
        copyButton.clipsToBounds = true
        copyButton.setTitle("複製！", for: .normal)
        
        copyButton.addAction(UIAction { [self]action in
            UIPasteboard.general.string = bunnyLabel.text
            copyButton.setTitle("已複製", for: .highlighted)
            
        }, for: .touchUpInside)
        
        
        //文字標題
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
        
        emojiOrImage.frame = CGRect(x: 60, y: 464, width: 270, height: 36)
        backgroundView.addSubview(emojiOrImage)
        let option = ["輸入符號","選擇圖片"]
        for i in 0...1 {
            emojiOrImage.insertSegment(withTitle: option[i], at: i, animated: true)
        }
        emojiOrImage.selectedSegmentIndex = 0
        emojiOrImage.addAction(UIAction{ [self] action in
            let emojiOrImage = action.sender as! UISegmentedControl
            
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
        
        
        let emojiInput = UITextField(frame: CGRect(x: 100, y:529, width: 260, height: 40))
        backgroundView.addSubview(emojiInput)
        emojiInput.borderStyle = .roundedRect
        emojiInput.placeholder = "輸入 emoji"
        emojiInput.addAction(UIAction{ [self] action in
            let emojiInput = action.sender as! UITextField
            if emojiInput.attributedText != NSAttributedString("") {
                emojiContent = AttributedString(emojiInput.attributedText!)
            } else {
                emojiContent = "❤️"
            }
            print(emojiContent)
            
            updateBunny()
            
        }, for: .editingChanged)
        
        
        
        let facialSegment = UISegmentedControl(frame: CGRect(x: 100, y: 585, width: 260, height: 40))
        backgroundView.addSubview(facialSegment)
        let facialExpressionArray = ["一般","開心","無語","生氣"]
        for i in 0...3 {
            facialSegment.insertSegment(withTitle: facialExpressionArray[i], at: i, animated: true)
        }
        
        facialSegment.selectedSegmentIndex = 0
        facialSegment.addAction(
            UIAction { [self] action in
                let facialSegment = action.sender as! UISegmentedControl
                let index = facialSegment.selectedSegmentIndex
                
                faceString = "( \(emotion[index]))\n"
                
                updateBunny()
            }, for: .valueChanged
        )
        
        
        let actionSegment = UISegmentedControl(frame: CGRect(x: 100, y: 641, width: 260, height: 40))
        backgroundView.addSubview(actionSegment)
        let actionArray = ["捧住","伸出","拿著","收回"]
        for i in 0...3 {
            actionSegment.insertSegment(withTitle: actionArray[i], at: i, animated: true)
        }
        actionSegment.selectedSegmentIndex = 0
        actionSegment.addAction(UIAction(handler: {[self] action in
            let actionSegment = action.sender as! UISegmentedControl
            bodyActionIndex = actionSegment.selectedSegmentIndex
            
            updateBunny()
            
        }), for: .valueChanged)
        
        
        sizeSlider.frame = CGRect(x: 100, y: 700, width: 225, height: 40)
        backgroundView.addSubview(sizeSlider)
        sizeSlider.minimumValue = 36
        sizeSlider.maximumValue = 60
        sizeSlider.value = 48
        sizeSlider.minimumTrackTintColor = .darkGray
        sizeSlider.addAction(UIAction{ [self] action in
            let sizeSlider = action.sender as! UISlider
            
            emojiSize = Double(sizeSlider.value)
            imageSize = Double(sizeSlider.value)
            
            updateBunny()
            
            
        }, for: .valueChanged)
        
        
        let sizeResetButton = UIButton(type: .system)
        sizeResetButton.frame = CGRect(x: 320, y: 699, width: 50, height: 40)
        sizeResetButton.setImage(UIImage(systemName: "arrow.uturn.left.circle"), for: .normal)
        sizeResetButton.tintColor = .darkGray
        
        
        sizeResetButton.addAction(UIAction{ [self]action in
            emojiSize = 48
            imageSize = 48
            updateBunny()
            sizeSlider.setValue(Float(emojiSize), animated: true)
            
        }, for: .touchUpInside)
        
        backgroundView.addSubview(sizeResetButton)
        
        
        
        let locationStepper = UIStepper(frame: CGRect(x: 100, y: 762, width: 80, height: 40))
        backgroundView.addSubview(locationStepper)
        locationStepper.minimumValue = -20
        locationStepper.maximumValue = 20
        locationStepper.value = 0
        locationStepper.stepValue = 2
        locationStepper.addAction(UIAction{ [self]action in
            let locationStepper = action.sender as! UIStepper
            emojiLocation = locationStepper.value
            imageLocation = locationStepper.value - 8
            
            updateBunny()
            
        }, for: .valueChanged)
        
        
        let locationResetButton = UIButton(type: .system)
        locationResetButton.frame = CGRect(x: 190, y: 756, width: 50, height: 40)
        locationResetButton.setImage(UIImage(systemName: "arrow.uturn.left.circle"), for: .normal)
        locationResetButton.tintColor = .darkGray
        
        
        locationResetButton.addAction(UIAction{ [self]action in
            
            locationStepper.value = 0
            emojiLocation = 0
            imageLocation = -8
            
            updateBunny()
            
        }, for: .touchUpInside)
        
        backgroundView.addSubview(locationResetButton)
        
        
        
        let darkToggle = UISwitch(frame: CGRect(x: 308, y: 762, width: 80, height: 40))
        backgroundView.addSubview(darkToggle)
        darkToggle.addAction(UIAction{ [self]action in
            let darkToggle = action.sender as! UISwitch
            if darkToggle.isOn {
                bunnyLabel.textColor = .white
                bunnyLabel.backgroundColor = .black
            } else {
                bunnyLabel.textColor = .black
                bunnyLabel.backgroundColor = .white
            }
        }, for: .valueChanged)
        
        
        
        let imagePickerView = UIPickerView(frame: CGRect(x: 0, y: 577, width: 390, height: 267))
        backgroundView.addSubview(imagePickerView)
        imagePickerView.isHidden = true
        imagePickerView.delegate = self
        imagePickerView.dataSource = self
        imagePickerView.backgroundColor = .systemGray4
        imagePickerView.alpha = 1
        
        
        backgroundView.addSubview(hideButton)
        hideButton.isHidden = true
        hideButton.frame = CGRect(x: 310, y: 587, width: 60, height: 40)
        hideButton.setTitle("Hide", for: .normal)
        hideButton.addAction(UIAction{ [self] action in
            imagePickerView.isHidden = true
            hideButton.isHidden = true
        }, for: .touchUpInside)
        
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
        
        switch emojiOrImage.selectedSegmentIndex {
        case 1:
            bunnyLabel.text = ""
            bunnyText = ""
            bunnyMutableText = NSMutableAttributedString(string: "")
            
            faceMutable = NSMutableAttributedString(string: faceString)
            actionLeftMutable = NSMutableAttributedString(string: actionLeftArray[bodyActionIndex])
            actionRightMutable = NSMutableAttributedString(string: actionRightArray[bodyActionIndex])
            
            imageContent.bounds = CGRect(x: 0, y: imageLocation, width: imageSize, height: imageSize)
            
            bunnyMutableText.append(earMutable)
            bunnyMutableText.append(faceMutable)
            bunnyMutableText.append(actionLeftMutable)
            bunnyMutableText.append(NSAttributedString(attachment: imageContent))
            bunnyMutableText.append(actionRightMutable)
            bunnyLabel.attributedText = bunnyMutableText
            
        default:
            bunnyLabel.text = ""
            bunnyText = ""
            body = ""
            
            face = AttributedString(faceString)
            actionLeft = AttributedString(actionLeftArray[bodyActionIndex])
            actionRight = AttributedString(actionRightArray[bodyActionIndex])
            
            emojiContent.font = UIFont.systemFont(ofSize: emojiSize)
            emojiContent.baselineOffset = emojiLocation
            
            body += actionLeft
            body += emojiContent
            body += actionRight
            
            bunnyText += ear
            bunnyText += face
            bunnyText += body
            bunnyLabel.attributedText = NSAttributedString(bunnyText)
            bunnyLabel.numberOfLines = 0
            bunnyLabel.textAlignment = .center
            
        }
    }
    
}
