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
        
        let mainStackView = UIStackView()
        mainStackView.axis = NSLayoutConstraint.Axis.vertical
        mainStackView.distribution = distri
        mainStackView.alignment = align
        self.contentView.addSubview(mainStackView)
        
        let stackView = getSubStackView(distribution: distri, alignment: align, index: 0, expanded: true)
        let stackView2 = getSubStackView(distribution: distri, alignment: align, index: 1, expanded: false)
        let stackView3 = getSubStackView(distribution: distri, alignment: align, index: 2, expanded: false)
        let stackView4 = getSubStackView(distribution: distri, alignment: align, index: 3, expanded: false)
        
        mainStackView.addArrangedSubview(stackView)
        mainStackView.addArrangedSubview(stackView2)
        mainStackView.addArrangedSubview(stackView3)
        mainStackView.addArrangedSubview(stackView4)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        stackView3.isHidden = true
        stackView4.isHidden = true
    }
    
    func getSubStackView(distribution: UIStackView.Distribution, alignment: UIStackView.Alignment, index: Int, expanded: Bool) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = distribution
        stackView.alignment = alignment

        let views = getStandardViews(superView: stackView, buttonTag: index)
        stackView.addArrangedSubview(views.0)
        stackView.addArrangedSubview(views.1)
        stackView.addArrangedSubview(views.2)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        if expanded {
            self.expanded.append(true)
        } else {
            self.expanded.append(false)
            for view in stackView.arrangedSubviews {
                if !(view is UIButton) {
                    view.isHidden = true
                }
            }
        }
        
        stacks.append(stackView)
        
        return stackView
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
            
            for i in (sender.tag+1)..<stacks.count {
                if i == sender.tag + 1 {
                    stacks[i].isHidden = false
                } else {
                    stacks[i].isHidden = true
                }
            }
        }
    }
}
