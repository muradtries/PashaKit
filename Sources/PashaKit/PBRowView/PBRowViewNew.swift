//
//  PBRowViewNew.swift
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

public class PBRowViewNew: PBBaseRowView {

    public var leftIcon: UIImage? {
        didSet {
            self.leftIconView.image = self.leftIcon
            self.setupViews()
        }
    }

    public var rightIcon: UIImage? {
        didSet {
            self.rightIconView.image = self.rightIcon
            self.setupViews()
        }
    }

    public var leftViewSize: CGSize = CGSize(width: 40.0, height: 40.0) {
        didSet {
            self.setupLeftIconViewSize()
        }
    }

    public var rightViewSize: CGSize = CGSize(width: 24.0, height: 24.0) {
        didSet {
            self.setupRightIconViewSize()
        }
    }

    private var leftViewConstraints: [NSLayoutConstraint] = []
    private var rightViewConstraints: [NSLayoutConstraint] = []

    private lazy var leftIconView: UIImageView = {
        let view = UIImageView()

        view.translatesAutoresizingMaskIntoConstraints = false

        view.contentMode = .scaleAspectFit

        return view
    }()

    private lazy var rightIconView: UIImageView = {
        let view = UIImageView()

        view.translatesAutoresizingMaskIntoConstraints = false

        view.contentMode = .scaleAspectFit

        view.widthAnchor.constraint(equalToConstant: 12.0).isActive = true
        view.heightAnchor.constraint(equalToConstant: 12.0).isActive = true

        return view
    }()

    public override func setupViews() {
        self.rightView.backgroundColor = .clear

        if self.leftIconView.image == nil {
            self.leftIconView.removeFromSuperview()
        } else {
            self.leftView.addSubview(self.leftIconView)
        }

        if self.rightIconView.image == nil {
            self.rightIconView.removeFromSuperview()
        } else {
            self.rightView.addSubview(self.rightIconView)
        }

        super.setupViews()
    }

    public override func setupConstraints() {
        self.setupLeftIconViewSize()
        self.leftIconView.fillSuperview()
        self.rightIconView.fillSuperview()

        super.setupConstraints()
    }

    private func setupLeftIconViewSize() {
        NSLayoutConstraint.deactivate(self.leftViewConstraints)

        self.leftViewConstraints = [
            self.leftIconView.widthAnchor.constraint(equalToConstant: self.leftViewSize.width),
            self.leftIconView.heightAnchor.constraint(equalToConstant: self.leftViewSize.height)
        ]

        NSLayoutConstraint.activate(self.leftViewConstraints)
    }

    private func setupRightIconViewSize() {
        NSLayoutConstraint.deactivate(self.rightViewConstraints)

        self.leftViewConstraints = [
            self.rightIconView.widthAnchor.constraint(equalToConstant: self.rightViewSize.width),
            self.rightIconView.heightAnchor.constraint(equalToConstant: self.rightViewSize.height)
        ]

        NSLayoutConstraint.activate(self.rightViewConstraints)
    }
}
