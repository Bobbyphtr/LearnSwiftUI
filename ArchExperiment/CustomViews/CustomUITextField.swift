//
//  CustomUITextField.swift
//  LearnSwiftUI
//
//  Created by Bobby Pehtrus on 08/08/22.
//

import Combine
import Foundation
import UIKit
import SwiftUI

class CustomUITextField: UIView {
    
    // Public
    var errorText: String? {
        didSet {
            isShowError(errorText != nil)
        }
    }
    
    var placeholder: String? {
        didSet {
            textfield.placeholder = placeholder
        }
    }
    
    lazy var textfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var textfieldContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(white: 0.95, alpha: 1.0)
        view.layer.cornerRadius = 8.0
        view.isUserInteractionEnabled = true
        view.addSubview(textfield)
        return view
    }()
    
    private lazy var errorLabelContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        view.addSubview(errorTextLabel)
        return view
    }()
    
    private lazy var errorTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 12.0)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textfieldContainer])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4.0
        stackView.sizeToFit()
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        printLog("Init")
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Update width the same as parent
        widthConstraint?.constant = superview?.frame.size.width ?? 0.0
        invalidateIntrinsicContentSize()
    }
    
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    private func configureView() {
        self.addSubview(mainStackView)
        
        widthConstraint =  mainStackView.widthAnchor.constraint(equalToConstant: 0.0)
        widthConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textfield.topAnchor.constraint(equalTo: textfieldContainer.topAnchor),
            textfield.bottomAnchor.constraint(equalTo: textfieldContainer.bottomAnchor),
            textfield.trailingAnchor.constraint(equalTo: textfieldContainer.trailingAnchor, constant: -12.0),
            textfield.leadingAnchor.constraint(equalTo: textfieldContainer.leadingAnchor, constant: 12.0),
            textfield.heightAnchor.constraint(equalToConstant: 55.0)
        ])
        
        
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            return mainStackView.systemLayoutSizeFitting(frame.size, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        }
    }
    
    private func isShowError(_ isShow: Bool) {
        errorTextLabel.text = errorText
        errorTextLabel.isHidden = !isShow
        
        mainStackView.addArrangedSubview(errorLabelContainer)
        
        NSLayoutConstraint.activate([
            errorLabelContainer.topAnchor.constraint(equalTo: errorTextLabel.topAnchor),
            errorLabelContainer.bottomAnchor.constraint(equalTo: errorTextLabel.bottomAnchor),
            errorLabelContainer.leadingAnchor.constraint(equalTo: errorTextLabel.leadingAnchor),
            errorLabelContainer.trailingAnchor.constraint(equalTo: errorTextLabel.trailingAnchor),
        ])
        errorTextLabel.sizeToFit()
    }
    
    deinit {
        printLog("Deinit")
    }
    
}


struct CustomUITextField_PreviewProvider: PreviewProvider {
    
    static var previews: some View {
        
        VStack {
            TVLViewSwiftUI { _ in
                let tf = CustomUITextField()
                tf.placeholder = "This is a placeholder"
                tf.errorText = "This is error text."
                tf.translatesAutoresizingMaskIntoConstraints = false
                return tf
            }
            .border(Color.red)
            .frame(width: .infinity)
            .border(Color.blue)
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            
            TVLViewSwiftUI { _ in
                let tf = CustomUITextField()
                tf.placeholder = "This is a placeholder"
                tf.errorText = "This is error text. This is a super long and long and long erro text. Should be go to the second line."
                tf.translatesAutoresizingMaskIntoConstraints = false
                return tf
            }
            .border(Color.red)
            .frame(width: .infinity)
            .border(Color.blue)
            .fixedSize(horizontal: false, vertical: true)
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
    
}
