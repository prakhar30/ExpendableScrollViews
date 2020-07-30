//
//  ViewController.swift
//  ExpandableTake2
//
//  Created by Prakhar Tripathi on 30/07/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    var stacks = [UIStackView]()
    var expanded = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let distri: UIStackView.Distribution = .fill
        let align: UIStackView.Alignment = .fill
        
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = distri
        stackView.alignment = align
        self.contentView.addSubview(stackView)

        let views = getStandardViews(superView: stackView, buttonTag: 0)
        stackView.addArrangedSubview(views.0)
        stackView.addArrangedSubview(views.1)
        stackView.addArrangedSubview(views.2)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stacks.append(stackView)
        expanded.append(true)
        
        let stackView2 = UIStackView()
        stackView2.axis = NSLayoutConstraint.Axis.vertical
        stackView2.distribution = distri
        stackView2.alignment = align
        self.contentView.addSubview(stackView2)

        let views2 = getStandardViews(superView: stackView2, buttonTag: 1)
        stackView2.addArrangedSubview(views2.0)
        stackView2.addArrangedSubview(views2.1)
        stackView2.addArrangedSubview(views2.2)
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        for view in stackView2.arrangedSubviews {
            if !(view is UIButton) {
                view.isHidden = true
            }
        }

        stacks.append(stackView2)
        expanded.append(false)
        
        let stackView3 = UIStackView()
        stackView3.axis = NSLayoutConstraint.Axis.vertical
        stackView3.distribution = distri
        stackView3.alignment = align
        self.contentView.addSubview(stackView3)

        let views3 = getStandardViews(superView: stackView3, buttonTag: 2)
        stackView3.addArrangedSubview(views3.0)
        stackView3.addArrangedSubview(views3.1)
        stackView3.addArrangedSubview(views3.2)
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        for view in stackView3.arrangedSubviews {
            if !(view is UIButton) {
                view.isHidden = true
            }
        }
        
        stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true

        stackView2.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        stackView2.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        stackView2.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true

        
        stackView3.topAnchor.constraint(equalTo: stackView2.bottomAnchor).isActive = true
        stackView3.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        stackView3.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        stackView3.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true

        stacks.append(stackView3)
        expanded.append(false)
    }
    
    func getStandardViews(superView: UIView, buttonTag: Int) -> (UIButton, UIView, UILabel) {
        let button = UIButton()
        if buttonTag == 0 {
            button.backgroundColor = .cyan
        } else if buttonTag == 1{
            button.backgroundColor = .green
        } else {
            button.backgroundColor = UIColor.red.withAlphaComponent(0.7)
        }
        button.tag = buttonTag
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Click me \(buttonTag)", for: .normal)
        button.addTarget(self, action:#selector(self.buttonClicked(_:)), for: .touchUpInside)
        
        let smallBox = UIView()
        smallBox.backgroundColor = UIColor.blue

        let textLabel = UILabel()
        textLabel.backgroundColor = UIColor.yellow
        textLabel.text  = "Hi World \(buttonTag)"
        textLabel.textAlignment = .center
        
        return (button, smallBox, textLabel)
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        if !expanded[sender.tag] {
            for (i, stack) in stacks.enumerated() {
                if i == sender.tag {
                    // expand this
                    for view in stack.arrangedSubviews {
                        if !(view is UIButton) {
                            view.isHidden = false
                        }
                    }
                    expanded[i] = true
                } else {
                    // collapse other
                    for view in stack.arrangedSubviews {
                        if !(view is UIButton) {
                            view.isHidden = true
                        }
                    }
                    expanded[i] = false
                }

            }
        }
    }
}
