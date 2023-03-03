//
//  ViewController.swift
//  UIKit-Timer-App
//
//  Created by Burhan Dündar on 2.03.2023.
//

import UIKit

class ViewController: UIViewController {

    var remaining: Int = 10
    var timerText: UILabel!
    var startBtn: UIButton!
    var stopBtn: UIButton!
    var tourBtn: UIButton!
    var resetBtn: UIButton!
    var timer: Timer!
    
    var tourText: UILabel!
    
    var tours: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = UIView()
        view.backgroundColor = .white
        
        navigationItem.title = "Timer App"
        
        timerText = UILabel()
        timerText.translatesAutoresizingMaskIntoConstraints = false
        //timerText.text = String(timer)
        timerText.text = self.remaining < 10 ? "00:0\(self.remaining)" : "00:\(self.remaining)"
        timerText.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .largeTitle), size: 30)
        
        view.addSubview(timerText)
        
        NSLayoutConstraint.activate([
            timerText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerText.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20)
            //timerText.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        startBtn = UIButton()
        stopBtn = UIButton()
        tourBtn = UIButton()
        resetBtn = UIButton()
        
        startBtn.setTitle("Start", for: .normal)
        startBtn.setTitleColor(.systemGreen, for: .normal)
        startBtn.setTitleColor(.purple, for: .highlighted)
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        startBtn.addTarget(self, action: #selector(start), for: .touchUpInside)
        
        view.addSubview(startBtn)
        
        stopBtn.setTitle("Stop", for: .normal)
        stopBtn.setTitleColor(.systemBlue, for: .normal)
        stopBtn.setTitleColor(.purple, for: .highlighted)
        stopBtn.translatesAutoresizingMaskIntoConstraints = false
        stopBtn.addTarget(self, action: #selector(stop), for: .touchUpInside)
        stopBtn.isHidden = true // when start button is clicked, isHidden is going to be "true"
        
        view.addSubview(stopBtn)
        
        tourBtn.setTitle("Tour", for: .normal)
        tourBtn.setTitleColor(.systemOrange, for: .normal)
        tourBtn.setTitleColor(.purple, for: .highlighted)
        tourBtn.translatesAutoresizingMaskIntoConstraints = false
        tourBtn.addTarget(self, action: #selector(tour), for: .touchUpInside)
        
        view.addSubview(tourBtn)
        
        resetBtn.setTitle("Reset", for: .normal)
        resetBtn.setTitleColor(.systemRed, for: .normal)
        resetBtn.setTitleColor(.purple, for: .highlighted)
        resetBtn.translatesAutoresizingMaskIntoConstraints = false
        resetBtn.addTarget(self, action: #selector(reset), for: .touchUpInside)
        resetBtn.isHidden = true
        
        view.addSubview(resetBtn)
        
        NSLayoutConstraint.activate([
            startBtn.topAnchor.constraint(equalTo: timerText.bottomAnchor, constant: 20),
            startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopBtn.topAnchor.constraint(equalTo: timerText.bottomAnchor, constant: 20),
            stopBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tourBtn.topAnchor.constraint(equalTo: stopBtn.bottomAnchor, constant: 20),
            tourBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetBtn.topAnchor.constraint(equalTo: startBtn.bottomAnchor, constant: 20),
            resetBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        
        
        
        
    }
    
    @objc private func start(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        self.startBtn.isHidden = true
        self.stopBtn.isHidden = false
        self.tourBtn.isHidden = false
        self.resetBtn.isHidden = true
    }
    
    @objc private func stop(){
        self.timer.invalidate()
        
        self.startBtn.isHidden = false
        self.stopBtn.isHidden = true
        self.tourBtn.isHidden = true
        self.resetBtn.isHidden = false
    }
    
    @objc private func tour(){
        if (self.remaining != 10){self.tours.append(self.remaining)}
        if !tours.isEmpty {
            var counter = 10
            var tourCount = 1
            for _tour in tours {
                tourText = UILabel()
                tourText.translatesAutoresizingMaskIntoConstraints = false
                tourText.text = tourCount < 10 ? "Tour 0\(tourCount) \t -> \t \(_tour)" : "Tour \(tourCount) \t -> \t \(_tour)"
                tourText.textAlignment = .center
                
                view.addSubview(tourText)
                
                tourText.topAnchor.constraint(equalTo: resetBtn.bottomAnchor, constant: CGFloat(counter)).isActive = true
                tourText.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
                
                counter += 20
                tourCount += 1
            }
        }
    }
    
    @objc private func reset(){
        // FIXME If user clicks reset before timer start, The app crashes
        self.remaining = 10
        self.timer.invalidate()
        self.timerText.text = self.remaining < 10 ? "00:0\(self.remaining)" : "00:\(self.remaining)"
    }
    
    @objc private func countDown() {
        if self.remaining > 0 {
            self.remaining -= 1
        } else {
            // timer Should be reset after click alert Okay button
            self.reset()
            
            let alert = UIAlertController(title: "Stand Up 🏃‍♂️", message: "Time is done!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true)
            
            
        }
        self.timerText.text = self.remaining < 10 ? "00:0\(self.remaining)" : "00:\(self.remaining)"
    }


}

