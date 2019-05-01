class ViewController: UIViewController {
    @IBOutlet weak var contentView: DrawingCanvas!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var widthButton: UIButton!
    @IBOutlet weak var alphaButton: UIButton!

    @IBAction func colorButtonAction(_ sender: UIButton) {
        let elements: [NamedColor] = [.black, .red, .blue, .orange, .green, .gray, .darkGray]
        let size = CGSize(width: 100, height: 200)
        let current = self.contentView.color
        self.presentPickerViewController(select: current, elements: elements, size: size, button: sender) { [weak self] (_ v: NamedColor) in
            self?.contentView.color = v
            self?.apply()
        }
    }

    @IBAction func widthButtonAction(_ sender: UIButton) {
        let elements: [CGFloat] = [10, 20, 30, 40, 50]
        let size = CGSize(width: 100, height: 200)
        self.presentPickerViewController(select: self.contentView.width, elements: elements, size: size, button: sender) { [weak self] (_ v: CGFloat) in
            self?.contentView.width = v
            self?.apply()
        }
    }

    @IBAction func clearButtonAction(_ sender: UIButton) {
        contentView.clear()
    }

    @IBAction func alphaButtonAction(_ sender: UIButton) {
        let elements: [CGFloat] = [1, 0.25, 0]
        let size = CGSize(width: 100, height: 200)
        self.presentPickerViewController(select: self.contentView.alpha, elements: elements, size: size, button: sender) { [weak self] (_ v: CGFloat) in
            self?.contentView.strokeAlpha = v
            self?.apply()
        }
    }

    private func presentPickerViewController<T>(select: T, elements: [T], size: CGSize, button: UIButton, changed: @escaping (_ v: T) -> Void) where T : Equatable {
        let picker = PickerViewController<T>(elements: elements, select: select)
        picker.onSelect = changed
        picker.modalPresentationStyle = .popover
        picker.preferredContentSize = size
        picker.popoverPresentationController?.delegate = nil
        picker.popoverPresentationController?.sourceView = button
        picker.popoverPresentationController?.sourceRect = button.bounds
        self.present(picker, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.apply()
    }

    private func apply() {
        self.alphaButton.setTitle("alpha:\(contentView.strokeAlpha)", for: .normal)
        self.widthButton.setTitle("width:\(contentView.width)", for: .normal)
        self.colorButton.setTitle("color:\(contentView.color.name)", for: .normal)
    }
}


extension ViewController : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
