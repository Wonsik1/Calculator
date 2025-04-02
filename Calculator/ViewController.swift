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

        let buttonTitles: [[String]] = [ // 계산기 버튼이 될 숫자와 기호들을 이중 배열로 담음
            ["7", "8", "9", "+"],
            ["4", "5", "6", "-"],
            ["1", "2", "3", "*"],
            ["AC", "0", "=", "/"]
        ]

        var horizontalStacks: [UIStackView] = [] // 일단 가로 스택뷰를 담을 배열 생성
        
            for row in buttonTitles {
                var buttons: [UIButton] = []

                for title in row {
                    let isOperator = ["+", "-", "*", "/", "=", "AC"].contains(title)
                    let button = makeButton(
                        titleValue: title,
                        backgroundColor: isOperator ? .orange : UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
                    )
                    buttons.append(button)
                }

                let horizontalStack = makeHorizontalStackView(buttons)
                horizontalStacks.append(horizontalStack)
            }

        let verticalStack = makeVerticalStackView(horizontalStacks) // 만들어진 가로뷰스택들을 세로뷰스택으로 세로로 쌓는다
        view.addSubview(verticalStack)

        verticalStack.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(350)
        }
    }

    func makeHorizontalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }

    func makeVerticalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .black
        return stackView
    }
    
    func makeButton(titleValue: String, action: Selector? = nil, backgroundColor: UIColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)) -> UIButton {
        let button = UIButton()
        button.setTitle(titleValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 40

        button.snp.makeConstraints {
            $0.width.equalTo(button.snp.height)
        }

        return button
    }
}
