import UIKit

protocol XlocButtonDelegate: AnyObject {
    func didTouchButton()
}

final class XlocButton: UIButton {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func configureLayout() {
        titleLabel?.font = UIFont(name: "HelveticaNeue-Bold" , size: 14)
        setTitleColor(.yellow, for: .normal)
        setTitleColor(.systemGray, for: .highlighted)
        backgroundColor = .clear
        layer.cornerRadius = 4
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        showsTouchWhenHighlighted = true
    }
}
