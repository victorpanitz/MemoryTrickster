import UIKit

protocol MemoryTricksterViewDelegate: AnyObject {
    func didTouchMemoryModifierButton(_ modifier: MemoryModifier)
    func didTriggerQuickActions()
}

final class MemoryTricksterView: UIView {
    private lazy var baseStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var topStack: UIStackView = {
        let stack = UIStackView()
        let backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        stack.customize(color: backgroundColor, radius: 8)
        stack.axis = .horizontal
        stack.layer.cornerRadius = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var memoryExhibitionStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.preservesSuperviewLayoutMargins = true
        return stack
    }()
    
    private lazy var usedMemoryStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var freeMemoryStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var usedMemoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.usedMT
        label.font = UIFont(name: "HelveticaNeue-Bold" , size: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var freeMemoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.freeMT
        label.font = UIFont(name: "HelveticaNeue-Bold" , size: 16)
        label.textColor = .white
        return label
    }()
    
    lazy var usedMemorySizeLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.defaultMV
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue" , size: 14)
        return label
    }()
    
    lazy var freeMemorySizeLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.defaultMV
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue" , size: 14)
        return label
    }()
        
    private lazy var memoryStepperStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 4
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.preservesSuperviewLayoutMargins = true
        return stack
    }()
    
    // Bottom stack
    
    private lazy var bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 4
        stack.layoutMargins = UIEdgeInsets(top: 4, left: 0, bottom: 8, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.preservesSuperviewLayoutMargins = true
        return stack
    }()
    
    private lazy var segmentedControlStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 4
        return stack
    }()
        
    private lazy var magnitudeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.backgroundColor = UIColor.systemGray.withAlphaComponent(0.8)
        segmentedControl.insertSegment(withTitle: MemoryMagnitude.bytes.shortName, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: MemoryMagnitude.kiloBytes.shortName, at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: MemoryMagnitude.megaBytes.shortName, at: 2, animated: true)
        segmentedControl.selectedSegmentIndex = 1
        return segmentedControl
    }()
    
    private lazy var multiplierSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.backgroundColor = UIColor.systemGray.withAlphaComponent(0.8)
        segmentedControl.insertSegment(withTitle: MemoryMultiplier.one.shortName, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: MemoryMultiplier.ten.shortName, at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: MemoryMultiplier.hundred.shortName, at: 2, animated: true)
        segmentedControl.selectedSegmentIndex = 1
        return segmentedControl
    }()
    
    private lazy var incrementButton: XlocButton = {
        let button = XlocButton()
        button.setTitle(Strings.alloc, for: .normal)
        button.addTarget(self, action: #selector(incrementButtonTouched), for: .touchUpInside)
        return button
    }()
    
    private lazy var decrementButton: XlocButton = {
        let button = XlocButton()
        button.setTitle(Strings.dealloc, for: .normal)
        button.addTarget(self, action: #selector(decrementButtonTouched), for: .touchUpInside)
        return button
    }()
    
    private lazy var injectedMemoryStack: UIStackView = {
        let stack = UIStackView()
        let backgroundColor = UIColor.green.withAlphaComponent(0.8)
        stack.customize(color: backgroundColor, radius: 8)
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.backgroundColor = .green
        return stack
    }()
    
    private lazy var injectedMemoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.injectedMT
        label.font = UIFont(name: "HelveticaNeue-Bold" , size: 16)
        label.textColor = .black
        return label
    }()
    
    lazy var injectedMemorySizeLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.defaultMV
        label.textColor = .black
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue" , size: 14)
        return label
    }()

    private var panGesture = UIPanGestureRecognizer()
    private var longPressGesture = UILongPressGestureRecognizer()
    
    private let generator = UIImpactFeedbackGenerator(style: .light)
            
    weak var delegate: MemoryTricksterViewDelegate?
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .clear
        layer.cornerRadius = 8
        
        configureFrame()
        configureGesture()
        configureStacks()
        
        baseStack.frame = bounds
        addSubview(baseStack)
    }
    
    private func configureFrame() {
        let deviceWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        let componentWidth = deviceWidth * 0.8
        let verticalOffset: CGFloat = 60
        
        frame = CGRect(
            x: (deviceWidth - componentWidth) / 2,
            y: verticalOffset,
            width: componentWidth,
            height: componentWidth * 0.4
        )
    }

    private func configureGesture() {
        panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(dragViewTriggered(_:))
        )

        longPressGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(quickActionsTriggered)
        )
        
        isUserInteractionEnabled = true
        addGestureRecognizer(panGesture)
        injectedMemoryStack.addGestureRecognizer(longPressGesture)
    }
    
    private func configureStacks() {
        configureSegmentedControlStack()
        configureInjectedMemoryStack()
        configureBottomStack()
        configureBaseStack()
        configuraMemoryStepperStack()
        configureUsedMemoryStack()
        configureFreeMemoryStack()
        configureMemoryExhibitionStack()
        configureTopStack()
    }
    
    private func configureBaseStack() {
        baseStack.addArrangedSubview(topStack)
        baseStack.addArrangedSubview(bottomStack)
    }
    
    private func configureSegmentedControlStack() {
        segmentedControlStack.addArrangedSubview(magnitudeSegmentedControl)
        segmentedControlStack.addArrangedSubview(multiplierSegmentedControl)
    }
    
    private func configureBottomStack() {
        bottomStack.addArrangedSubview(injectedMemoryStack)
        bottomStack.addArrangedSubview(segmentedControlStack)
    }
    
    private func configureInjectedMemoryStack() {
        injectedMemoryStack.addArrangedSubview(injectedMemoryTitleLabel)
        injectedMemoryStack.addArrangedSubview(injectedMemorySizeLabel)
    }
    
    private func configureTopStack() {
        topStack.addArrangedSubview(memoryExhibitionStack)
        topStack.addArrangedSubview(memoryStepperStack)
    }
    
    private func configuraMemoryStepperStack() {
        memoryStepperStack.addArrangedSubview(decrementButton)
        memoryStepperStack.addArrangedSubview(incrementButton)
    }
    
    private func configureUsedMemoryStack() {
        usedMemoryStack.addArrangedSubview(usedMemoryTitleLabel)
        usedMemoryStack.addArrangedSubview(usedMemorySizeLabel)
    }
    
    private func configureFreeMemoryStack() {
        freeMemoryStack.addArrangedSubview(freeMemoryTitleLabel)
        freeMemoryStack.addArrangedSubview(freeMemorySizeLabel)
    }
    
    private func configureMemoryExhibitionStack() {
        memoryExhibitionStack.addArrangedSubview(usedMemoryStack)
        memoryExhibitionStack.addArrangedSubview(freeMemoryStack)
    }
    
    @objc private func quickActionsTriggered() {
        generator.impactOccurred()
        delegate?.didTriggerQuickActions()
    }
    
    @objc private func dragViewTriggered(_ sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: self)
        self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
    }
    
    @objc private func decrementButtonTouched() {
        generator.impactOccurred()
        
        let magnitudeIndex = magnitudeSegmentedControl.selectedSegmentIndex
        let magnitude = MemoryMagnitude.allCases[magnitudeIndex]
        
        let multiplierIndex = multiplierSegmentedControl.selectedSegmentIndex
        let multiplier = MemoryMultiplier.allCases[multiplierIndex]
        
        let modifier = MemoryModifier(action: .dealloc, magnitude: magnitude, multiplier: multiplier)
        
        delegate?.didTouchMemoryModifierButton(modifier)
    }
    
    @objc private func incrementButtonTouched() {
        generator.impactOccurred()
        
        let magnitudeIndex = magnitudeSegmentedControl.selectedSegmentIndex
        let magnitude = MemoryMagnitude.allCases[magnitudeIndex]
        
        let multiplierIndex = multiplierSegmentedControl.selectedSegmentIndex
        let multiplier = MemoryMultiplier.allCases[multiplierIndex]
        
        let modifier = MemoryModifier(action: .alloc, magnitude: magnitude, multiplier: multiplier)
        
        delegate?.didTouchMemoryModifierButton(modifier)
    }
}
