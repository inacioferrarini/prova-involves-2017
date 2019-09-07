//    The MIT License (MIT)
//
//    Copyright (c) 2017 Inácio Ferrarini
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

import UIKit
import Glasgow

class AppContext {

    
    // MARK: - Structure
    
    lazy var coreDataStack: CoreDataStack = {
        let modelFileName = "SeriesManager"
        let databaseFileName = "SeriesManagerDB"
        let bundle = Bundle(for: type(of: self))
        return CoreDataStack(modelFileName: modelFileName, databaseFileName: databaseFileName, bundle: bundle)
    }()

    lazy var apis: APIs = {
        return APIs()
    }()

    
    // MARK: - Authentication
    
    lazy var clientID: String = {
        return "31724f34d9aff46308675002de903f1863c592c8998384b44220c8843570f734"
    }()
    
    lazy var clientSecret: String = {
        return "03e17c5a351815e13db432818dcc2a59281a3c7dc60c883a2cfc4015381e54e3"
    }()
    
    var deviceCode: DeviceCode?
    var token: Token?
    var profile: Profile?
    
    var authenticationFlowViewController: UIViewController?
    
    
    // MARK: - App Internal State
    
    var selectedSerie: Serie?
    
}
