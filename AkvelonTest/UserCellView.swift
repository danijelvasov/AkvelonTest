//
//  UserCellView.swift
//  AkvelonTest
//
//  Created by Danijel Vasov on 6.5.21..
//

import SwiftUI
import SDWebImageSwiftUI

struct UserCellView: View {
    
    let deviceSize = UIScreen.main.bounds
    let user: User
    
    var body: some View {
        HStack(spacing: 20) {

            if let avaratUrl = user.avatar {
                ThumbnailView(avatarUrl: avaratUrl)
            }
            
            
            if let firstname = user.firstName,
               let lastName = user.lastName,
               let wasOnline = user.wasOnline{
                
                VStack(alignment: .leading) {
                    Text("\(firstname), \(lastName)")
                        .bold()
                    Text("was Online: \(self.getFormattedDate(from: wasOnline))")
                        .foregroundColor(.gray)
                }
                
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func getFormattedDate(from serverDateString: String) -> String {
        if let date = serverDateString.formatDateFromServerString() {
            if let formattedDate = date.dateString(withFormat: DateConstants.MM_DD_YYYY_HH_MM.rawValue) {
                return formattedDate
            } else {return serverDateString}
        }else {return serverDateString}
    }
}


struct ThumbnailView: View {
    
    let avatarUrl: String
    
    var body: some View {
        WebImage(url: URL(string: avatarUrl))
            .onSuccess { image, data, cacheType in
                
            }
            .resizable()
            .placeholder(Image(systemName: "person.fill"))
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 45, height: 45)
            .overlay(
                Circle()
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(.white)
            )
            .shadow(radius: 5)
    }
}

struct UserCellView_Previews: PreviewProvider {
    static var previews: some View {
        UserCellView(user: User(id: "1", wasOnline: "10 mins ago", firstName: "danijel", avatar: "", lastName: "vasov"))
    }
}
