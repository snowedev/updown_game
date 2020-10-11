//
//  ViewController.swift
//  UpDownGame
//
//  Created by 이원석 on 2020/10/08.
//

import UIKit

class ViewController: UIViewController {
    
    var randomValue: Int = 0
    var tryCount: Int = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tryCountLabel: UILabel!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var minimumValueLabel: UILabel!
    @IBOutlet weak var maximumValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        slider.setThumbImage(#imageLiteral(resourceName: "slider_thumb"), for: .normal) // slider의 이미지 변경
        //slider.setThumbImage(Image Literal, for: .normal)
        reset()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
        let integerValue: Int = Int(sender.value) // slider의 실수형 값을 정수형으로 표시
        sliderValueLabel.text = String(integerValue)
    } // slider 잡고 움직 일때 값 발생
    
    // 정답이 맞는지 아닌지 보여주기 위한 alert창
    func  showAlert(message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        // ok버튼
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.reset()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func touchUpHitButton(_ sender: UIButton) {
        print(slider.value)
        let hitValue: Int = Int(slider.value) // 표시는 정수형으로 하되,
        slider.value = Float(hitValue) // slider은 실수형이 기본이라 전달시에는 실수형으로 전달
        // 그래서 슬라이더를 5.8정도에 놓으면 5로 조정됨
        
        tryCount = tryCount + 1
        tryCountLabel.text = "\(tryCount) / 5"
        //== tryCountLabel.text = String(tryCount) + "/ 5"
        
        if randomValue == hitValue {
            //print("YOU HIT!!")
            showAlert(message: "YOU HIT!!")
            reset()
        } else if tryCount >= 5 {
            //print("YOU LOSE...")
            showAlert(message: "YOU LOSE...")
            reset()
        } else if randomValue > hitValue {
            slider.minimumValue = Float(hitValue)
            minimumValueLabel.text = String(hitValue)
        } else { // randomValue < hitValue
            slider.maximumValue = Float(hitValue)
            maximumValueLabel.text = String(hitValue)
        }
    } // HIT 버튼 클릭 시 slider 값 출력
    
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        print("touch up reset button")
        reset()
    }
    
    func reset() {
        print("reset!")
        randomValue = Int.random(in: 0...30) // 0부터30까지의 랜덤수 randomValue에 저장
        print(randomValue)
        tryCount = 0
        tryCountLabel.text = "0 / 5"
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.value = 15
        minimumValueLabel.text = "0"
        maximumValueLabel.text = "30"
        sliderValueLabel.text = "15"
    }
}

