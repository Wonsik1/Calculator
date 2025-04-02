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
        

        for row in buttonTitles { // 이중 for문으로 이중 배열의 배열 한줄씩 돌면서 row에 넣는다
            var buttons: [UIButton] = [] // 개별적인 버튼을 담을 배열 생성

            for title in row { // 계산기 버튼들의 한 줄씩 돌면서 title에 넣는다
                let button = UIButton()
                button.setTitle(title, for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.titleLabel?.font = .boldSystemFont(ofSize: 30)
                button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
                button.layer.cornerRadius = 40
                buttons.append(button) // 생성된 버튼을 빈 버튼배열에 넣는다
                button.snp.makeConstraints {
                    $0.width.equalTo(button.snp.height) // 버튼 너비와 높이를 같게 해서 모양을 원형으로 만든다
                }
            }

            let horizontalStack = makeHorizontalStackView(buttons) //배열에 개별버튼이 쭉 담기면 그걸 가로뷰스택으로 만든다
            horizontalStacks.append(horizontalStack) // 만든 가로뷰스택을 배열에 쭉 담아놓는다
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
}
