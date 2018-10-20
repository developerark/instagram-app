//
//  PhotoSelectorController.swift
//  instagram-app
//
//  Created by Aswin Raj Kharel on 9/29/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectorController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellID = "cellID"
    let headerID = "headerID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: self.cellID)
        self.collectionView?.register(PhotoSelectorHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.headerID)
        setupNavigationButtons()
        
        fetchPhotos()
    }
    
    var images = [UIImage]()
    var assets = [PHAsset]()
    fileprivate func assetFetchOptions() -> PHFetchOptions{
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 100
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        return fetchOptions
    }
    
    fileprivate func fetchPhotos(){
        let allPhotos = PHAsset.fetchAssets(with: .image, options: self.assetFetchOptions())
        // Making the fetch process faster using the global dispatcher
        DispatchQueue.global(qos: .background).async {
            allPhotos.enumerateObjects { (asset, count, stop) in
                let imageManager = PHImageManager.default()
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    if let image = image{
                        self.images.append(image)
                        self.assets.append(asset)
                        if self.selectedImage == nil{
                            self.selectedImage = image
                        }
                    }
                    // count starts with zero
                    if count == allPhotos.count - 1{
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    }
                })
            }
        }
    }

    // Sizing for cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }
    // Horizontal Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //vertical Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    var selectedImage: UIImage?
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImage = images[indexPath.item]
        self.collectionView?.reloadData()
        let indexPath = IndexPath(item: 0, section: 0)
        self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    // Rendering the Header
    // Register a new header
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.width)
    }
    
    // Referencing the header to pass on to the SharePhotoController
    var header: PhotoSelectorHeader?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.headerID, for: indexPath) as! PhotoSelectorHeader
        self.header = header
        header.photoImageView.image = self.selectedImage
        
        // Fetch the high res image for the selected image
        let imageManager = PHImageManager.default()
        if let selectedImage = self.selectedImage{
            if let index = self.images.index(of: selectedImage){
                let selectedAsset = self.assets[index]
                imageManager.requestImage(for: selectedAsset, targetSize: CGSize(width: 600, height: 600), contentMode: .aspectFit, options: nil) { (image, info) in
                    header.photoImageView.image = image

                }
            }
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! PhotoSelectorCell
        cell.photoImageView.image = self.images[indexPath.item]
        return cell
    }
    fileprivate func setupNavigationButtons(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancle", style: .plain, target: self, action: #selector(cancleButtonPressed(sender:)))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonPressed(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func cancleButtonPressed(sender: UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func nextButtonPressed(sender: UIBarButtonItem){
        let sharePhotoController = SharePhotoController()
        sharePhotoController.image = header?.photoImageView.image
        self.navigationController?.pushViewController(sharePhotoController, animated: true)
    }
}
