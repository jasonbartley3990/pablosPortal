//
//  ProfileViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit
import JGProgressHUD

class ProfileViewController: UIViewController {
    
    private var user: User
    private var collectionView: UICollectionView?
    private var productViewModels: [HomeFeedCellType] = []
    private var headerViewModel: profileHeaderViewModel?
    private var currentCart: [String] = []
    private var currentCartItems: [Item] = []
    private let spinner = JGProgressHUD(style: .dark)
    
    private var validShipping = true
    private var address1 = ""
    private var address2 = ""
    private var city = ""
    private var zip = ""
    private var state = ""
    private var country = ""
    private var orderTotal = 0
    private var selectedSizes: [(product: String, size: String)] = []
    
    private let notSignedInlabel: UILabel = {
        let label = UILabel()
        label.text = "not signed in"
        label.textColor = .label
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.isHidden = true
        label.isAccessibilityElement = true
        label.accessibilityValue = "not signed in"
        label.accessibilityHint = "text that tells you you are not signed in"
        return label
    }()
    
    private let notSignedInInfolabel: UILabel = {
        let label = UILabel()
        label.text = "please sign in to purchase items"
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .thin)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.isHidden = true
        label.isAccessibilityElement = true
        label.accessibilityValue = "please sign in to purchase items"
        label.accessibilityHint = "text that tells you to tap below this text on the sign in button "
        return label
    }()
    
    private let SignInLabel: UILabel = {
        let label = UILabel()
        label.text = "SIGN IN HERE"
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.isHidden = true
        label.isAccessibilityElement = true
        label.accessibilityValue = "tap here to sign in"
        label.accessibilityHint = "tap here to sign in"
        return label
    }()
    
    
    let childVC = MusicInfoViewController()
    
    private var isAdmin: Bool {
        return user.email.lowercased() == "pablosportal6@gmail.com"
    }
    
    //MARK: init
     
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: view life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        configureNavBar()
        configureCollectionView()
        fetchProfileInfo()
        HapticsManager.shared.prepareHaptics()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let childHeight = view.height/11
        collectionView?.frame = view.bounds
        childVC.view.frame = CGRect(x: 10, y: self.view.height - childHeight - self.view.safeAreaInsets.bottom - 10, width: self.view.width - 20, height: childHeight)
        childVC.view.layer.cornerRadius = 8
        childVC.view.layer.masksToBounds = true
        
        //not sign in views
        let notSignedInlabelHeight: CGFloat = 35
        let infoLabelHeight: CGFloat = 30
        notSignedInlabel.frame = CGRect(x: 20, y: (view.height - notSignedInlabelHeight - infoLabelHeight - 55)/2, width: view.width - 40, height: notSignedInlabelHeight)
        notSignedInInfolabel.frame = CGRect(x: 20, y: notSignedInlabel.bottom, width: view.width - 40, height: infoLabelHeight)
        SignInLabel.frame = CGRect(x: (view.width - 170)/2, y: notSignedInInfolabel.bottom + 15, width: 170, height: 40)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        infoManager.shared.isHomeViewControllerNotCurrent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        infoManager.shared.isHomeViewControllerNotCurrent = false
    }
    
    //MARK: set up
    
    private func initialSetUp() {
        title = "CHECKOUT"
        view.backgroundColor = .systemBackground
        view.addSubview(notSignedInlabel)
        view.addSubview(notSignedInInfolabel)
        view.addSubview(SignInLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSignIn))
        SignInLabel.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeCartFromHome), name: NSNotification.Name("cartChangeFromHome"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeMusic), name: NSNotification.Name("didChangeMusic"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didPurchase), name: NSNotification.Name("didPurchase"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeSignIn), name: NSNotification.Name("didChangeSignIn"), object: nil)
        
        addChild(childVC)
        view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
        childVC.view.alpha = 0
        childVC.view.isUserInteractionEnabled = false
        childVC.delegate = self
    }
    
    private func configureNavBar() {
        // to check if admin
        if isAdmin {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "sign out", style: .done, target: self, action: #selector(didTapSignOut))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        }
    }
    
    //MARK: profile info, and grab current cart
    
    @objc func fetchProfileInfo() {
        if infoManager.shared.isSignedIn {
            guard let currentEmail = UserDefaults.standard.string(forKey: "email") else {return}
            
            DatabaseManager.shared.getUserInfo(email: currentEmail, completion: {
                [weak self] info in
                self?.validShipping = true
                guard let shippingInfo = info else {return}
                if shippingInfo.address == "" {
                    self?.validShipping = false
                }
                if shippingInfo.city == "" {
                    self?.validShipping = false
                }
                if shippingInfo.state == "" {
                    self?.validShipping = false
                }
                if shippingInfo.country == "" {
                    self?.validShipping = false
                }
                if shippingInfo.postalCode == "" {
                    self?.validShipping = false
                }
                
                self?.address1 = shippingInfo.address
                self?.address2 = shippingInfo.adressLine2
                self?.state = shippingInfo.state
                self?.city = shippingInfo.city
                self?.zip = shippingInfo.postalCode
                self?.country = shippingInfo.country
                
            })
            
            currentCart = infoManager.shared.currentCart
            
            let group = DispatchGroup()
            
            var fetchedCartItems: [Item] = []
            
            for item in currentCart {
                group.enter()
                DatabaseManager.shared.getItem(item: item, completion: {
                    fetchItem in
                    guard let fetchedItem = fetchItem else {
                        group.leave()
                        return
                    }
                    fetchedCartItems.append(fetchedItem)
                    group.leave()
                })
            }
            
            group.notify(queue: .main, execute: { [weak self] in
                var total = 0
                self?.currentCartItems = []
                self?.currentCartItems = fetchedCartItems
                for item in fetchedCartItems {
                    guard let price = Int(item.price) else {return}
                    total += price
                }
                
                self?.orderTotal = total
                
                if fetchedCartItems.count == 0 {
                    self?.headerViewModel = profileHeaderViewModel(email: currentEmail, itemsInCart: fetchedCartItems.count, checkoutString: "no items in cart")
                } else if fetchedCartItems.count == 1 {
                    self?.headerViewModel = profileHeaderViewModel(email: currentEmail, itemsInCart: fetchedCartItems.count, checkoutString: "\(fetchedCartItems.count) item in cart:  total \(total).00$")
                } else {
                    self?.headerViewModel = profileHeaderViewModel(email: currentEmail, itemsInCart: fetchedCartItems.count, checkoutString: "\(fetchedCartItems.count) cart items:  total \(total).00$")
                }
                
            
                self?.configureItems()
            })
            
        } else {
            collectionView?.isHidden = true
            notSignedInlabel.isHidden = false
            notSignedInInfolabel.isHidden = false
            SignInLabel.isHidden = false
            SignInLabel.isUserInteractionEnabled = true
            
        }
        
        
    }
    
    //MARK: configure items
    
    private func configureItems() {
        let dispatchGroup = DispatchGroup()
        
        productViewModels.removeAll()
        
        for item in currentCartItems {
            dispatchGroup.enter()
            
            let productData: [HomeFeedCellType] = [
                .productTitle(viewModel: ProductTitleCollectionViewCellViewModel(title: item.itemName)),
                .MultiImageViewCell(viewModel: MultiImageViewCellViewModel(urlCount: item.urlCount, urls: item.urls, item: item)),
                .pageTurner(viewModel: PageTurnerViewModel(urlCount: item.urlCount)),
                .price(viewModel: PriceCollectionViewCellViewModel(price: item.price)),
                .selectSize(viewModel: SelectSizeViewModel(item: item)),
                .remove(viewModel: removeItemCollectionViewCellViewModel(item: item))
                ]
            
            productViewModels += productData
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main, execute: { [weak self] in
            self?.collectionView?.reloadData()
        })
        
    }
    
    
    //MARK: sign in/ sihn out functions
    
    @objc func didTapSignIn() {
        let vc = SignInViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didChangeSignIn() {
        if infoManager.shared.isSignedIn {
            selectedSizes.removeAll()
            collectionView?.isHidden = false
            notSignedInlabel.isHidden = true
            notSignedInInfolabel.isHidden = true
            SignInLabel.isHidden = true
            SignInLabel.isUserInteractionEnabled = false
            let timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(fetchInfo), userInfo: nil, repeats: false)
        } else {
            productViewModels.removeAll()
            currentCartItems.removeAll()
            selectedSizes.removeAll()
            currentCart.removeAll()
            collectionView?.isHidden = true
            notSignedInlabel.isHidden = false
            notSignedInInfolabel.isHidden = false
            SignInLabel.isHidden = false
            SignInLabel.isUserInteractionEnabled = true
        }
    }
    
    @objc func didTapSignOut() {
        AuthManager.shared.signOut {
            success in
            if success {
                DispatchQueue.main.async {
                    infoManager.shared.isSignedIn = false
                    infoManager.shared.currentCart.removeAll()
                    UserDefaults.standard.setValue("", forKey: "email")
                    NotificationCenter.default.post(name: Notification.Name("didChangeSignIn"), object: nil)
                }
            } else {
                print("failed to sign out")
            }
        }
    }
    
    //MARK: other functions
    
    @objc func didTapSettings() {
        let vc = SettingsViewController()
        present(UINavigationController(rootViewController: vc), animated: true)
        
    }
    
    @objc func didTapAdd() {
        let vc = adminPasswordViewController()
        present(UINavigationController(rootViewController: vc), animated: true)
        
    }
    
    @objc func didChangeCartFromHome() {
        fetchProfileInfo()
    }
    
    @objc func didPurchase() {
        fetchProfileInfo()
    }
    
    @objc func fetchInfo() {
        fetchProfileInfo()
    }
    
    
    
    //MARK: music functions
    
    @objc func closeMusicInfo() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, animations: {
                self.childVC.view.alpha = 0
            })
        }
        childVC.view.isUserInteractionEnabled = false
        childVC.closeImage.isUserInteractionEnabled = false
        
    }
    
    @objc func didChangeMusic() {
        if infoManager.shared.playingFirstSong {
            childVC.songName.text = "electric relaxation (cover)"
        } else {
            childVC.songName.text = "montego bay"
        }
        UIView.animate(withDuration: 0.4, animations: {
            self.view.bringSubviewToFront(self.childVC.view)
            self.childVC.view.alpha = 1
        })
        
        childVC.view.isUserInteractionEnabled = true
        childVC.closeImage.isUserInteractionEnabled = true
        
        let _ = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(closeMusicInfo), userInfo: nil, repeats: false)
    }


}

//MARK: collection view

extension ProfileViewController {
func configureCollectionView() {
    let sectionHeight: CGFloat = 220 + view.width
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: {
        index, _ -> NSCollectionLayoutSection? in
        
        //items
        
        let productTitleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        )
        
        let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
        
        let pageIndicatorItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20)))
        
        let priceItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)))
        
        let sizeItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)))
        
        let removeItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)))
        

        //group
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(sectionHeight)), subitems: [productTitleItem, productItem, pageIndicatorItem, priceItem, sizeItem, removeItem]
        )
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
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
    collectionView.register(RemoveItemFromCartCollectionViewCell.self, forCellWithReuseIdentifier: RemoveItemFromCartCollectionViewCell.identifier)
    collectionView.register(SelectSizeCollectionViewCell.self, forCellWithReuseIdentifier: SelectSizeCollectionViewCell.identifier)
    collectionView.register(ProfileHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeaderCollectionReusableView.identifier)
    self.collectionView = collectionView
}
    
}

//MARK: collection view functions

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productViewModels.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = productViewModels[indexPath.row]
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
            cell.configure(with: viewModel)
            return cell
        case .pageTurner(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageTurnerCollectionViewCell.identifier, for: indexPath) as? PageTurnerCollectionViewCell else {
                fatalError()
            }
            
            cell.configure(with: viewModel)
            return cell
        case .remove(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RemoveItemFromCartCollectionViewCell.identifier, for: indexPath) as? RemoveItemFromCartCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            cell.delegate = self
            return cell
        case .selectSize(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectSizeCollectionViewCell.identifier, for: indexPath) as? SelectSizeCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel)
            cell.delegate = self
            return cell
        
        }
        
        
        
    
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //set up profile header
        
        guard kind == UICollectionView.elementKindSectionHeader, let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeaderCollectionReusableView.identifier, for: indexPath) as? ProfileHeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        if let viewModel = headerViewModel {
            headerView.configure(with: viewModel)
        }
        headerView.delegate = self
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
        
        if cell.reuseIdentifier == RemoveItemFromCartCollectionViewCell.identifier {
            guard let cell = cell as? RemoveItemFromCartCollectionViewCell else {return}
            cell.index = indexPath.row
            
        }
     
        if cell.reuseIdentifier == MultiImageCollectionViewCell.identifier {
            guard let cell = cell as? MultiImageCollectionViewCell else {return}
            cell.index = indexPath.row
            print(indexPath)
            
        }
        
    }

}

//MARK: multi image view functions

extension ProfileViewController: MultiImageViewDelegate {
    func MultiImageViewDelegateDidScroll(_ cell: MultiImageCollectionViewCell, page: Int, index: Int) {
            let pageIndex = IndexPath(row: index + 1, section: 0)
            guard let pageCell = collectionView?.cellForItem(at: pageIndex) as? PageTurnerCollectionViewCell else { return }
            pageCell.pageTurner.currentPage = page
    }
    
    func MultiImageViewDelegateDidTapInfo(_ cell: MultiImageCollectionViewCell, index: Int) {
        print("does nothing")

    }
    
    
}

//MARK: profile header functions

extension ProfileViewController: profileHeaderCollectionReusableViewDelegate {
    func profileHeaderDidTapUpdateShipping(_ cell: ProfileHeaderCollectionReusableView) {
        let vc = UpdateShippingViewController()
        vc.completion = { [weak self] in
            self?.fetchProfileInfo()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapCheckout(_ cell: ProfileHeaderCollectionReusableView) {
        guard validShipping == true else {
            let ac = UIAlertController(title: "looks like shipping needs to be updated", message: "please update shipping before checkout", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            DispatchQueue.main.async { [weak self] in
                self?.present(ac, animated: true, completion: nil)
            }
            return
        }
        
        guard selectedSizes.count == currentCartItems.count else {
            let ac = UIAlertController(title: "size not selected for 1 or more items", message: "please select a size for every item", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            DispatchQueue.main.async { [weak self] in
                self?.present(ac, animated: true, completion: nil)
            }
            return
        }
        
        let vc = ConfirmOrderViewController(addressLine1: self.address1, addressLine2: self.address2, cityName: self.city, state: self.state, zip: self.zip, country: self.country, totalCost: self.orderTotal, itemsToPurchase: self.currentCartItems, sizes: self.selectedSizes)
        HapticsManager.shared.hapticSuccess()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

//MARK: remove item from cart

extension ProfileViewController: RemoveItemFromCartCollectionViewCellDelegate {
    func RemoveItemFromCartCellDelegate(_ cell: RemoveItemFromCartCollectionViewCell, item: Item, index: Int) {
        HapticsManager.shared.buttonHaptic()
        let ac = UIAlertController(title: "are you sure you want to remove this from your cart?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "yes", style: .default, handler: { [weak self] _ in
            guard let vw = self?.view else {return}
            self?.spinner.show(in: vw)
            
            guard let email = UserDefaults.standard.string(forKey: "email") else {return}
            
            DatabaseManager.shared.removeItemFromCart(email: email, item: item.productId, completion: {
                [weak self] success in
                if success {
                    guard let strongSelf = self else {return}
                    infoManager.shared.currentCart.removeAll(where: { ($0.contains(item.productId))})
                    strongSelf.selectedSizes.removeAll(where:{ $0.product == item.productId })
                    print(strongSelf.selectedSizes)
                    self?.fetchProfileInfo()
                    NotificationCenter.default.post(name: Notification.Name("cartChangeFromProfile"), object: nil)
                    self?.spinner.dismiss()
                } else {
                    self?.spinner.dismiss()
                    let ac = UIAlertController(title: "unable to update cart at the moment", message: "try again later", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                    DispatchQueue.main.async {
                        self?.present(ac, animated: true, completion: nil)
                    }
                }
            })
            
            
        }))
        ac.addAction(UIAlertAction(title: "no", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(ac, animated: true)
        }
    }
    
    
}

//MARK: music info

extension ProfileViewController: MusicInfoViewDelegate {
    func MusicInfoViewDelegateDidTapClose(_ musicInfoView: MusicInfoViewController) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, animations: {
                self.childVC.view.alpha = 0
            })
        }
        childVC.view.isUserInteractionEnabled = false
        childVC.closeImage.isUserInteractionEnabled = false
    }
    
    
}

//MARK: selecting sizes

extension ProfileViewController: SelectSizeCollectionViewCellDelegate {
    func SelectSizeDidTapSmall(_ cell: SelectSizeCollectionViewCell, item: Item) {
        print("did tap small")
        HapticsManager.shared.buttonHaptic()
        selectedSizes.removeAll(where:{ $0.product == item.productId })
        selectedSizes.append((product: item.productId, size: "small"))
        print(selectedSizes)
        
    }
    
    func SelectSizeDidTapMedium(_ cell: SelectSizeCollectionViewCell, item: Item) {
        print("did tap medium")
        HapticsManager.shared.buttonHaptic()
        selectedSizes.removeAll(where:{ $0.product == item.productId })
        selectedSizes.append((product: item.productId, size: "medium"))
        print(selectedSizes)
    }
    
    func SelectSizeDidTapLarge(_ cell: SelectSizeCollectionViewCell, item: Item) {
        print("did tap large")
        HapticsManager.shared.buttonHaptic()
        selectedSizes.removeAll(where:{ $0.product == item.productId })
        selectedSizes.append((product: item.productId, size: "large"))
        print(selectedSizes)
    }
    
    func SelectSizeDidTapCustom(_ cell: SelectSizeCollectionViewCell, item: Item) {
        print("did tap custom")
        HapticsManager.shared.buttonHaptic()
        selectedSizes.removeAll(where:{ $0.product == item.productId })
        guard let custom = item.customSize else {return}
        selectedSizes.append((product: item.productId, size: custom))
        print(selectedSizes)
    }
    
    
}

