class ViewController: UIViewController {
    @IBOutlet weak var contentView: DrawingCanvas!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var widthButton: UIButton!
    @IBOutlet weak var alphaButton: UIButton!
    @IBOutlet weak var modeButton: RoundedButton!

    @IBAction func colorButtonAction(_ sender: UIButton) {
        let elements: [NamedColor] = [.black, .red, .blue]
        guard let idx = elements.firstIndex(of: self.contentView.color) else {
            return
        }
        let next = (idx + 1) % elements.count
        self.contentView.color = elements[next]
        apply()
    }

    @IBAction func widthButtonAction(_ sender: UIButton) {
        let elements: [CGFloat] = [10, 20, 30, 40, 50]
        guard let idx = elements.firstIndex(of: self.contentView.width) else {
            return
        }
        let next = (idx + 1) % elements.count
        self.contentView.width = elements[next]
        apply()
    }

    @IBAction func clearButtonAction(_ sender: UIButton) {
        contentView.clear()
    }

    @IBAction func alphaButtonAction(_ sender: UIButton) {
        let elements: [CGFloat] = [1, 0.25, 0]
        guard let idx = elements.firstIndex(of: self.contentView.strokeAlpha) else {
            return
        }
        let next = (idx + 1) % elements.count
        self.contentView.strokeAlpha = elements[next]
        apply()
    }

    @IBAction func modeButtonAction(_ sender: UIButton) {
        let all = DrawingCanvas.Mode.allCases
        guard let idx = all.firstIndex(of: self.contentView.mode) else {
            return
        }
        let next = (idx + 1) % all.count
        self.contentView.mode = all[next]
        apply()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.apply()
    }

    private func apply() {
        self.alphaButton.setTitle("alpha:\(contentView.strokeAlpha)", for: .normal)
        self.widthButton.setTitle("width:\(contentView.width)", for: .normal)
        self.colorButton.setTitle("color:\(contentView.color.name)", for: .normal)
        self.modeButton.setTitle("mode:\(contentView.mode)", for: .normal)
    }
}


extension ViewController : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
