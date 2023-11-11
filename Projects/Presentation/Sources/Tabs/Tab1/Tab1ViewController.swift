//
//  Tab1ViewController.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/11/10.
//  Copyright © 2023 gb. All rights reserved.
//

import UIKit
import SwiftUI

public class Tab1ViewController: UIViewController {
    let viewModel: Tab1ViewModel
    
    public init(viewModel: Tab1ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = UIColor(Color.BG_Default)
        
        // 레이블 생성
        let label = UILabel()
        label.text = "Go to Next page"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        
        // 버튼 생성
        let button = UIButton(type: .system)
        button.setTitle("클릭하세요", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // 레이블 및 버튼을 스택 뷰에 추가
        let stackView = UIStackView(arrangedSubviews: [label, button])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        // 스택 뷰를 뷰 컨트롤러의 루트 뷰로 설정
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func buttonTapped() {
        // 버튼이 클릭되었을 때의 동작을 정의합니다.
        viewModel.moveToSubViewButtonClicked()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
