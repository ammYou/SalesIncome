//
//  HomeViewController.swift
//  SalesIncome
//
//  Created by AmamiYou on 2018/10/29.
//  Copyright © 2018 ammYou. All rights reserved.
//

import UIKit
import SnapKit
import MaterialControls
import NCMB

class HomeViewController: UIViewController {
    private let salesProceedsLabel = UILabel()
    private let salesCount = UILabel()
    private let sellButton = MDButton()
    private let cancellButton = MDButton()
    private let customButton = MDButton()
    private let logTextView = UITextView()


    override func loadView() {
        super.loadView()
        allLayoutSetting()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        NCMBManager.saveData(className: "test", keyName: "test", dataValue: "test") { (error) in
//            print(error)
//        }
        // Do any additional setup after loading the view.
    }


    // MARK: - LayoutSetting
    private func allLayoutSetting() {
        //グラデーションの開始色
        //let topColor = UIColor(red: 0.07, green: 0.13, blue: 0.26, alpha: 1)
        //グラデーションの開始色
        //let bottomColor = UIColor(red: 0.54, green: 0.74, blue: 0.74, alpha: 1)
        let topColor = Constants.Color.AppleBlack
        let middleColor = Constants.Color.AppleBlackShadow
        let bottomColor = Constants.Color.AppleBlack
        let gradientColors: [CGColor] = [topColor.cgColor, middleColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)

        let barButtonItem = UIBarButtonItem()
        let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 24.0, height: 24.0))
        button.setBackgroundImage(R.image.settingMix(), for: .normal)
        button.addTarget(self, action: #selector(tappedSettingButton), for: .touchUpInside)
        barButtonItem.customView = button
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        barButtonItem.tintColor = UIColor.clear

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.barTintColor = Constants.Color.AppleBlack
        self.navigationController?.navigationBar.tintColor = nil
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationItem.rightBarButtonItem = barButtonItem
        self.setNavigationBarTitleString(title: "売上計算")

        self.view.addSubview(self.salesProceedsLabel)
        self.view.addSubview(self.salesCount)
        self.view.addSubview(self.sellButton)
        self.view.addSubview(self.cancellButton)
        self.view.addSubview(self.customButton)
        self.view.addSubview(self.logTextView)

        self.salesProceedsLabel.text = "売り上げ: -円"
        self.salesProceedsLabel.font = UIFont.systemFont(ofSize: 25)
        self.salesProceedsLabel.textColor = Constants.Color.AppleGray
//        self.salesProceedsLabel.backgroundColor = Constants.Color.PureWhiteShadow
        self.salesProceedsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }

        self.salesCount.text = "売り個数: -個"
        self.salesCount.font = UIFont.systemFont(ofSize: 25)
        self.salesCount.textColor = Constants.Color.AppleGray
//        self.salesCount.backgroundColor = Constants.Color.PureWhiteShadow
        self.salesCount.snp.makeConstraints { (make) in
            make.top.equalTo(self.salesProceedsLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }

        self.sellButton.mdButtonType = .raised
        self.sellButton.rippleColor = Constants.Color.AppleSkyShadow
        self.sellButton.backgroundColor = Constants.Color.AppleSky
        self.sellButton.layer.cornerRadius = 5
        self.sellButton.setTitle("販売", for: .normal)
        self.sellButton.setTitleColor(UIColor.white, for: .normal)
        self.sellButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.sellButton.addTarget(self, action: #selector(tappedSellButton), for: .touchUpInside)
        self.sellButton.addShadow(direction: .bottom)
        self.sellButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.salesCount.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(80)
        }

        self.cancellButton.mdButtonType = .raised
        self.cancellButton.rippleColor = Constants.Color.AppleSkyShadow
        self.cancellButton.backgroundColor = Constants.Color.AppleSky
        self.cancellButton.layer.cornerRadius = 5
        self.cancellButton.setTitle("破棄", for: .normal)
        self.cancellButton.setTitleColor(UIColor.white, for: .normal)
        self.cancellButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.cancellButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
        self.cancellButton.addShadow(direction: .bottom)
        self.cancellButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.sellButton.snp.bottom).offset(10)
            make.left.equalTo(self.sellButton)
            make.width.equalTo(self.sellButton).multipliedBy(0.5).offset(-5)
            make.height.equalTo(50)
        }

        self.customButton.mdButtonType = .raised
        self.customButton.rippleColor = Constants.Color.AppleSkyShadow
        self.customButton.backgroundColor = Constants.Color.AppleSky
        self.customButton.layer.cornerRadius = 5
        self.customButton.setTitle("カスタム", for: .normal)
        self.customButton.setTitleColor(UIColor.white, for: .normal)
        self.customButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.customButton.addTarget(self, action: #selector(tappedCustomButton), for: .touchUpInside)
        self.customButton.addShadow(direction: .bottom)
        self.customButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.sellButton.snp.bottom).offset(10)
            make.right.equalTo(self.sellButton)
            make.width.equalTo(self.sellButton).multipliedBy(0.5).offset(-5)
            make.height.equalTo(50)
        }

        self.logTextView.text = "売り, 金額: -円, 個数: -個, -円/個, 食券: -枚, ----/--/-- - --:--:--"
        self.logTextView.textColor = Constants.Color.PureWhiteShadow
        self.logTextView.backgroundColor = UIColor.black
        self.logTextView.layer.cornerRadius = 5
        self.logTextView.isSelectable = true
        self.logTextView.isScrollEnabled = true
        self.logTextView.isEditable = false
        self.logTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.customButton.snp.bottom).offset(20)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

// MARK: - Action

    @objc private func tappedSettingButton() {
    }

    @objc private func tappedSellButton() {
    }

    @objc private func tappedCancelButton() {
    }

    @objc private func tappedCustomButton() {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}