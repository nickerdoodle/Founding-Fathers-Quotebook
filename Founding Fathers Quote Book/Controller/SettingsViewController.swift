//
//  SettingsViewController.swift
//  Founding Fathers Quote Book
//
//  Created by Nick Mahe on 9/28/19.
//  Copyright © 2019 Nick Mahe. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController{
    
    
    // Contants
    private struct Color{
        static let disabled = UIColor.clear
        static let enabled = UIColor.init(displayP3Red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
    }
    
    private enum Settings: String{
        case notificationsOn, hour, minute, notifyDays
    }
    
    private struct NotificationAlert{
        static let buttonLabel = "OK"
        static let message = """
                            To allow this app to remind you of the quote of the day, please go to the Settings app and enable notifications for the Quotes app.
                            """
        static let title = "Notifications are disabled"
    }
    
    private struct NotificationContent{
        static let body = "Read advice from our founding fathers"
        static let identifier = "edu.byu.ffqb"
        static let subtitle = "Quote of the Day"
        static let title = "Founding Fathers"
    }
    
    // Properties
    var hour = 7
    var minute = 0
    var notificationOn = true
    var notifyDays = [true, true, true, true, true, true, true]
    
    // Outlets
    
    @IBOutlet var dayButtons: [UIButton]!
    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    // View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNotificationPermissions()
        restoreSettings()
        updateUI()
    }
    
    // Actions
    
    @IBAction func toggleNotifications(_ sender: UISwitch) {
        notificationOn = sender.isOn
        saveSettings()
    }
    
    @IBAction func updateNotificationTime(_ sender: UIDatePicker) {
        hour = sender.calendar.component(Calendar.Component.hour, from: sender.date)
        minute = sender.calendar.component(Calendar.Component.minute, from: sender.date)
        
        saveSettings()
    }
    
    @IBAction func toggleDay(_ sender: UIButton) {
        notifyDays[sender.tag] = !notifyDays[sender.tag]
        saveSettings()
        updateUI()
    }
    // Helpers
    private func checkNotificationPermissions(){
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized{
                let alertController = UIAlertController(title: NotificationAlert.title, message: NotificationAlert.message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: NotificationAlert.title, style:  .default, handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    private func updateUI(){
        notificationsSwitch.setOn(notificationOn, animated: false)
        
        let date = timePicker.calendar.date(bySettingHour: hour, minute: minute, second: 0, of: Date()) ?? Date()
        
        timePicker.setDate(date, animated: false)
        
        for button in dayButtons{
            button.backgroundColor = notifyDays[button.tag] ? Color.enabled : Color.disabled
        }
    }
    private func saveSettings(){
        let defaults = UserDefaults.standard
        defaults.set(notificationOn, forKey: Settings.notificationsOn.rawValue)
        defaults.set(hour, forKey: Settings.notificationsOn.rawValue)
        defaults.set(minute, forKey: Settings.notificationsOn.rawValue)
        defaults.set(notifyDays, forKey: Settings.notificationsOn.rawValue)
        
        defaults.synchronize()
    }
    private func restoreSettings(){
        let defaults = UserDefaults.standard

        if let days = defaults.array(forKey: Settings.notifyDays.rawValue) as? [Bool]{
            notifyDays = days
            notificationOn = defaults.bool(forKey: Settings.notificationsOn.rawValue)
            hour = defaults.integer(forKey: Settings.hour.rawValue)
            minute = defaults.integer(forKey: Settings.minute.rawValue)
        }
    }
}
