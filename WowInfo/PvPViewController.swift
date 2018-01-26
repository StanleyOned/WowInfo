//
//  ViewController.swift
//  WowInfo
//
//  Created by Stanley Delacruz on 1/24/18.
//  Copyright © 2018 Stanley Delacruz. All rights reserved.
//

import UIKit
import ViewAnimator

class PvPViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    var models = [Model]()
    
    lazy var TwosButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("2v2", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.tintColor = UIColor(white: 1, alpha: 0.5)
        b.addTarget(self, action: #selector(handleTwos), for: .touchUpInside)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return b
    }()
    
    lazy var ThreesButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("3v3", for: .normal)
        b.addTarget(self, action: #selector(handleThrees), for: .touchUpInside)
        b.setTitleColor(.lightGray, for: .normal)
        b.tintColor = UIColor(white: 0, alpha: 0.5)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return b
    }()
    
    lazy var FivesButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("RBG", for: .normal)
        b.addTarget(self, action: #selector(handleFives), for: .touchUpInside)
        b.setTitleColor(.lightGray, for: .normal)
        b.tintColor = UIColor(white: 1, alpha: 0.5)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return b
    }()
    
    @objc fileprivate func handleTwos() {
        TwosButton.setTitleColor(.black, for: .normal)
        ThreesButton.setTitleColor(.lightGray, for: .normal)
        FivesButton.setTitleColor(.lightGray, for: .normal)
        fetchData(ladder: "2v2")
        
    }
    
    @objc fileprivate func handleThrees() {
        TwosButton.setTitleColor(.lightGray, for: .normal)
        ThreesButton.setTitleColor(.black, for: .normal)
        FivesButton.setTitleColor(.lightGray, for: .normal)
        fetchData(ladder: "3v3")
        
    }
    
    @objc fileprivate func handleFives() {
        TwosButton.setTitleColor(.lightGray, for: .normal)
        ThreesButton.setTitleColor(.lightGray, for: .normal)
        FivesButton.setTitleColor(.black, for: .normal)
        fetchData(ladder: "rbg")
        
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = view.center
        indicator.activityIndicatorViewStyle = .gray
        return indicator
    }()
    
    func refresh() {
        collectionView?.backgroundView = activityIndicator
        activityIndicator.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "PvP Leaderboards"
        collectionView?.alwaysBounceVertical = false
        collectionView?.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        setupMenuBar()
        collectionView?.register(PvPCell.self, forCellWithReuseIdentifier: cellId)
        fetchData(ladder: "2v2")
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    fileprivate func fetchData(ladder: String) {
        
        let urlLink = "https://us.api.battle.net/wow/leaderboard/\(ladder)?locale=en_US&apikey=rsmys4vwrt4rtt5ua8s7p6jbvq64wku8"
        
        guard let url = URL(string: urlLink) else {return}
        models = [Model]()
        refresh()
        URLSession.shared.dataTask(with: url) { (data , response , err) in
            
            if let err = err {
                print("Failed fetching data with error: ", err)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                guard let rankings = json?["rows"] as? [[String: Any]] else {return}
                for character in rankings as [[String: Any]] {

                    
                    let model = Model(dictionary: character)
                    self.models.append(model)
                    if self.models.count > 100 {
                        break
                    }
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                    let indexPath = IndexPath(item: 0, section: 0)
                    self.collectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
                    self.activityIndicator.stopAnimating()
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }
    
    fileprivate func setupMenuBar() {
        
        let redView = UIView()
        redView.backgroundColor = .white//UIColor(red: 1, green: 0/255, blue: 0/255, alpha: 0.9)
        let lineView = UIView()
        lineView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        redView.addSubview(lineView)
        view.addSubview(redView)
        
        redView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        redView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        redView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        redView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lineView.anchor(top: nil, left: redView.leftAnchor, bottom: redView.bottomAnchor, right: redView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        
        let stackView = UIStackView(arrangedSubviews: [TwosButton, ThreesButton, FivesButton])
        stackView.backgroundColor = .clear
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        redView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: redView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: redView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: redView.rightAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PvPCell
        cell.model = models[indexPath.item]
        let animation2 = AnimationType.zoom(scale: 0.5)
        cell.animate(animations: [animation2])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?,
                right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat ) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top , constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left , constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom , constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right , constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

