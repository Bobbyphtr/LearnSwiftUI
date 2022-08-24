//
//  IntrinsicSizeView.swift
//  ArchExperiment
//
//  Created by Bobby Pehtrus on 21/08/22.
//

import UIKit

/// UIView to search for its child's intrinsic size.
///
/// Basically this view is only for containing its child. The view is tasked to adjust its size to its child as smallest possible then updates its ``intrinsicContentSize``. So SwiftUI can layout it without any need for ``SwiftUI.View.fixedSize()``
public final class IntrinsicSizeView<ContentView: UIView>: UIView {
    
    let contentView: ContentView
    
    /// init IntrinsicSizeView
    /// - Parameter contentView: any object that conforms UIView
    init(contentView: ContentView) {
        self.contentView = contentView
        super.init(frame: .zero)
        // This view is only for containing the childview and adjust its size to its child.
        self.backgroundColor = .green
        self.addSubview(contentView)
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        printLog("size: \(contentView.frame.size)")
    }
    
    private var contentSize: CGSize = .zero {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return contentSize
    }
    
    public func updateContentSize() {
        // Set content size to the smallest size possible. Then invalidates intrinsic content size.
        contentSize = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        printLog("Update content size \(frame.size)")
    }
    
}
