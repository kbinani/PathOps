class ViewController: UIViewController {
    @IBOutlet weak var contentView: DrawingCanvas!

    @IBAction func colorButtonAction(_ sender: UIButton) {
        let elements = [
            NamedColor(name: "red", color: UIColor.red),
            NamedColor(name: "blue", color: UIColor.blue),
            NamedColor(name: "orange", color: UIColor.orange),
            NamedColor(name: "green", color: UIColor.green),
            NamedColor(name: "gray", color: UIColor.gray),
            NamedColor(name: "darkGray", color: UIColor.darkGray),
        ]
        let size = CGSize(width: 100, height: 200)
        self.presentPickerViewController(elements, size: size, button: sender) { [weak self] (_ v: NamedColor) in
            self?.contentView.color = v.color
        }
    }

    @IBAction func widthButtonAction(_ sender: UIButton) {
        let elements: [CGFloat] = [10, 20, 30, 40, 50]
        let size = CGSize(width: 100, height: 200)
        self.presentPickerViewController(elements, size: size, button: sender) { [weak self] (_ v: CGFloat) in
            self?.contentView.width = v
        }
    }

    @IBAction func clearButtonAction(_ sender: UIButton) {
        contentView.clear()
    }

    @IBAction func alphaButtonAction(_ sender: UIButton) {
        let elements: [CGFloat] = [1, 0.75, 0.5, 0.25, 0]
        let size = CGSize(width: 100, height: 200)
        self.presentPickerViewController(elements, size: size, button: sender) { [weak self] (_ v: CGFloat) in
            self?.contentView.strokeAlpha = v
        }
    }

    private func presentPickerViewController<T>(_ elements: [T], size: CGSize, button: UIButton, changed: @escaping (_ v: T) -> Void) {
        let picker = PickerViewController<T>(elements)
        picker.onSelect = changed
        picker.modalPresentationStyle = .popover
        picker.preferredContentSize = size
        picker.popoverPresentationController?.delegate = nil
        picker.popoverPresentationController?.sourceView = button
        picker.popoverPresentationController?.sourceRect = button.bounds
        self.present(picker, animated: true, completion: nil)
    }
}


extension ViewController : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
