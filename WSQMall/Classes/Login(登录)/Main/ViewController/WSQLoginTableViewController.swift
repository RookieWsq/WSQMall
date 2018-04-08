//
//  WSQLoginTableViewController.swift
//  WSQMall
//
//  Created by 翁胜琼 on 2017/12/17.
//  Copyright © 2017年 John. All rights reserved.
//

import UIKit

let loginCellIdentifier = "WSQLoginCollectionViewCell";

class WSQLoginTableViewController: UITableViewController {
    
    var psdLoginTabBtn : UIButton!
    var codeLocginTabBtn : UIButton!
    var hud : MBProgressHUD!
    var foreGroundLine : UIView!
    // 包装视图
    var loginView : UICollectionView!
    // 密码登录页
    var psdLoginView : UIView!
    // 验证码登录页
    var codeLoginView : UIView!
    // 密码登录页账号 field
    var accountTextField : UITextField!
    var psdTextField : UITextField!
    // 登录按钮
    var psdLoginBtn : UIButton!
    // 发送验证码
    var verificationBtn : UIButton!
    var timer : DispatchSourceTimer!
    // 手机号码
    var phoneTextfield : UITextField!
    var codeTextField : UITextField!
    var remainingScends : Int = 60
    // 手机登录按钮
    var phoneLoginBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    // 账号密码登录
    @objc private func psdLoginBtnAction(sender:UIButton)
    {
        self.hud = MBProgressHUD.showAdded(to: (self.navigationController?.view)!, animated: true)
        self.view.endEditing(true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            [unowned self] in
            if self.accountTextField.text == "leiyu" && self.psdTextField.text == "123123"
            {
                self.hud.hide(animated: true)
                
                MallObjManager.saveUserData(true, forKey: "isLogin")
                MallObjManager.saveUserData(self.accountTextField.text, forKey: "userName") //记录用户名
                self.dismissVC()
                
                let tabbarVC = UIApplication.shared.delegate?.window??.rootViewController as! UITabBarController
                tabbarVC.selectedIndex = 3
            }else
            {
                self.hud.mode = .text
                self.hud.label.text = "账号或密码不匹配,重新输入"
                self.hud.hide(animated: true, afterDelay: 2)
            }
        }
    }
    // 手机验证码登录
    @objc private func phoneLoginBtnAction(_ sender : UIButton)
    {
        self.hud = MBProgressHUD.showAdded(to: (self.navigationController?.view)!, animated: true)
        self.view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            [unowned self] in
            if self.phoneTextfield.text == "15184704513" && self.psdTextField.text == "123123"
            {
                self.hud.hide(animated: true)
                self.dismissVC()
            }else
            {
                self.hud.mode = .text
                self.hud.label.text = "验证码输入错误"
                self.hud.hide(animated: true, afterDelay: 2)
            }
        }
    }
    
    // 标签按钮动作
    @objc private func codeLoginBtnAction(sender : UIButton)
    {
        if sender == self.codeLocginTabBtn && sender.isSelected == false
        {
            self.psdLoginTabBtn.isSelected = false;
            self.loginView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: true)
            
        }else if sender == self.psdLoginTabBtn && sender.isSelected == false
        {
            self.codeLocginTabBtn.isSelected = false
            self.loginView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
        }
        sender.isSelected = true
        UIView.animate(withDuration: 0.25) {
            self.foreGroundLine.center.x = sender.center.x
        }
    }
    
    @objc private func endEditing()
    {
        self.view.endEditing(true)
    }
    
    deinit {
        if (self.timer != nil)
        {        
            self.timer.cancel()
            self.timer = nil
        }
    }
    
}

// MARK: - setupUI
extension WSQLoginTableViewController
{
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    private func setupUI()
    {
        // 设置导航栏
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "address4_guanbi").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(dismissVC))
        self.navigationItem.title = "商城登录"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.cz_RGB(red: 99, green: 108, blue: 115)]
        self.navigationController?.navigationBar.barTintColor = UIColor.cz_RGB(red: 255, green: 255, blue: 255)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // 设置 tableView
        tableView.isScrollEnabled = false;
        tableView.tableFooterView = UIView()
        
        // 设置登录页面
        setupTabsView()
        
        // 创建密码登录页面
        setupPsdLoginView()
        setupCodeLoginView()
    }
    
    @objc func dismissVC()
    {
        self.navigationController?.dismiss(animated: true, completion: nil)
        
        let tabbarVC = UIApplication.shared.delegate?.window??.rootViewController as! UITabBarController
        if (tabbarVC.selectedIndex == 3)
        {        
            tabbarVC.selectedIndex = 0
        }
    }
    
    private func setupTabsView()
    {
        let psdLoginBtn = UIButton(type: .custom)
        psdLoginBtn.setTitle("账号密码登陆", for: .normal)
        psdLoginBtn.setTitleColor(WSQHighLightColor, for: .selected)
        psdLoginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        psdLoginBtn.setTitleColor(WSQGrayColor, for: .normal)
        psdLoginBtn.addTarget(self, action: #selector(codeLoginBtnAction(sender:)), for: .touchUpInside)
        psdLoginBtn.isSelected = true
        self.psdLoginTabBtn = psdLoginBtn;
        
        let codeLoginBtn = UIButton(type: .custom)
        codeLoginBtn.setTitle("短信验证码登录", for: .normal)
        codeLoginBtn.setTitleColor(WSQHighLightColor, for: .selected)
        codeLoginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        codeLoginBtn.setTitleColor(WSQGrayColor, for: .normal)
        codeLoginBtn.addTarget(self, action: #selector(codeLoginBtnAction(sender:)), for: .touchUpInside)
        self.codeLocginTabBtn = codeLoginBtn;
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 70))
        self.tableView.tableHeaderView = headerView
        
        headerView.addSubview(psdLoginBtn)
        headerView.addSubview(codeLoginBtn)
        
        psdLoginBtn.snp.makeConstraints { (maker) in
            
            maker.top.equalToSuperview().offset(20)
            maker.left.equalToSuperview()
            maker.right.equalTo(codeLoginBtn.snp.left)
            maker.height.equalTo(50)
        }
        
        codeLoginBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(psdLoginBtn)
            maker.left.equalTo(psdLoginBtn.snp.right)
            maker.bottom.equalToSuperview()
            maker.right.equalToSuperview()
            maker.width.equalTo(psdLoginBtn)
        }
        
        let backgrandGrayLine = UIView()
        backgrandGrayLine.backgroundColor = WSQGrayColor.withAlphaComponent(0.25)
        
        headerView.addSubview(backgrandGrayLine)
        
        backgrandGrayLine.snp.makeConstraints { (maker) in
            maker.height.equalTo(0.5)
            maker.right.left.equalToSuperview()
            maker.bottom.equalTo(codeLoginBtn)
        }
        
        let foregrandLine = UIView()
        foregrandLine.backgroundColor = WSQHighLightColor
        self.foreGroundLine = foregrandLine
        
        headerView.addSubview(foregrandLine)
        
        foregrandLine.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(backgrandGrayLine)
            maker.height.equalTo(1.25)
            maker.centerX.equalTo(psdLoginBtn.snp.centerX)
            maker.width.equalTo(psdLoginBtn).multipliedBy(0.6)
            
        }
        
        headerView.layoutIfNeeded()
        
        let collectionVIewHeight = UIScreen.main.bounds.height - (self.navigationController?.navigationBar.bounds.height)! - UIApplication.shared.statusBarFrame.height - headerView.bounds.height
        
        // 使用 collectionview 创建登录页面
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: view.bounds.width, height: collectionVIewHeight)
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        // 设置滑动方向
        flowLayout.scrollDirection = .horizontal
        
        let loginCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.loginView = loginCollectionView
        loginCollectionView.delegate = self
        loginCollectionView.contentSize = CGSize(width: view.bounds.width*2, height: collectionVIewHeight)
        loginCollectionView.register(WSQLoginCollectionViewCell.self,
                                     forCellWithReuseIdentifier:loginCellIdentifier)
        loginCollectionView.showsVerticalScrollIndicator = false
        loginCollectionView.showsHorizontalScrollIndicator = false
        loginCollectionView.isPagingEnabled = true
        loginCollectionView.bounces = false
        loginCollectionView.delegate = self;
        loginCollectionView.dataSource = self;
        
        self.tableView.tableFooterView = loginCollectionView
        
        loginCollectionView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.foreGroundLine.snp.bottom)
            //            maker.right.left.equalTo(tableView)
            maker.width.equalTo(tableView.bounds.width)
            //            maker.bottom.equalTo(tableView)
            maker.height.equalTo(collectionVIewHeight)
        }
    }
    
    private func setupPsdLoginView()
    {
        let psdView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height))
        let endEditingTapGes = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        psdView.addGestureRecognizer(endEditingTapGes)
        
        let accountTextField = WSQUnderLineTextFIeld(frame: CGRect.zero)
        psdView.addSubview(accountTextField)
        
        let accountLeftImageView = UIImageView(image: #imageLiteral(resourceName: "myb_set_kaihu"))
        accountTextField.leftView = accountLeftImageView
        accountTextField.attributedPlaceholder = NSAttributedString(string: "手机号/邮箱/用户名/门店会员卡号", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),
                                                                                                                                          NSAttributedStringKey.foregroundColor : WSQGrayColor])
        accountTextField.font = UIFont.systemFont(ofSize: 14)
        self.accountTextField = accountTextField
        self.accountTextField.delegate = self
        
        accountTextField.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(40)
            maker.left.equalToSuperview().offset(25)
            maker.right.equalToSuperview().offset(-25)
            maker.height.equalTo(32)
        }
        
        let psdTextField = WSQUnderLineTextFIeld(frame: CGRect.zero)
        psdTextField.isSecureTextEntry = true
        psdView.addSubview(psdTextField)
        
        let psdLeftImageView = UIImageView(image: #imageLiteral(resourceName: "myb_set_password"))
        psdLeftImageView.bounds.size = CGSize(width: 12, height: 12)
        psdTextField.leftView = psdLeftImageView
        psdTextField.attributedPlaceholder = NSAttributedString(string: "请输入密码",
                                                                attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),
                                                                             NSAttributedStringKey.foregroundColor : WSQGrayColor])
        self.psdTextField = psdTextField
        psdTextField.delegate = self
        
        psdTextField.font = UIFont.systemFont(ofSize: 14)
        
        psdTextField.snp.makeConstraints { (maker) in
            maker.top.equalTo(accountTextField.snp.bottom).offset(25)
            maker.left.equalToSuperview().offset(25)
            maker.right.equalToSuperview().offset(-25)
            maker.height.equalTo(32)
        }
        
        let phoneQuickRegistBtn = UIButton(type: .custom)
        phoneQuickRegistBtn.setTitle("手机快速注册", for: .normal)
        phoneQuickRegistBtn.sizeToFit()
        phoneQuickRegistBtn.setTitleColor(WSQLoginBlueColor, for: .normal)
        phoneQuickRegistBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        psdView.addSubview(phoneQuickRegistBtn)
        
        phoneQuickRegistBtn.snp.makeConstraints { (maker) in
            maker.left.equalTo(psdTextField)
            maker.top.equalTo(psdTextField.snp.bottom).offset(10)
        }
        
        let forgetPsdBtn = UIButton(type: .custom)
        forgetPsdBtn.setTitle("忘记密码", for: .normal)
        forgetPsdBtn.setTitleColor(WSQLoginBlueColor, for: .normal)
        forgetPsdBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        psdView.addSubview(forgetPsdBtn)
        
        forgetPsdBtn.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(phoneQuickRegistBtn)
            maker.right.equalTo(psdTextField)
        }
        
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.backgroundColor = WSQloginDisabledColor
        loginBtn.isEnabled = false
        loginBtn.addTarget(self, action: #selector(psdLoginBtnAction(sender:)), for: .touchUpInside)
        psdView.addSubview(loginBtn)
        self.psdLoginBtn = loginBtn
        
        loginBtn.snp.makeConstraints { (maker) in
            maker.left.right.equalTo(psdTextField)
            maker.top.equalTo(phoneQuickRegistBtn.snp.bottom).offset(20)
            maker.height.equalTo(48)
        }
        loginBtn.layer.cornerRadius = 24
        
        let protolLabel = UILabel()
        protolLabel.text = "登录即代表您已经同意 "
        protolLabel.font = UIFont.systemFont(ofSize: 12)
        protolLabel.sizeToFit()
        protolLabel.textColor = WSQGrayColor.withAlphaComponent(0.8)
        psdView.addSubview(protolLabel)
        
        protolLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(psdTextField)
            maker.top.equalTo(loginBtn.snp.bottom).offset(10)
        }
        
        let protoBtn = UIButton(type: .custom)
        protoBtn.setTitle("《商城服务协议》", for: .normal)
        protoBtn.titleLabel?.font = protolLabel.font
        protoBtn.setTitleColor(forgetPsdBtn.titleColor(for: .normal), for: .normal)
        protoBtn.sizeToFit()
        psdView.addSubview(protoBtn)
        
        protoBtn.snp.makeConstraints { (maker) in
            maker.left.equalTo(protolLabel.snp.right)
            maker.centerY.equalTo(protolLabel)
        }
        
        let thirdPartAccountView = UIView()
        psdView.addSubview(thirdPartAccountView)
        
        let thirdPartTitleLabel = UILabel()
        thirdPartTitleLabel.backgroundColor = .white
        thirdPartTitleLabel.text = "  使用以下账号登录  "
        thirdPartTitleLabel.textColor = WSQGrayColor.withAlphaComponent(0.75)
        thirdPartTitleLabel.font = UIFont.systemFont(ofSize: 14)
        thirdPartTitleLabel.sizeToFit()
        thirdPartAccountView.addSubview(thirdPartTitleLabel)
        
        thirdPartTitleLabel.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.centerX.equalToSuperview()
        }
        
        let thirdPartGrayLine = UIView()
        thirdPartGrayLine.backgroundColor = WSQGrayColor.withAlphaComponent(0.45)
        thirdPartAccountView.insertSubview(thirdPartGrayLine, at: 0)
        
        let wxBtn = UIButton(type: .custom)
        wxBtn.setTitleColor(WSQGrayColor.withAlphaComponent(0.8), for: .normal)
        wxBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        wxBtn.setTitle("微信", for: .normal)
        wxBtn.setImage(#imageLiteral(resourceName: "share_wx"), for: .normal)
        thirdPartAccountView.addSubview(wxBtn)
        
        let qqBtn = UIButton(type: .custom)
        qqBtn.setTitleColor(WSQGrayColor.withAlphaComponent(0.8), for: .normal)
        qqBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        qqBtn.setTitle("QQ", for: .normal)
        qqBtn.setImage(#imageLiteral(resourceName: "share_qq"), for: .normal)
        thirdPartAccountView.addSubview(qqBtn)
        
        let qyqBtn = UIButton(type: .custom)
        qyqBtn.setTitleColor(WSQGrayColor.withAlphaComponent(0.8), for: .normal)
        qyqBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        qyqBtn.setTitle("微博", for: .normal)
        qyqBtn.setImage(#imageLiteral(resourceName: "share_weibo"), for: .normal)
        thirdPartAccountView.addSubview(qyqBtn)
        
        let sinaBtn = UIButton(type: .custom)
        sinaBtn.setTitleColor(WSQGrayColor.withAlphaComponent(0.8), for: .normal)
        sinaBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        sinaBtn.setTitle("Sina", for: .normal)
        sinaBtn.setImage(#imageLiteral(resourceName: "share_sina"), for: .normal)
        thirdPartAccountView.addSubview(sinaBtn)
        
        wxBtn.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.width.equalToSuperview().dividedBy(4)
            maker.height.equalTo(wxBtn.snp.width)
            maker.top.equalTo(thirdPartTitleLabel.snp.bottom).offset(20)
            maker.bottom.equalToSuperview()
        }
        
        qqBtn.snp.makeConstraints { (maker) in
            maker.left.equalTo(wxBtn.snp.right)
            maker.width.height.equalTo(wxBtn)
            maker.centerY.equalTo(wxBtn)
        }
        
        qyqBtn.snp.makeConstraints { (maker) in
            maker.left.equalTo(qqBtn.snp.right)
            maker.width.height.equalTo(qqBtn)
            maker.centerY.equalTo(qqBtn)
        }
        
        sinaBtn.snp.makeConstraints { (maker) in
            maker.left.equalTo(qyqBtn.snp.right)
            maker.width.height.equalTo(qyqBtn)
            maker.centerY.equalTo(qyqBtn)
        }
        
        thirdPartGrayLine.snp.makeConstraints { (maker) in
            maker.center.equalTo(thirdPartTitleLabel)
            maker.width.equalToSuperview()
            maker.height.equalTo(0.5)
        }
        
        thirdPartAccountView.snp.makeConstraints { (maker) in
            maker.left.right.equalTo(psdTextField)
            maker.bottom.equalToSuperview().offset(-30)
        }
        
        wxBtn.sq_titleLabelAlignment = .bottom
        qqBtn.sq_titleLabelAlignment = .bottom
        qyqBtn.sq_titleLabelAlignment = .bottom
        sinaBtn.sq_titleLabelAlignment = .bottom
        
        self.psdLoginView = psdView;
    }
    
    private func setupCodeLoginView()
    {
        let codeView = UIView()
        let endEditingTapGes = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        codeView.addGestureRecognizer(endEditingTapGes)
        
        let phoneTextField = WSQUnderLineTextFIeld()
        self.phoneTextfield = phoneTextField
        phoneTextfield.clearButtonMode = .whileEditing
        phoneTextField.delegate = self
        phoneTextfield.keyboardType = .phonePad
        phoneTextField.font = UIFont.systemFont(ofSize: 12)
        phoneTextField.leftView = UIImageView(image: #imageLiteral(resourceName: "myb_set_kaihu"))
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "请输入手机号", attributes:
            [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),
             NSAttributedStringKey.foregroundColor : WSQGrayColor])
        codeView.addSubview(phoneTextField)
        
        phoneTextField.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(40)
            maker.left.equalToSuperview().offset(25)
            maker.height.equalTo(32)
            maker.right.equalToSuperview().offset(-25)
        }
        
        let sentCodeBtn = UIButton(type: .custom)
        sentCodeBtn.isEnabled = false
        sentCodeBtn.setTitle("获取验证码", for: .normal)
        sentCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sentCodeBtn.setTitleColor(WSQGrayColor, for: .normal)
        sentCodeBtn.layer.borderWidth = 1
        sentCodeBtn.layer.borderColor = WSQGrayColor.withAlphaComponent(0.25).cgColor
        sentCodeBtn.layer.cornerRadius = 17
        codeView.addSubview(sentCodeBtn)
        self.verificationBtn = sentCodeBtn
        
        sentCodeBtn.addTarget(self, action: #selector(verficationCodeCountDown), for: .touchUpInside)
        
        let codeTextField = WSQUnderLineTextFIeld()
        codeTextField.keyboardType = .numberPad
        codeTextField.clearButtonMode = .whileEditing
        self.codeTextField = codeTextField
        codeTextField.delegate = self
        codeTextField.font = UIFont.systemFont(ofSize: 12)
        codeTextField.leftView = UIImageView(image: #imageLiteral(resourceName: "keyIcon_Normal"))
        codeTextField.attributedPlaceholder = NSAttributedString(string: "请输入短息验证码", attributes:
            [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),
             NSAttributedStringKey.foregroundColor : WSQGrayColor])
        codeView.addSubview(codeTextField)
        
        sentCodeBtn.snp.makeConstraints { (maker) in
            maker.height.equalTo(34)
            maker.bottom.equalTo(codeTextField)
            maker.left.equalTo(codeTextField.snp.right).offset(8)
            maker.width.equalTo(100)
            maker.right.equalToSuperview().offset(-25)
        }
        
        codeTextField.snp.makeConstraints { (maker) in
            maker.top.equalTo(phoneTextField.snp.bottom).offset(25)
            maker.left.equalToSuperview().offset(25)
            maker.height.equalTo(32)
        }
        
        let phoneLoginBtn = UIButton(title: "登录", titleColor:  .white, fontSize: 18, image: nil, for: .normal)
        phoneLoginBtn.backgroundColor = WSQloginDisabledColor
        phoneLoginBtn.addTarget(self, action: #selector(phoneLoginBtnAction(_:)), for: .touchUpInside)
        self.phoneLoginBtn = phoneLoginBtn
        phoneLoginBtn.isEnabled = false
        phoneLoginBtn.layer.cornerRadius = 22
        codeView.addSubview(phoneLoginBtn)
        
        phoneLoginBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(codeTextField.snp.bottom).offset(20)
            maker.left.right.equalTo(phoneTextField)
            maker.height.equalTo(44)
        }
        
        let codeViewTipsLabel = UILabel(frame: CGRect.zero, text: "未注册手机登录成功将自动注册,且代表您已经同意协议", fontSize: 12, textColor: WSQGrayColor, textAlignment: .left)
        codeViewTipsLabel.minimumScaleFactor = 0.5
        codeViewTipsLabel.sizeToFit()
        codeView.addSubview(codeViewTipsLabel)
        
        codeViewTipsLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(phoneLoginBtn.snp.bottom).offset(12)
            maker.left.right.equalTo(phoneLoginBtn)
        }
        
        let mallProtocolBtn = UIButton(title: "《国美平台服务协议》", titleColor: WSQLoginBlueColor, fontSize: 12, for: .normal)
        let mfbProtocalBtn = UIButton(title: "《美付宝用户服务协议》", titleColor: WSQLoginBlueColor, fontSize: 12, for: .normal)
        mallProtocolBtn.sizeToFit()
        mfbProtocalBtn.sizeToFit()
        codeView.addSubview(mallProtocolBtn)
        codeView.addSubview(mfbProtocalBtn)
        
        mallProtocolBtn.snp.makeConstraints { (maker) in
            maker.left.equalTo(phoneLoginBtn)
            maker.top.equalTo(codeViewTipsLabel.snp.bottom)
        }
        mfbProtocalBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(mallProtocolBtn)
            maker.left.equalTo(mallProtocolBtn.snp.right)
        }
        
        self.codeLoginView = codeView
    }
    // MARK: 发送验证码倒计时
    @objc private func verficationCodeCountDown()
    {
        self.hud = MBProgressHUD.showAdded(to: (self.navigationController?.view)!, animated: true)
        self.view.endEditing(true)
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+2) {
            [unowned self]in
            
            DispatchQueue.main.async(execute: {
                self.hud.mode = .text
                self.hud.hide(animated: true)
                self.hud.show(animated: true)
                self.hud.label.text = "验证码发送成功"
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: {
                    self.hud.hide(animated: true)
                })
                self.verificationBtn.isEnabled = false
                self.verificationBtn.setTitleColor(WSQGrayColor.withAlphaComponent(0.65), for: .normal)
                self.verificationBtn.layer.borderColor = WSQGrayColor.withAlphaComponent(0.8).cgColor
            })
            
            self.timer = DispatchSource.makeTimerSource()
            self.timer.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.microseconds(0))
            self.timer.setEventHandler {
                [unowned self] in
                if (self.remainingScends > 0)
                {
                    DispatchQueue.main.async(execute: {
                        self.verificationBtn.setTitle("\(self.remainingScends.description)s", for: .normal)
                        self.remainingScends -= 1
                        print(self.remainingScends)
                    })
                }else
                {
                    DispatchQueue.main.async(execute: {
                        self.verificationBtn.setTitle("获取验证码", for: .normal)
                        self.verificationBtn.layer.borderColor = WSQHighLightColor.withAlphaComponent(0.8).cgColor
                        self.verificationBtn.setTitleColor(WSQHighLightColor.withAlphaComponent(0.8), for: .normal)
                        self.remainingScends = 60
                        self.verificationBtn.isEnabled = true
                        self.timer.cancel()
                    })
                    return
                }
            }
            self.timer.resume()
            
        }
    }
}

// MARK: - CollectionViewDataSource && collectionviewdelegate
extension WSQLoginTableViewController : UICollectionViewDataSource,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellIdentifier, for: indexPath) as! WSQLoginCollectionViewCell
        if indexPath.row == 0
        {
            cell.contentSubView = self.psdLoginView
        }else if indexPath.row == 1
        {
            cell.contentSubView = self.codeLoginView
        }
        
        return cell
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let button :UIButton! = (offsetX > psdLoginView.bounds.size.width/2) ? self.codeLocginTabBtn:self.psdLoginTabBtn
        self.loginViewDidScroll(sender: button)
    }
    @objc private func loginViewDidScroll(sender : UIButton)
    {
        if sender == self.codeLocginTabBtn && sender.isSelected == false
        {
            self.psdLoginTabBtn.isSelected = false;
            
        }else if sender == self.psdLoginTabBtn && sender.isSelected == false
        {
            self.codeLocginTabBtn.isSelected = false
        }
        sender.isSelected = true
        UIView.animate(withDuration: 0.25) {
            self.foreGroundLine.center.x = sender.center.x
        }
    }
}

// MAKR: - UITextFieldDelegate
extension WSQLoginTableViewController:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 控制账号密码登录页面的登录按钮
        if (textField == self.psdTextField || textField == self.accountTextField)
        {
            let otherTextField = textField == self.psdTextField ? self.accountTextField : self.psdTextField
            if (otherTextField?.text?.count != 0)
            {
                if (range.location == 0 && string == "")
                {
                    self.psdLoginBtn.isEnabled = false
                    self.psdLoginBtn.backgroundColor = WSQloginDisabledColor
                }else
                {
                    self.psdLoginBtn.isEnabled = true
                    self.psdLoginBtn.backgroundColor = WSQHighLightColor.withAlphaComponent(0.8)
                }
                
            }else
            {
                self.psdLoginBtn.isEnabled = false
                self.psdLoginBtn.backgroundColor = WSQloginDisabledColor
            }
        }else if (textField == self.phoneTextfield)// 控制验证码登录页面的发送验证码按钮和登录按钮
        {
            let length = (textField.text?.count)! + string.count - range.length
            if length == 11 || length - string.count == 11
            {
                self.verificationBtn.layer.borderColor = WSQHighLightColor.withAlphaComponent(0.8).cgColor
                self.verificationBtn.setTitleColor(WSQHighLightColor.withAlphaComponent(0.8), for: .normal)
                self.verificationBtn.isEnabled = true
                if (self.codeTextField.text?.count != 0)
                {
                    self.phoneLoginBtn.backgroundColor = WSQLightHighLightColor
                    self.phoneLoginBtn.isEnabled = true
                }else
                {
                    self.phoneLoginBtn.backgroundColor = WSQloginDisabledColor
                    self.phoneLoginBtn.isEnabled = false
                }
            }else
            {
                self.verificationBtn.isEnabled = false
                self.verificationBtn.setTitleColor(WSQGrayColor.withAlphaComponent(0.65), for: .normal)
                self.verificationBtn.layer.borderColor = WSQGrayColor.withAlphaComponent(0.8).cgColor
                self.phoneLoginBtn.backgroundColor = WSQloginDisabledColor
                self.phoneLoginBtn.isEnabled = false
            }
            return length <= 11
        }else if (textField == self.codeTextField)
        {
            let length = (textField.text?.count)! + string.count - range.length
            if (length > 0)
            {
                if (self.phoneTextfield.text?.count == 11)
                {
                    self.phoneLoginBtn.backgroundColor = WSQLightHighLightColor
                    self.phoneLoginBtn.isEnabled = true
                }else
                {
                    self.phoneLoginBtn.backgroundColor = WSQloginDisabledColor
                    self.phoneLoginBtn.isEnabled = false
                }
            }else
            {
                self.phoneLoginBtn.backgroundColor = WSQloginDisabledColor
                self.phoneLoginBtn.isEnabled = false
            }
        }
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField == self.phoneTextfield
        {
            self.verificationBtn.isEnabled = false
            self.verificationBtn.setTitleColor(WSQGrayColor.withAlphaComponent(0.65), for: .normal)
            self.verificationBtn.layer.borderColor = WSQGrayColor.withAlphaComponent(0.8).cgColor
            self.phoneLoginBtn.backgroundColor = WSQloginDisabledColor
            self.phoneLoginBtn.isEnabled = false
        }else if textField == self.codeTextField
        {
            self.phoneLoginBtn.backgroundColor = WSQloginDisabledColor
            self.phoneLoginBtn.isEnabled = false
        }
        return true
    }
}

