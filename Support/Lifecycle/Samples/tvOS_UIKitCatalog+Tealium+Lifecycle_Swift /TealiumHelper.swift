//
//  TealiumHelper.swift
//  Blank+Tealium-Swift
//
//  Created by Jason Koo on 11/16/15.
//  Copyright © 2015 Tealium. All rights reserved.
//

/*
*  Using an abstract class like this is the recommended best practice for
*  utilizing analytics or other third party libraries requiring an event
*  trigger with optional data.
*/
import Foundation
import TealiumTVOSLifecycle

let tealiumInstanceID = "1"

class TealiumHelper : NSObject {
    
    static let _sharedInstance = TealiumHelper()
    
    class func sharedInstance() -> TealiumHelper{
        
        return _sharedInstance
    }
    
    class func startTracking() {
        
        if Tealium.instance(forKey: tealiumInstanceID) != nil {
            return
        }
        
        let config = TEALConfiguration.init(account: "tealiummobile", profile: "demo", environment: "dev")
                
        let tealium = Tealium.newInstance(forKey: tealiumInstanceID, configuration: config)
        
        tealium.setDelegate(sharedInstance())
        
        tealium.setLifecycleAutotrackingIsEnabled(true)
        
    }
    
    class func trackType(_ eventType: TEALDispatchType, title: String , dataSources: [String: AnyObject]?, completion: @escaping TEALDispatchBlock) {
        
        Tealium.instance(forKey: tealiumInstanceID)?.trackType(eventType, title: title, dataSources: dataSources!, completion: completion)
        
    }
    
    
    class func trackEvent(_ title: String, dataSources: [String:String]){
        
        Tealium.instance(forKey: tealiumInstanceID)?.trackEvent(withTitle: title, dataSources: dataSources)
        
    }
    
    class func trackView(_ title: String, dataSources: [String:String]){
        
        Tealium.instance(forKey: tealiumInstanceID)?.trackView(withTitle: title, dataSources: dataSources)
        
    }
    
    class func stopTracking(){
        
        Tealium.destroyInstance(forKey: tealiumInstanceID)
        
    }
}

extension TealiumHelper : TealiumDelegate {
    
    func tealium(_ tealium: Tealium!, shouldDrop dispatch: TEALDispatch!) -> Bool {
        
        // Add optional tracking suppression logic here - returning true will destroy
        // any processed dispatch so some conditional must eventually return false
        
        return false
    }
    
    func tealium(_ tealium: Tealium!, shouldQueue dispatch: TEALDispatch!) -> Bool {
        
        // Add optional queuing / saving logic here - returning true will save
        // a dispatch so some condition must eventually return false.
        
        return false
    }
    
    func tealium(_ tealium: Tealium!, didQueue dispatch: TEALDispatch!) {
        
        print("Did queue dispatch: \(dispatch)")
        
        // Add optional code here to respond to queuing of dispatches.

    }
    
    func tealium(_ tealium: Tealium!, didSend dispatch: TEALDispatch!) {
        
        print("Did send dispatch: \(dispatch)")
        
        // Add optional code here to respond to sent dispatches.

    }
    
    func tealium(_ tealium: Tealium!, webViewIsReady webView: AnyObject!) {

        // Use this to interact with the Tag Management Dispatcher's webview - available only if Tag Management enabled via remote settings.

        
    }
}
