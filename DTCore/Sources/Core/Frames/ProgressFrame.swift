//
//  ProgressFrame.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import UIKit

public class ProgressFrame<T: Numeric>: Frame {

    // MARK: Fields

    private var valueChanged: ((T) -> Void)?

    private var valueModifier: ((T) -> T)?

    // MARK: Properties

    @Bindable(0)
    public var value: T {
        didSet {
            if oldValue != self.value {
                self.valueChanged?(self.value)
            }
        }
    }

    @Bindable(0)
    public var minimum: T

    @Bindable(1)
    public var maximum: T

    @Bindable(true)
    public var enabled: Bool

    // MARK: Init

    public init(
        value: T
    ) {
        super.init()

        self.value = value
    }

    public init(
        value: T,
        minimum: T,
        maximum: T,
        onValueChanged: ((T) -> Void)? = nil,
        valueModifier: ((T) -> T)? = nil
    ) {
        super.init()

        self.value = value
        self.minimum = minimum
        self.maximum = maximum

        self.valueChanged = onValueChanged
        self.valueModifier = valueModifier
    }

    // MARK: Actions

    @objc func onValueChanged(_ sender: UISlider) {
        if let newValue = T(exactly: UInt8(sender.value)) {
            self.value = valueModifier?(newValue) ?? newValue
        }
    }

}
