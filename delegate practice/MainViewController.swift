//
//  MainViewController.swift
//  delegate practice
//
//  Created by Jube on 2022/12/17.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var avatarPhoto: UIButton!
    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeAvatarPhoto(_ sender: UIButton) {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let options = ["從相簿中選取","從相機拍攝"]
        for option in options {
            let action = UIAlertAction(title: option, style: .default) { action in
                let imagePickerController = UIImagePickerController()
                if option == "從相簿中選取" {
                    imagePickerController.sourceType = .photoLibrary
                    
                } else {
                    imagePickerController.sourceType = .camera
                }
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true)
            }
            controller.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true)
    }
    
    @IBAction func chooseColor(_ sender: Any) {
        let controller = UIColorPickerViewController()
        controller.delegate = self
        present(controller, animated: true)
    }
    
    @IBAction func chooseFont(_ sender: Any) {
        let config = UIFontPickerViewController.Configuration()
        config.includeFaces = true
        let controller = UIFontPickerViewController(configuration: config)
        controller.delegate = self
        present(controller, animated: true)
    }
    
    
    @IBAction func tapToCloseKeyBoard(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @IBAction func exitKeyboard(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        avatarPhoto.configuration?.background.image = info[.originalImage] as! UIImage
        dismiss(animated: true)
    }
}

extension MainViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        avatarPhoto.configuration?.background.strokeColor = color
    }
}

extension MainViewController: UIFontPickerViewControllerDelegate {
    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        if let selectedFontDescriptor = viewController.selectedFontDescriptor {
            name.font = UIFont(descriptor: selectedFontDescriptor, size: 20)
        }
        dismiss(animated: true)
    }
}
