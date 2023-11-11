//
//  ExampleTab2ViewController.swift
//  Presentation
//
//  Created by Lee Myeonghwan on 2023/11/10.
//  Copyright © 2023 gb. All rights reserved.
//

import UIKit
import SwiftUI

public class Tab2ViewController: UIViewController {
    let viewModel: Tab2ViewModel
    
    public init(viewModel: Tab2ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private func dataBinding() {
        viewModel.$adviceQuote
            .compactMap { $0.advice }
            .assign(to: \.text, on: label)
            .store(in: &viewModel.cancelBag)
        viewModel.loadingSubject
            .sink { _ in
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            .store(in: &viewModel.cancelBag)
    }
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Empty"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 3
        return label
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
         let activityIndicator = UIActivityIndicatorView(style: .large)
         activityIndicator.color = .gray
        activityIndicator.isHidden = true
        return activityIndicator
    }()
    
    public override func viewDidLoad() {
        view.backgroundColor = UIColor(Color.BG_Default)
        
        // 버튼 생성
        let button = UIButton(type: .system)
        button.setTitle("Change Quote", for: .normal)
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
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
        activityIndicator.isHidden = true
        dataBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
        // 버튼이 클릭되었을 때의 동작을 정의합니다.
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        viewModel.changeQuote()
    }
    
}
