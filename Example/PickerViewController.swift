class PickerViewController<T> : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate where T : Equatable {
    let elements: [T]
    private let initialSelect: T

    init(elements: [T], select: T) {
        self.elements = elements
        self.initialSelect = select
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let v = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 400))
        v.dataSource = self
        v.delegate = self
        if let idx = self.elements.firstIndex(of: self.initialSelect) {
            v.selectRow(idx, inComponent: 0, animated: true)
        }
        self.view = v
    }

    //MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.elements.count
        } else {
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard component == 0 else {
            return nil
        }
        if 0 <= row && row < elements.count {
            return "\(elements[row])"
        } else {
            return nil
        }
    }

    //MARK: - UIPickerViewDelegate

    var onSelect: ((T) -> Void)? = nil

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard component == 0 else {
            return
        }
        if 0 <= row && row < elements.count {
            onSelect?(elements[row])
        }
    }
}
