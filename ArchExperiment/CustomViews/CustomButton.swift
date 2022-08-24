//
//  CustomButton.swift
//  ArchExperiment
//
//  Created by Bobby Pehtrus on 21/08/22.
//

import Foundation
import UIKit
import SwiftUI

enum CustomButtonStyle {
    case primary
    case secondary
    
    var padding: UIEdgeInsets {
        switch self {
        case .primary, .secondary:
            return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .primary:
            return UIColor.systemBlue
        case .secondary:
            return UIColor.init(white: 0.95, alpha: 1)
        }
    }
    
    var highlightedColor: UIColor {
        foregroundColor.withAlphaComponent(0.5)
    }
    
    var foregroundColor: UIColor {
        switch self {
        case .primary:
            return UIColor.white
        case .secondary:
            return UIColor.systemBlue
        }
    }
}


class CustomButton: UIButton {
    
    var style: CustomButtonStyle {
        didSet {
            configureButton()
        }
    }
    
    init(style: CustomButtonStyle = .primary) {
        self.style = style
        super.init(frame: .zero)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton() {
        clipsToBounds = true
        
        layer.cornerRadius = 8.0
        
        backgroundColor = style.backgroundColor
        setTitleColor(style.foregroundColor, for: .normal)
        setTitleColor(style.highlightedColor, for: .highlighted)
        
        if #available(iOS 15, *)  {
            if var config: Configuration = self.configuration {
                config.contentInsets = NSDirectionalEdgeInsets(top: style.padding.top, leading: style.padding.left, bottom: style.padding.bottom, trailing: style.padding.right)
            }
            else {
                var config: UIButton.Configuration = .borderless()
                config.contentInsets = NSDirectionalEdgeInsets(top: style.padding.top, leading: style.padding.left, bottom: style.padding.bottom, trailing: style.padding.right)
                self.configuration = config
            }
        }
        else {
            contentEdgeInsets = style.padding
            titleEdgeInsets = .zero
            imageEdgeInsets = .zero
        }
        
    }
    
    deinit {
        printLog("Deinit")
    }
}

// MARK: SwiftUI

struct SCustomButton: UIViewRepresentable {
    typealias UIViewType = CustomButton
    typealias SCustomButtonAction = (() -> Void)
    
    let style : CustomButtonStyle
    let titleText: String
    
    var action: SCustomButtonAction? = nil
    
    init(title: String, style: CustomButtonStyle) {
        self.titleText = title
        self.style = style
    }
    
    init(title: String, action: @escaping SCustomButtonAction) {
        self.style = .primary
        self.titleText = title
        self.action = action
    }
    
    func makeUIView(context: Context) -> CustomButton {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleText, for: .normal)
        button.style = style
        // Set coordinator for actions
        context.coordinator.action = action
        button.addTarget(context.coordinator, action: #selector(context.coordinator.onButtonTapped), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: CustomButton, context: Context) {
        uiView.style = style
        uiView.setTitle(titleText, for: .normal)
        context.coordinator.action = action
    }
    
    func makeCoordinator() -> SCustomButtonCoordinator {
        SCustomButtonCoordinator()
    }
    
    // MARK: SCustomButtonCoordinator
    class SCustomButtonCoordinator {
        
        var action: SCustomButtonAction?
        
        @objc func onButtonTapped() {
            action?()
        }
    }
    
}

struct SCustomButton_PreviewProvider: PreviewProvider {
    static var previews: some View {
        SCustomButton(title: "Title", style: .primary)
            .previewLayout(.sizeThatFits)
            .padding()
            .fixedSize()
    }
}
