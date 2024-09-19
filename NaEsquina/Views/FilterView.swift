//
//  FilterView.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 18/09/24.
//

import UIKit

class FilterView: UIView {

    // MARK: UI Components

    // TODO: REVIEW LAYOUT AND ITENS OF SHEET FILTERS AND SWITCH TO UIVIEWCONTROLLER
    private lazy var viewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .semibold)
        label.textColor = .black
        label.text = "This is a sheet view"
        label.textAlignment = .center
        return label
    }()
        
    // MARK: Initializers
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterView: SetupView {
    func setup() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(viewLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            viewLabel.leadingAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutXAxisAnchor>#>, constant: <#T##CGFloat#>)
        ])
    }
}
