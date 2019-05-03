@IBDesignable
class RoundedButton : UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height * 0.5
        self.clipsToBounds = true
    }
}
