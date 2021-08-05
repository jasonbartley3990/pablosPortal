//
//  ViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

import AVFoundation
import JGProgressHUD
import FirebaseFirestore

class PablosPortalHomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AVAudioPlayerDelegate {
    

    private var collectionView: UICollectionView?
    
    private var productViewModels: [[HomeFeedCellType]] = []
    
    private var currentIndex = 0
    
    private var currentShopingCart: [String] = []
    
    private let spinner = JGProgressHUD(style: .dark)
    
    let childVC = MusicInfoViewController()
    
    private var player: AVAudioPlayer?
    
    public var musicIsPlaying: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "PABLO'S PORTAL"
        
        addChild(childVC)
        view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
        childVC.view.alpha = 0
        childVC.view.isUserInteractionEnabled = false
        childVC.delegate = self
        childVC.isInSignInViewController = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeCartFromProfile), name: NSNotification.Name("cartChangeFromProfile"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didPurchase), name: NSNotification.Name("didPurchase"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeSignIn), name: NSNotification.Name("didChangeSignIn"), object: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "music.note"), style: .done, target: self, action: #selector(didTapMusic))
        
      
        
        
        configureCollectionView()
        fetchProducts()
        
        playMusic()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //let childHeight = (view.height/11)
        let childHeight: CGFloat = 60
        collectionView?.frame = view.bounds
        childVC.view.frame = CGRect(x: 10, y: self.view.height - childHeight - self.view.safeAreaInsets.bottom - 10, width: self.view.width - 20, height: childHeight)
        childVC.view.layer.cornerRadius = 8
        childVC.view.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if infoManager.shared.isHomeViewControllerNotCurrent {
            print("continue playing music")
        } else {
            playMusic()
        }
    }
    
    //MARK: music integration
    
    private func playMusic() {
        do {
            var musicUrl: String = ""
            
            if infoManager.shared.playingFirstSong {
                musicUrl = Bundle.main.path(forResource: "electricRelaxation", ofType: "mp3")!
            } else {
                musicUrl = Bundle.main.path(forResource: "montegobay", ofType: "mp3")!
            }
            
           
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicUrl))
            
            player?.delegate = self
            
            guard var player = player else {
                return
            }
            
            player.play()
            musicIsPlaying = true
            
            NotificationCenter.default.post(name: Notification.Name("didChangeMusic"), object: nil)
            
            if infoManager.shared.playingFirstSong {
                childVC.songName.text = "electric relaxation (cover)"
            } else {
                childVC.songName.text = "montego bay"
            }
            UIView.animate(withDuration: 0.4, animations: {
                print("did animate")
                self.view.bringSubviewToFront(self.childVC.view)
                self.childVC.view.alpha = 1
            })
            
            
            childVC.view.isUserInteractionEnabled = true
            childVC.closeImage.isUserInteractionEnabled = true
            
            let _ = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(closeMusicInfo), userInfo: nil, repeats: false)
        
        } catch {
            print("unable tp play music")
        }
    }
    
    //MARK: pausing and playing
    
    @objc func didTapMusic() {
        if musicIsPlaying {
            pauseMusic()
            
            childVC.imageView.image = UIImage(systemName: "pause")
            
            UIView.animate(withDuration: 0.4, animations: {
                print("did animate")
                self.view.bringSubviewToFront(self.childVC.view)
                self.childVC.view.alpha = 1
            })
            childVC.view.isUserInteractionEnabled = true
            childVC.closeImage.isUserInteractionEnabled = true

            let _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(closeMusicInfo), userInfo: nil, repeats: false)
            
        } else {
            continuePlayingMusic()
            
            childVC.imageView.image = UIImage(systemName: "play")
            
            UIView.animate(withDuration: 0.4, animations: {
                print("did animate")
                self.view.bringSubviewToFront(self.childVC.view)
                self.childVC.view.alpha = 1
            })
            childVC.view.isUserInteractionEnabled = true
            childVC.closeImage.isUserInteractionEnabled = true

            let _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(closeMusicInfo), userInfo: nil, repeats: false)
        }
    }
    
    public func pauseMusic() {
        player?.pause()
        musicIsPlaying = false
    }
    
    public func stopMusic() {
        player?.stop()
        musicIsPlaying = false
    }
    
    public func continuePlayingMusic() {
        player?.play()
        musicIsPlaying = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        infoManager.shared.playingFirstSong = !infoManager.shared.playingFirstSong
        playMusic()
    }
    
    @objc func closeMusicInfo() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, animations: {
                self.childVC.view.alpha = 0
            })
        }
        childVC.view.isUserInteractionEnabled = false
        childVC.closeImage.isUserInteractionEnabled = false
        
    }
    
    
    //MARK: grab current products
    
    private func fetchProducts() {
        if infoManager.shared.isSignedIn {
            self.productViewModels = []
            
            guard let email = UserDefaults.standard.string(forKey: "email") else {
                return}
            
            //check their cart
            
            DatabaseManager.shared.getUserCart(with: email, completion: {
                [weak self] cartItems in
                
                print(cartItems)
                self?.currentShopingCart = cartItems
                infoManager.shared.currentCart = cartItems
                
                //grab all of the stores items
                
                DatabaseManager.shared.grabItems(completion: {
                    [weak self] items, document in
                    
                    let group = DispatchGroup()
                    
                    var newViewModels = [[HomeFeedCellType]]()
                    newViewModels = []
                    
                    for item in items {
                        group.enter()
                        
                        let isItemInCart = infoManager.shared.currentCart.contains(item.productId)
                        
                        let productData: [HomeFeedCellType] = [
                            .productTitle(viewModel: ProductTitleCollectionViewCellViewModel(title: item.itemName)),
                            .MultiImageViewCell(viewModel: MultiImageViewCellViewModel(urlCount: item.urlCount, urls: item.urls, item: item)),
                            .pageTurner(viewModel: PageTurnerViewModel(urlCount: item.urlCount)),
                            .price(viewModel: PriceCollectionViewCellViewModel(price: item.price)),
                            .actions(viewModel: ActionsCollectionViewCellViewModel(item: item, isInCart: isItemInCart, isSold: item.isSold)),
                            ]
                        newViewModels.append(productData)
                        group.leave()
                            
                    }
                    
                    group.notify(queue: .main, execute: {
                        self?.productViewModels = newViewModels
                        self?.collectionView?.reloadData()
                       
                    })
                })
           
            })
        } else {
            //grab all of the stores items
            
            DatabaseManager.shared.grabItems(completion: {
                [weak self] items, document in
                
                let group = DispatchGroup()
                
                var newViewModels = [[HomeFeedCellType]]()
                newViewModels = []
                
                for item in items {
                    group.enter()
                    
                    let productData: [HomeFeedCellType] = [
                        .productTitle(viewModel: ProductTitleCollectionViewCellViewModel(title: item.itemName)),
                        .MultiImageViewCell(viewModel: MultiImageViewCellViewModel(urlCount: item.urlCount, urls: item.urls, item: item)),
                        .pageTurner(viewModel: PageTurnerViewModel(urlCount: item.urlCount)),
                        .price(viewModel: PriceCollectionViewCellViewModel(price: item.price)),
                        .actions(viewModel: ActionsCollectionViewCellViewModel(item: item, isInCart: false, isSold: item.isSold)),
                        ]
                    newViewModels.append(productData)
                    group.leave()
                        
                }
                
                group.notify(queue: .main, execute: {
                    self?.productViewModels = newViewModels
                    self?.collectionView?.reloadData()
                   
                })
            })
        }
        
      
        
    }
    
    //updating controller when actions are done
    
    @objc func didChangeCartFromProfile() {
        productViewModels.removeAll()
        fetchProducts()
    }
    
    
    @objc func didPurchase() {
        productViewModels.removeAll()
        fetchProducts()
        stopMusic()
    }
    
    @objc func didChangeSignIn() {
        fetchProducts()
        stopMusic()
        playMusic()
    }
    
    
    //MARK: collection view functions
    
    private func configureCollectionView() {
        
        let sectionHeight: CGFloat = 190 + view.width
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: {
            index, _ -> NSCollectionLayoutSection? in
            
            //item
            let productTitleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
            )
            
            let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
            
            let pageIndicatorItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20)))
            
            let priceItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)))
            
            let actionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)))
            
            
            //group
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(sectionHeight)), subitems: [productTitleItem, productItem, pageIndicatorItem, priceItem, actionItem]
            )
            //section
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 0, bottom: 10, trailing: 0)
            
            return section
        }))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductTitleCollectionViewCell.self, forCellWithReuseIdentifier: ProductTitleCollectionViewCell.identifier)
        collectionView.register(MultiImageCollectionViewCell.self, forCellWithReuseIdentifier: MultiImageCollectionViewCell.identifier)
        collectionView.register(PageTurnerCollectionViewCell.self, forCellWithReuseIdentifier: PageTurnerCollectionViewCell.identifier)
        collectionView.register(PriceCollectionViewCell.self, forCellWithReuseIdentifier: PriceCollectionViewCell.identifier)
        collectionView.register(ActionsCollectionViewCell.self, forCellWithReuseIdentifier: ActionsCollectionViewCell.identifier)
        self.collectionView = collectionView
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return productViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = productViewModels[indexPath.section][indexPath.row]
        switch cellType {
        case .MultiImageViewCell(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultiImageCollectionViewCell.identifier, for: indexPath) as? MultiImageCollectionViewCell else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: viewModel)
            return cell
        case .productTitle(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductTitleCollectionViewCell.identifier, for: indexPath) as? ProductTitleCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        case .price(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PriceCollectionViewCell.identifier, for: indexPath) as? PriceCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        case .actions(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActionsCollectionViewCell.identifier, for: indexPath) as? ActionsCollectionViewCell else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: viewModel)
            return cell
        case .pageTurner(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageTurnerCollectionViewCell.identifier, for: indexPath) as? PageTurnerCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        case .remove(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RemoveItemFromCartCollectionViewCell.identifier, for: indexPath) as? RemoveItemFromCartCollectionViewCell else { fatalError() }
            return cell
        case .selectSize(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectSizeCollectionViewCell.identifier, for: indexPath) as? SelectSizeCollectionViewCell else { fatalError() }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productViewModels[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
        
        if cell.reuseIdentifier == ActionsCollectionViewCell.identifier {
            guard let cell = cell as? ActionsCollectionViewCell else {return}
            cell.index = indexPath.section
            
            //checks if item is in their current cart
            
            if !cell.isInCart {
                cell.bagButton.tintColor = .systemGray
            } else {
                cell.bagButton.tintColor = .systemGreen
            }
            
            
            if cell.isSold {
                cell.bagButton.isHidden = true
                cell.infoButton.isHidden = true
                cell.bagButton.isUserInteractionEnabled = false
                cell.infoButton.isUserInteractionEnabled = false
                
                cell.secondInfoButton.isHidden = false
                cell.soldLabel.isHidden = false
                cell.secondInfoButton.isUserInteractionEnabled = true
                
            } else {
                print("not sold")
            }
    
        }
        
        
        if cell.reuseIdentifier == MultiImageCollectionViewCell.identifier {
            guard let cell = cell as? MultiImageCollectionViewCell else {return}
            cell.index = indexPath.section
            print(indexPath)
            
        }
    }
    
        
}

//MARK: multi image view cell

extension PablosPortalHomeViewController: MultiImageViewDelegate {
    func MultiImageViewDelegateDidTapInfo(_ cell: MultiImageCollectionViewCell, index: Int) {
        
    }
    
    func MultiImageViewDelegateDidScroll(_ cell: MultiImageCollectionViewCell, page: Int, index: Int) {
        print("did scroll")
            let pageIndex = IndexPath(row: 2, section: index)
            guard let pageCell = collectionView?.cellForItem(at: pageIndex) as? PageTurnerCollectionViewCell else {return}
            pageCell.pageTurner.currentPage = page
            
        }
    
}

//MARK: actions cell

extension PablosPortalHomeViewController: ActionCollectionViewCellDelegate {
    func didTapBag(_ cell: ActionsCollectionViewCell, index: Int, item: Item, itemSaved: Bool) {
        if infoManager.shared.isSignedIn {
            if itemSaved {
                spinner.show(in: view)
                guard let email = UserDefaults.standard.string(forKey: "email") else {return}
                DatabaseManager.shared.removeItemFromCart(email: email, item: item.productId, completion: {
                    [weak self] success in
                    if success {
                        DispatchQueue.main.async {
                            cell.bagButton.tintColor = .systemGray
                        }
                        cell.isInCart = false
                        cell.updateBagImage()
                        self?.productViewModels[index][4] = HomeFeedCellType.actions(viewModel: ActionsCollectionViewCellViewModel(item: item, isInCart: false, isSold: item.isSold))
                        infoManager.shared.currentCart.removeAll(where: { $0.contains(item.productId)})
                        NotificationCenter.default.post(name: Notification.Name("cartChangeFromHome"), object: nil)
                        self?.spinner.dismiss()
                    } else {
                        let ac = UIAlertController(title: "unable to update cart at the moment", message: "please try again", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                        DispatchQueue.main.async {
                            self?.spinner.dismiss()
                            self?.present(ac, animated: true)
                        }
                    }
                })
            } else {
                spinner.show(in: view)
                guard let email = UserDefaults.standard.string(forKey: "email") else {return}
                DatabaseManager.shared.addItemToCart(email: email, item: item.productId, completion: {
                    [weak self] success in
                    if success {
                        DispatchQueue.main.async {
                            cell.bagButton.tintColor = .systemGreen
                        }
                        cell.isInCart = true
                        cell.updateBagImage()
                        self?.productViewModels[index][4] = HomeFeedCellType.actions(viewModel: ActionsCollectionViewCellViewModel(item: item, isInCart: true, isSold: item.isSold))
                        infoManager.shared.currentCart.append(item.productId)
                        NotificationCenter.default.post(name: Notification.Name("cartChangeFromHome"), object: nil)
                        self?.spinner.dismiss()
                    } else {
                        let ac = UIAlertController(title: "unable to update cart at the moment", message: "please try again", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                        DispatchQueue.main.async {
                            self?.spinner.dismiss()
                            self?.present(ac, animated: true)
                        }
                    }
                })
            }
            
            
        } else {
            let ac = UIAlertController(title: "not signed in", message: "please sign in to add to cart", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            DispatchQueue.main.async { [weak self] in
                self?.present(ac, animated: true, completion: nil)
            }
        }
        
    }
            
    
    func didTapInfo(_cell: ActionsCollectionViewCell, info: String, index: Int) {
        print("did tap info")
        let productPhotoIndex = IndexPath(row: 1, section: index)
        guard let cell = collectionView?.cellForItem(at: productPhotoIndex) as? MultiImageCollectionViewCell else {
            print("returning")
            return}
       
        if cell.isCurrentlyInInfoMode == false {
            cell.isCurrentlyInInfoMode = !cell.isCurrentlyInInfoMode
            cell.animateInfo()
        } else {
            cell.isCurrentlyInInfoMode = !cell.isCurrentlyInInfoMode
            cell.DeanimateInfo()
        }
       
        
    }
    
    
}

//MARK: music info

extension PablosPortalHomeViewController: MusicInfoViewDelegate {
    func MusicInfoViewDelegateDidTapClose(_ musicInfoView: MusicInfoViewController) {
        print("did tap close")
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, animations: {
                self.childVC.view.alpha = 0
            })
        }
        childVC.view.isUserInteractionEnabled = false
        childVC.closeImage.isUserInteractionEnabled = false
    }
    
    
}

    
