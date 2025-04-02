//
//  ViewController.swift
//  Calculator
//
//  Created by 전원식 on 4/2/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let label = UILabel()
    let button7 = UIButton()
    let button8 = UIButton() //ddd
    let button9 = UIButton()
    let buttonPlus = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        label.text = "12345"
        label.textColor = .white
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 60)
        label.textAlignment = .right
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview().offset(200)
            $0.height.equalTo(100)
        }
        
        let buttons: [UIButton] = [button7, button8, button9, buttonPlus]
        let titles = ["7", "8", "9", "+"]
        
        for (index, button) in buttons.enumerated() {
            button.setTitle(titles[index], for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 30)
            button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            button.layer.cornerRadius = 40
        }
        
        
        let row1 = makeHorizontalStackView(buttons)
        
        view.addSubview(row1)
        row1.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(80)
        }
    }
    
    
    func makeHorizontalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .black
        return stackView //커밋 테스트..
    }
}

