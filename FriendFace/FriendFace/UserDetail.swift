//
//  UserDetail.swift
//  FriendFace
//
//  Created by Mathias on 7/18/23.
//

import SwiftUI

struct UserDetail: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Section("About User") {
                Text(user.about)
            }
            Spacer()
            Spacer()
            Section("Friends \(user.friends.count)") {
                List {
                    ForEach(user.friends, id: \.id) { friend in
                        Text(friend.name)
                    }
                }.padding(0)
            }
        }.padding()
    }
}

//struct UserDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetail()
//    }
//}
