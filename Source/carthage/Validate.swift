import CarthageKit
import Commandant
import Foundation
import ReactiveSwift
import Result

/// Type that encapsulates the configuration and evaluation of the `validate` subcommand.
public struct ValidateCommand: CommandProtocol {
    public let verb = "validate"
    public let function = "Validate that the versions in Cartfile.resolved are compatible with the Cartfile requirements"

    public func run(_ options: CheckoutCommand.Options) -> Result<(), CarthageError> {
        return options.loadProject(useNetrc: false).flatMap(.merge) { (project: Project) in
            return project.validate()
            }
            .on(value: { _ in
                carthage.printOut("No incompatibilities found in Cartfile.resolved")
            })
            .waitOnCommand()
    }
}
