//
//  WSQPageViewController.swift
//  WSQMall
//
//  Created by 翁胜琼 on 2018/4/2.
//  Copyright © 2018年 John. All rights reserved.
//  项目中所有分页标签控制器

/// 顶部标签栏高度
private let pageTabViewHeight : CGFloat = 80.0;
/// 顶部标签栏宽度
private let pageTabViewWidth  : CGFloat = 80.0;
/// 顶部标签栏 cell 重用标识符
private let tabsCellIdentifier = "tabsCellIdentifier";

import UIKit
import SnapKit

enum PageViewStyle {
    case underLine
}

class WSQPageViewController: UIViewController {
    
    private var tabsView : UICollectionView!
    
    private var titles: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cz_random()
        
        setupTabsView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    init(withTitles titles : [String] , subViewClasses subClass : [AnyClass] , type : PageViewStyle) {
        super.init(nibName: nil, bundle: nil)
        self.titles = titles
        
        
    }
    
    // 创建标签栏
    private func setupTabsView()
    {
        let tabsLayout = UICollectionViewFlowLayout()
        tabsLayout.estimatedItemSize = CGSize(width: pageTabViewWidth, height: 80)
        tabsLayout.minimumInteritemSpacing = 30;
        tabsLayout.minimumLineSpacing = 20;
        
        self.tabsView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 80), collectionViewLayout: tabsLayout)
        self.tabsView.delegate = self
        self.tabsView.dataSource = self
        self.tabsView.showsVerticalScrollIndicator = false
        self.tabsView.showsHorizontalScrollIndicator = false;
        
        self.tabsView.register(tabsViewCell.self, forCellWithReuseIdentifier: tabsCellIdentifier)
        
        view.addSubview(tabsView)
        self.tabsView.backgroundColor = UIColor.cz_random()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension WSQPageViewController : UICollectionViewDelegate,UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == tabsView)
        {
            let tabsCell = collectionView.dequeueReusableCell(withReuseIdentifier: tabsCellIdentifier, for: indexPath) as! tabsViewCell
            tabsCell.text = self.titles[indexPath.row]
            
            return tabsCell
        }
        return UICollectionViewCell(frame: CGRect.zero)
    }
    
    
}

// MAKR: - tabsViewCell 顶部标签cell
private class tabsViewCell : UICollectionViewCell
{
    public var text : String = ""
    {
        didSet
        {
            self.label.text = text;
        }
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.textColor = WSQGrayColor
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // cell 宽度自适应文字内容
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let attr = super.preferredLayoutAttributesFitting(layoutAttributes)
        
        var newFrame = (text as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: attr.bounds.height), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : label.font], context: nil)
        newFrame.size.width += 10;
        attr.frame = newFrame;
        
        print(text)
        print("attr.frame = \(attr.frame)")
        
        // 如果labbel 控件不是使用约束来创建的，则需要手动改变 frame
        // label.frame = CGRect(x: 0, y: 0, width: newFrame.width, height: newFrame.height)
        
        return attr;
    }
    
    private func setupUI()
    {
        self.addSubview(label)

        self.label.backgroundColor = UIColor.cz_random()
        self.backgroundColor = UIColor.cz_random()
        
        label.snp.makeConstraints { (maker) in
            maker.top.left.bottom.right.equalToSuperview()
        }
    }
    
}







