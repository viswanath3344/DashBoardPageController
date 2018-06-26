//
//  SwipeCollectionViewController.swift
//  DashBoardPageController
//
//  Created by Ming-En Liu on 25/06/18.
//  Copyright © 2018 Vedas labs. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

struct Page {
    let imageName:String
    let title:String
    let subTitle:String
}

class SwipeCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
        }) { (_) in
            
        }
    }

    
    let pagesArray = [
        Page(imageName: "SuperMario1", title: "A new kind of Mario game that you can play with one hand", subTitle: "You control Mario by tapping as he constantly runs forward. You time your taps to pull off stylish jumps, midair spins, and wall jumps to gather coins and reach the goal!"),
        Page(imageName: "SuperMario2", title: "Many ways to play.", subTitle: "Aside from Remix 10, these are the other ways to enjoy the game."),
        Page(imageName: "SuperMario3", title: "Playable Characters", subTitle: "Other than Mario, you can play with many other characters that have unique characteristics.")
    ]
    let prevButton:UIButton = {
        
        let button = UIButton()
        button.setTitle("PREV", for: UIControlState.normal)
        button.setTitleColor(UIColor.gray, for: UIControlState.normal)
        button.addTarget(self, action: #selector(prevAction), for: .touchUpInside)
        return button
    }()
    
    let rightButton:UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: UIControlState.normal)
        button.setTitleColor(UIColor.red, for: UIControlState.normal)
        button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        
        return button
        
    }()
    
    lazy var pageControl:UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pagesArray.count
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlAction), for: .valueChanged)
        
        return pageControl
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBottomStackView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(SwipeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.isPagingEnabled = true
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func nextAction(){
        
        let nextPageIndex = min(pageControl.currentPage+1, pagesArray.count-1)  // Getting  Minimum value. (0,2) = 0 , (1,2) = 1, (2,2) = 2, (3,2) = 2
        let indexPath = IndexPath(item: nextPageIndex, section: 0)
        pageControl.currentPage = nextPageIndex
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    
    }
    
    @objc func prevAction(){
        
        let prevPageIndex = max(pageControl.currentPage-1,0) // Getting  Max value. (0,0) = 0 , (1,0) = 1, (2,0) = 2, (-1,0) = 0
        let indexPath = IndexPath(item: prevPageIndex, section: 0)
        pageControl.currentPage = prevPageIndex
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        
    }
    
    @objc func pageControlAction(){
        
           let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
           collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
         pageControl.currentPage = Int(targetContentOffset.pointee.x/view.frame.size.width)
        
    }

   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return view.frame.size
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pagesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SwipeCollectionViewCell
        let page = pagesArray[indexPath.item]
        cell.page = page
        
        return cell
    }
    
    
    private func setUpBottomStackView() {
        
        let stackView = UIStackView(arrangedSubviews: [prevButton,pageControl,rightButton])
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
    }
    
}
