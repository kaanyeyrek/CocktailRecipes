//
//  AddNewRecipeViewController.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/10/22.
//

import UIKit
import ProgressHUD

protocol AddNewRecipeViewInterface: AnyObject {
    func setUI()
    func setSubviews()
    func setLayout()
    var titleText: String? { get }
    var ingredientsText: String? { get }
    var selectedButtonImage: Data? { get }
    var descriptionText: String? { get }
    func setActions()
    func setAlert()
    func tabBarSelectedIndex(_ index: Int)
    func showProgressHUD()
    func setImagePicker()
}

final class AddNewRecipeViewController: UIViewController {
    private lazy var viewModel: AddNewRecipesViewModelInterface = AddNewRecipesViewModel(view: self)
    private let image = CustomImageView()
    private let selectImage = CustomButton(title: "Select Cocktail Image")
    private let titleTextField = CustomTextField(placeHolder: "Add Cocktail Title...", padding: 10)
    private let ingredientsField = CustomTextField(placeHolder: "Add Cocktail Ingredients...", padding: 10)
    private let descriptionField = CustomTextField(placeHolder: "Add Cocktail Descriptions...", padding: 10)
    private let addButton = CustomButton(title: "Add Cocktail")
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}
extension AddNewRecipeViewController: AddNewRecipeViewInterface {
    func setUI() {
        view.backgroundColor = .white
        image.image = #imageLiteral(resourceName: "banner3")
        selectImage.backgroundColor = .white
        selectImage.setTitleColor(.black, for: .normal)
        selectImage.layer.borderWidth = 1
        selectImage.layer.borderColor = UIColor.black.cgColor
    }
    func setSubviews() {
        view.addSubview(image)
        view.addSubview(titleTextField)
        view.addSubview(ingredientsField)
        view.addSubview(descriptionField)
        view.addSubview(addButton)
        view.addSubview(selectImage)
    }
    func setActions() {
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        selectImage.addTarget(self, action: #selector(didTapSelectImageButton), for: .touchUpInside)
    }
    func setImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
//MARK: - @objc target methods
    @objc private func didTapAddButton(with button: UIButton) {
        viewModel.didTapAddButton()
    }
    @objc private func didTapSelectImageButton(with button: UIButton) {
        viewModel.didTapSelectImageButton()
    }
    func setAlert() {
        self.alert(message: "You need to fill in all fields.", title: "Failed!")
    }
    func setLayout() {
        image.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 330))
        titleTextField.anchor(top: image.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 10, right: 20), size: .init(width: view.frame.width, height: 50))
        titleTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -160).isActive = true
        ingredientsField.anchor(top: titleTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 10, right: 20), size: .init(width: view.frame.width, height: 50))
        ingredientsField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -90).isActive = true
        descriptionField.anchor(top: ingredientsField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 10, right: 20), size: .init(width: view.frame.width, height: 90))
        descriptionField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        selectImage.anchor(top: descriptionField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20), size: .init(width: view.frame.width, height: 200))
        selectImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 170).isActive = true
        addButton.anchor(top: selectImage.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 35, right: 20), size: .init(width: view.frame.width, height: 50))
    }
    func tabBarSelectedIndex(_ index: Int) {
        tabBarController?.selectedIndex = index
    }
    func showProgressHUD() {
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.show("Loading...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: ProgressHUD.dismiss)
    }
    var titleText: String? {
        titleTextField.text
    }
    var ingredientsText: String? {
        ingredientsField.text
    }
    var descriptionText: String? {
        descriptionField.text
    }
    var selectedButtonImage: Data? {
        selectImage.currentBackgroundImage?.jpegData(compressionQuality: 1.0)
    }
}
// MARK: - UIImagePicker Delegate
extension AddNewRecipeViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else { return }
        selectImage.setBackgroundImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        selectImage.setTitleColor(.clear, for: .normal)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
