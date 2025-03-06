//
//  Notification+.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import Foundation
fileprivate let failed_upload_from_server = "go_to_login_page"
fileprivate let data_upload_from_server = "DATA_UPLOADED"

extension Notification.Name {
    static let failedUploadData = Notification.Name(rawValue: failed_upload_from_server)
    static let dataUploaded = Notification.Name(data_upload_from_server)
    
}
