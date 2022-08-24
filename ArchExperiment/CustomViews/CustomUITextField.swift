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
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isLayout: Bool = false
    override func layoutSubviews() {
        super.layoutSubviews()
        print("Layout subviews")
        if isLayout {
            invalidateIntrinsicContentSize()
            isLayout = true
        }
        
    }
    
    private func configureView() {
        self.addSubview(mainStackView)
        
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
    
    var preferredHeight: CGFloat = 0.0
    
    override var intrinsicContentSize: CGSize {
        get {
            print("Calculate intrinsic content size")
            return CGSize(width: UIView.noIntrinsicMetric, height: preferredHeight)
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
        
        print("Show error")
        let fitSize = CGSize(width: mainStackView.frame.width, height: .zero)
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
        setNeedsLayout()
        layoutIfNeeded()
        self.preferredHeight = systemLayoutSizeFitting(fitSize).height
    }
    
    deinit {
        print("TextField deinit")
    }
    
}


struct CustomUITextField_PreviewProvider: PreviewProvider {
    
    static var previews: some View {
        
        VStack {
            TVLViewSwiftUI { _ in
                let tf = CustomUITextField()
                tf.placeholder = "This is a placeholder"
                tf.errorText = "This is error text. WIth a long text hahahahahhahhhahahhaha djsapidj sdija psdijas pdijas pidjaspdijpasid paidpaids"
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
