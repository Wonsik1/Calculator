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
    var currentInput: String = "0" // 현재 입력값을 저장할 변수 선언

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {
        label.text = "0"
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

        var horizontalStacks: [UIStackView] = [] // 가로 스택뷰를 담을 배열 생성
        
            for row in buttonTitles { // 이중 배열의 각 행을 순회
                var buttons: [UIButton] = [] // 개별적인 버튼을 담을 배열 생성

                for title in row { // 각 행의 요소를 순회하며 버튼을 생성
                    let isOperator = ["+", "-", "*", "/", "=", "AC"].contains(title) // 연산자 확인용 변수
                    let button = makeButton( // 버튼을 만들면서 연산자면 색을 변경한다
                        titleValue: title,
                        backgroundColor: isOperator ? .orange : UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
                    )
                    
                    button.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside) // 버튼 클릭 이벤트를 연결
                    
                    buttons.append(button) // 생성된 버튼을 배열에 저장
                }

                let horizontalStack = makeHorizontalStackView(buttons) // 버튼들을 가로 스택뷰로 구성
                horizontalStacks.append(horizontalStack) // 생성한 가로 스택뷰를 배열에 추가
            }

        let verticalStack = makeVerticalStackView(horizontalStacks) // 생성된 가로 스택뷰들을 세로 방향으로 정렬
        
        view.addSubview(verticalStack)
        verticalStack.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(350)
        }
    }
    
    @objc func buttonTap(_ sender: UIButton) { // 버튼 클릭 시 실행될 함수
        guard let title = sender.currentTitle else { return } // 버튼에 적혀있는 게 없으면 실행 불가
        
        switch title {
        case "AC":
            currentInput = "0" // AC 일땐 0으로 초기화
        case "=":
            if let result = calculate(expression: currentInput) { // 계산 성공 시 결과를 currentInput에 저장
                currentInput = "\(result)"
            } else {
                currentInput = "Error" // 계산 결과가 nil일시 에러 문구로 대체
            }
        default:
            if currentInput == "0", Int(title) != nil { // 현재값이 0이고 입력이 숫자일 경우
                currentInput = title // 해당 숫자로 교체
            } else {
                currentInput += title // 그 외의 경우 기존 입력에 새로운 값 이어붙이기
            }
        }
        
        label.text = currentInput // 현재 값을 라벨에 갱신
    }
    
    func calculate(expression: String) -> Int? { // 계산해주는 함수
           let expression = NSExpression(format: expression)
           if let result = expression.expressionValue(with: nil, context: nil) as? Int {
               return result
           } else {
               return nil
           }
       }

    func makeHorizontalStackView(_ views: [UIView]) -> UIStackView { // 가로 스택뷰를 만드는 함수
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }

    func makeVerticalStackView(_ views: [UIView]) -> UIStackView {// 세로 스택뷰를 만드는 함수
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .black
        return stackView
    }
    
    func makeButton(titleValue: String, action: Selector? = nil, backgroundColor: UIColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)) -> UIButton { // 버튼을 만드는 함수
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
