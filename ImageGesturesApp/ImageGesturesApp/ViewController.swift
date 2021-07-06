//
//  ViewController.swift
//  ImageGesturesApp
//
//  Created by DCS on 06/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let myTextView : UITextView = {
        
        let textView = UITextView()
        textView.text = "Please Tap On [+] To Select an Image"
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.font = .boldSystemFont(ofSize: 25)
        textView.isEditable = false
        return textView
    }()
    
   
    private let myImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "add-image")
        imageView.frame = CGRect(x: 110, y: 350, width: 200, height: 200)
        return imageView
    }()
    
    private let imagePicker:UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        return imagePicker
    }()
    
    
    @objc func handleButtonClick(){
        
    }
    override func viewDidLoad() {
        
        self.view.backgroundColor = .black
        title = "Image-Picker&GesturesApp"
        super.viewDidLoad()
        print("run")
        view.addSubview(myImageView)
        view.addSubview(myTextView)
        
        
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
     
        let tapGesture =  UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinchView))
        view.addGestureRecognizer(pinchGesture)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(didRotateView))
        view.addGestureRecognizer(rotationGesture)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanView))
        view.addGestureRecognizer(panGesture)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myTextView.frame = CGRect(x: 50, y: 800, width: 300, height: 200)
    
    }
    
}

extension ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc private func didTapView(_ gesture:UITapGestureRecognizer){
        
        print("tapped at location: \(gesture.location(in: view))")
        print("gallery-called")
        imagePicker.sourceType = .photoLibrary
        DispatchQueue.main.async {
            self.present(self.imagePicker, animated: true)
        }
    }
    
    @objc private func didPinchView(_ gesture:UIPinchGestureRecognizer){
        
        myImageView.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    
    
    @objc private func didRotateView(_ gesture:UIRotationGestureRecognizer){
        
        myImageView.transform = CGAffineTransform(rotationAngle: gesture.rotation)
    }
    
    
    @objc private func didSwipeView(_ gesture:UISwipeGestureRecognizer){
        
        if gesture.direction == .left{
            UIView.animate(withDuration: 0.2, animations: {
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x - 40, y: self.myImageView.frame.origin.y, width: 200, height: 200)
            })
            
        } else if gesture.direction == .right{
            UIView.animate(withDuration: 0.2, animations: {
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x + 40, y: self.myImageView.frame.origin.y, width: 200, height: 200)
            })
            
        } else if gesture.direction == .up {
            UIView.animate(withDuration: 0.2, animations: {
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x, y: self.myImageView.frame.origin.y - 40, width: 200, height: 200)
            })
        } else if gesture.direction == .down{
            UIView.animate(withDuration: 0.2, animations: {
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x, y: self.myImageView.frame.origin.y + 40, width: 200, height: 200)
            })
        } else {
            
            print("Direction Could not be detect")
        }
    }
    
    @objc private func didPanView(_ gesture:UIPanGestureRecognizer){
        
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        
        myImageView.center = CGPoint(x: x, y: y )
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            myImageView.image = selectedImage
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
}

