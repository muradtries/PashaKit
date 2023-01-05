//
//  PBBaseRowView.swift
//  
//
//  Created by Murad on 03.01.23.
//
//  
//  MIT License
//  
//  Copyright (c) 2022 Murad Abbasov
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy 
//  of this software and associated documentation files (the "Software"), to deal 
//  in the Software without restriction, including without limitation the rights 
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
//  copies of the Software, and to permit persons to whom the Software is 
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in 
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
//  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
//  THE SOFTWARE.

import UIKit

open class PBBaseRowView: UIView, PBSkeletonable {

    // -MARK: Public Properties

    /// The style for `leftIconWrapperView`.
    ///
    /// By default its value is `circle`.
    ///
    public var leftIconStyle: CornerStyle = .circle {
        didSet {
            self.setupViews()
        }
    }

    /// Sets the given string to `titleLabel` of row view.
    ///
    /// By default this property is set to `nil`. Depending on how you want to fill your row view it can be set directly
    /// via this property. Alternatively you can do it by adding when initializing it or using `setData` `setDataFor`
    /// methods.
    ///
    public var titleText: String? {
        didSet {
            self.titleLabel.text = self.titleText
        }
    }

    /// Sets the font for `titleLabel`.
    ///
    /// By default its font size is `17.0`.
    ///
    public var titleFont: UIFont? = UIFont.systemFont(ofSize: 17.0, weight: .regular) {
        didSet {
            self.titleLabel.font = self.titleFont
        }
    }

    /// Sets the color for text of `titleLabel`.
    ///
    /// By default text color of `titleLabel` is `darkText`
    ///
    public var titleTextColor: UIColor = .darkText{
        didSet {
            self.titleLabel.textColor = self.titleTextColor
        }
    }

    /// Sets the given string to `subtitleLabel` of row view.
    ///
    /// By default this property is set to `nil`. Depending on how you want to fill your row view it can be set directly
    /// via this property. Alternatively you can do it by adding when initializing it or using `setData` `setDataFor`
    /// methods.
    ///
    public var subtitleText: String? {
        didSet {
            self.subtitleLabel.text = self.subtitleText
        }
    }

    /// Sets the font for `subtitleLabel`.
    ///
    /// By default its font size is `13.0`.
    ///
    public var subtitleFont: UIFont? = UIFont.systemFont(ofSize: 13.0, weight: .regular) {
        didSet {
            self.subtitleLabel.font = self.subtitleFont
        }
    }

    /// Sets the color for text of `subtitleLabel`.
    ///
    /// By default text color of `subtitleLabel` is `UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)`
    ///
    public var subtitleTextColor: UIColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) {
        didSet {
            self.subtitleLabel.textColor = self.subtitleTextColor
        }
    }

    public var contentViewInsets: UIEdgeInsets = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0) {
        didSet {
            if self.contentViewInsets != oldValue {
                self.setupContentViewConstraints()
            }
        }
    }

    // -MARK: Private Properties

    private var contentViewConstraints: [NSLayoutConstraint] = []

    ///  The arranger for title and subtile labels.
    ///
    ///  When row view is created, `subtitleLabel` sits under `titleLabel`.
    ///  However there are some cases we needed to change their places.
    ///
    ///  Obviously, changing this property's value to `subtitleFirst`  will make `titleLabel`
    ///  to sit under `subtitleLabel`.
    ///
    public var textLayoutPreference: PreferredTextPlacement = .titleFirst {
        didSet {
            self.secondaryStackView.removeArrangedSubview(self.titleLabel)
            self.secondaryStackView.removeArrangedSubview(self.subtitleLabel)

            switch self.textLayoutPreference {
            case .titleFirst:
                self.secondaryStackView.addArrangedSubview(self.titleLabel)
                self.secondaryStackView.addArrangedSubview(self.subtitleLabel)
            case .subtitleFirst:
                self.secondaryStackView.addArrangedSubview(self.subtitleLabel)
                self.secondaryStackView.addArrangedSubview(self.titleLabel)
            }
        }
    }

    /// The visual state of divider.
    ///
    /// By default row view will be created with divider is hidden.
    ///
    /// If you need a divider change it to `true`. It will show a divider with the thickness of `0.5 pt`.
    ///
    public var showsDivider: Bool = false {
        didSet {
            self.divider.isHidden = !showsDivider
        }
    }

    /// Spacing between subviews of content view.
    ///
    /// By default the spacing is set to `12.0`. Depending on your design choice, change the value of this property.
    ///
    public var spacing: CGFloat = 12.0 {
        didSet {
            self.contentView.spacing = self.spacing
        }
    }

    // -MARK: UI Components

    public lazy var contentView: UIStackView = {
        let view = UIStackView()

        self.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        view.axis = .horizontal
        view.alignment = .center
        view.spacing = self.spacing

        return view
    }()

    public lazy var textualContentView: UIStackView = {
        let view = UIStackView()

        self.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 4.0

        return view
    }()

    private lazy var secondaryStackView: UIStackView = {
        let view = UIStackView()

        self.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        view.axis = .vertical
        view.alignment = .leading

        return view
    }()

    public lazy var leftView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        view.setContentHuggingPriority(.required, for: .vertical)
        view.setContentHuggingPriority(.required, for: .horizontal)

        return view
    }()

    public lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = self.titleFont
        label.textColor = self.titleTextColor
        label.numberOfLines = 1
        label.text = self.titleText
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.isSkeletonable = true

        return label
    }()

    public lazy var subtitleLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = self.subtitleFont
        label.textColor = self.subtitleTextColor
        label.numberOfLines = 1
        label.text = self.subtitleText
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.isSkeletonable = true

        return label
    }()

    public lazy var rightView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        view.setContentHuggingPriority(.required, for: .vertical)
        view.setContentHuggingPriority(.required, for: .horizontal)

        return view
    }()

    private lazy var divider: UIView = {
        let view = UIView()

        self.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = UIColor(red: 0.812, green: 0.812, blue: 0.812, alpha: 1)
        view.isHidden = !self.showsDivider
        view.isSkeletonable = true

        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

        return view
    }()


    // -MARK: Initializers

    required public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }

    required public init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        self.setupViews()
    }


    // -MARK: Setup Functions

    public func setupViews() {
        if self.leftView.subviews.count == 0 {
            self.leftView.removeFromSuperview()
        } else {
            self.contentView.addArrangedSubview(self.leftView)
        }

        self.contentView.addArrangedSubview(self.textualContentView)
        self.textualContentView.insertArrangedSubview(self.secondaryStackView, at: 0)
        self.setupTitleAndSubtitlePlacement()

        if self.rightView.subviews.count == 0 {
            self.rightView.removeFromSuperview()
        } else {
            self.contentView.addArrangedSubview(self.rightView)
        }

        self.setupConstraints()
    }

    public func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.setupContentViewConstraints()

        if self.titleLabel.superview != nil {
            NSLayoutConstraint.activate([
                self.titleLabel.leftAnchor.constraint(equalTo: self.secondaryStackView.leftAnchor),
                self.titleLabel.rightAnchor.constraint(equalTo: self.secondaryStackView.rightAnchor)
            ])
        } else {
            return
        }

        if self.subtitleLabel.superview != nil {
            NSLayoutConstraint.activate([
                self.subtitleLabel.leftAnchor.constraint(equalTo: self.secondaryStackView.leftAnchor),
                self.subtitleLabel.rightAnchor.constraint(equalTo: self.secondaryStackView.rightAnchor)
            ])
        } else {
            return
        }

        self.layoutIfNeeded()
    }

    private func setupContentViewConstraints() {
        NSLayoutConstraint.deactivate(self.contentViewConstraints)

        self.contentViewConstraints = [
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.contentViewInsets.top),
            self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.contentViewInsets.left),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.contentViewInsets.bottom),
            self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.contentViewInsets.right)
        ]

        NSLayoutConstraint.activate(self.contentViewConstraints)
    }

    open override func layoutSubviews() {
        switch self.leftIconStyle {
        case .roundedRect(cornerRadius: let cornerRadius):
            self.leftView.layer.cornerRadius = cornerRadius
        case .circle:
            self.leftView.layer.cornerRadius = self.leftView.bounds.width / 2
        }

        if subtitleLabel.text == nil {
            self.secondaryStackView.spacing = 0.0
        } else {
            self.secondaryStackView.spacing = 4.0
        }

        super.layoutSubviews()
    }

    private func setupTitleAndSubtitlePlacement() {
        switch self.textLayoutPreference {
        case .titleFirst:
            self.secondaryStackView.addArrangedSubview(self.titleLabel)
            self.secondaryStackView.addArrangedSubview(self.subtitleLabel)
        case .subtitleFirst:
            self.secondaryStackView.addArrangedSubview(self.subtitleLabel)
            self.secondaryStackView.addArrangedSubview(self.titleLabel)
        }
    }

    // -MARK: SkeletonView Methods

    public func showSkeletonAnimation() {
        self.titleLabel.showAnimatedGradientSkeleton()
        self.subtitleLabel.showAnimatedGradientSkeleton()
    }

    public func hideSkeletonAnimation() {
        self.titleLabel.hideSkeleton()
        self.subtitleLabel.hideSkeleton()
    }
}
