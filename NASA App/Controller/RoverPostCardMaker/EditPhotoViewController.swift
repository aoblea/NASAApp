//
//  EditPhotoViewController.swift
//  NASA App
//
//  Created by Arwin Oblea on 1/3/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import UIKit
import MessageUI // mail framework

class EditPhotoViewController: UIViewController {
  // MARK: - Properties
  
  var photo: Photo?
  
  lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var postCardLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.font = .boldSystemFont(ofSize: 15.0)
    label.textColor = UIColor.red
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var userTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = UIColor.white
    textField.placeholder = "Write a message here"
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  lazy var setPostCardTitle: UIButton = {
    let button = UIButton()
    button.setTitle("Ready", for: .normal)
    button.backgroundColor = UIColor.AppTheme.darkCerulean
    button.addTarget(self, action: #selector(handlePostCardTitle), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  // MARK: - Viewdidload

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupNavBar()
  }
  
  @objc private func handlePostCardTitle() {
    postCardLabel.text = userTextField.text
  }

  private func setupUI() {
    self.title = "Create postcard"
    view.backgroundColor = UIColor.AppTheme.oxfordBlue
    
    view.addSubview(imageView)
    view.addSubview(setPostCardTitle)
    view.addSubview(userTextField)
    
    imageView.addSubview(postCardLabel)
    
    // Constraints
    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: setPostCardTitle.topAnchor),
      
      setPostCardTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      setPostCardTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      setPostCardTitle.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      setPostCardTitle.heightAnchor.constraint(equalToConstant: 50),
      
      postCardLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
      postCardLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 15),
      postCardLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
      postCardLabel.heightAnchor.constraint(equalToConstant: 50),
      
      userTextField.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
      userTextField.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
      userTextField.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8),
      userTextField.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
  
  private func setupNavBar() {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(handleSendEmail))
  }
  
  // If user's device is able to send email, app composes a presetted mail to send.
  @objc private func handleSendEmail() {
    
    if MFMailComposeViewController.canSendMail() {
      let mailVC = MFMailComposeViewController()
      mailVC.mailComposeDelegate = self
      
      mailVC.setToRecipients(["123fakeemail@gmail.com"]) // set recipients email address
      mailVC.setSubject("Postcard from Mars") // set subject of mail
      mailVC.setMessageBody("Hello from Mars!", isHTML: false) // set message
      
      // setup final image to send
      let finalImage = snapshot()
      guard let finalImagePNGData = finalImage?.pngData() else { return self.presentAlert(title: "Mailing Error", message: "Image unable to convert to pngdata.") }
      mailVC.addAttachmentData(finalImagePNGData, mimeType: "finalImage/png", fileName: "finalImage.png")
      
      self.present(mailVC, animated: true, completion: nil)
    } else {
      self.presentAlert(title: "Mailing Error", message: "Unable to send mail.")
    }
  }
  
  // Process the final image to send through mail
  private func snapshot() -> UIImage? {
    UIGraphicsBeginImageContext(imageView.bounds.size)
    imageView.drawHierarchy(in: imageView.bounds, afterScreenUpdates: true)
    postCardLabel.drawHierarchy(in: postCardLabel.frame, afterScreenUpdates: true)
    
    let processedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return processedImage
  }

}

// MARK: - MFMailComposeViewControllerDelegate Methods

extension EditPhotoViewController: MFMailComposeViewControllerDelegate {

  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    dismiss(animated: true, completion: nil)
  }
  
}

// MARK: UITextFieldDelegate Methods

extension EditPhotoViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder() // brings keyboard offscreen
    return true
  }
  
}
