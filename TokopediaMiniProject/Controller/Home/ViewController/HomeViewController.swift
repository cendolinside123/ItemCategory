//
//  HomeViewController.swift
//  TokopediaMiniProject
//
//  Created by Mac on 14/01/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let firstStage = UIButton()
    private let secondStage = UIButton()
    private let thirdStage = UIButton()
    private let fourthStage = UIButton()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setLayout()
        setConstraints()
        setupButton()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func setLayout() {
        setLabelTitle()
        setFirstStageButton()
        setSecondStageButton()
        setThirdStageButton()
        setFourthStageButton()
        setStackView()
    }
    
    private  func setConstraints() {
        let views: [String: Any] = ["titleLabel": titleLabel, "firstStage": firstStage, "secondStage": secondStage, "thirdStage": thirdStage, "fourthStage": fourthStage, "contentStackView": contentStackView]
        let matrix: [String: Any] = [:]
        
        var constraints = [NSLayoutConstraint]()
        
        //MARK: titleLabel and contentStackView constraint
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        let vTitleLabelAndStackView = "V:|-40-[titleLabel]-15-[contentStackView]"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vTitleLabelAndStackView, options: .alignAllLeading, metrics: matrix, views: views)
        constraints += [NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 2/3, constant: 0)]
        constraints += [NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: contentStackView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 3/7, constant: 0)]
        constraints += [NSLayoutConstraint(item: contentStackView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)]
        
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func setLabelTitle() {
        titleLabel.text = "Please Choose the stage do you wanna see"
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        view.addSubview(titleLabel)
    }
    
    private func setFirstStageButton() {
        firstStage.setTitle("Stage 1", for: .normal)
        firstStage.setTitleColor(.black, for: .normal)
        firstStage.backgroundColor = .red
        firstStage.layer.cornerRadius = 5
        firstStage.clipsToBounds = true
        firstStage.layer.borderColor = UIColor.black.cgColor
        firstStage.layer.borderWidth = 1
        view.addSubview(firstStage)
    }
    
    private func setSecondStageButton() {
        secondStage.setTitle("Stage 2", for: .normal)
        secondStage.setTitleColor(.black, for: .normal)
        secondStage.backgroundColor = .yellow
        secondStage.layer.cornerRadius = 5
        secondStage.clipsToBounds = true
        secondStage.layer.borderColor = UIColor.black.cgColor
        secondStage.layer.borderWidth = 1
        view.addSubview(secondStage)
    }
    
    private func setThirdStageButton() {
        thirdStage.setTitle("Stage 3", for: .normal)
        thirdStage.setTitleColor(.black, for: .normal)
        thirdStage.backgroundColor = .green
        thirdStage.layer.cornerRadius = 5
        thirdStage.clipsToBounds = true
        thirdStage.layer.borderColor = UIColor.black.cgColor
        thirdStage.layer.borderWidth = 1
        view.addSubview(thirdStage)
    }
    
    private func setFourthStageButton() {
        fourthStage.setTitle("Stage 4", for: .normal)
        fourthStage.setTitleColor(.black, for: .normal)
        fourthStage.backgroundColor = .blue
        fourthStage.layer.cornerRadius = 5
        fourthStage.clipsToBounds = true
        fourthStage.layer.borderColor = UIColor.black.cgColor
        fourthStage.layer.borderWidth = 1
        view.addSubview(fourthStage)
    }

    private func setStackView() {
        contentStackView.addArrangedSubview(firstStage)
        contentStackView.addArrangedSubview(secondStage)
        contentStackView.addArrangedSubview(thirdStage)
        contentStackView.addArrangedSubview(fourthStage)
        view.addSubview(contentStackView)
    }
    
}
extension HomeViewController {
    @objc private func toStageTwo() {
        let vc = StageTwoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func toStageOne() {
        let vc = StageOneViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupButton() {
        secondStage.addTarget(self, action: #selector(toStageTwo), for: .touchDown)
        firstStage.addTarget(self, action: #selector(toStageOne), for: .touchDown)
    }
    
}
