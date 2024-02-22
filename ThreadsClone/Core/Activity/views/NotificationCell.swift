//
//  NotificationCell.swift
//  ThreadsClone
//
//  Created by ayman on 18/02/2024.
//

import SwiftUI

struct NotificationCell: View {
    @State var user:User
    @Binding var notification : NotficationModel
    @StateObject var viewModel : NotificationCellViewModel
    init(user:User , notification:Binding< NotficationModel>){
        self.user = user
        self._notification = notification
        self._viewModel = StateObject(wrappedValue: NotificationCellViewModel(notfication: notification.wrappedValue))
    }
    var body: some View {
        HStack{
            ZStack{
                
                CircularProfileImageView(user: user, size: .small)
                
                    .mask(BiteCircle().fill(style: .init(eoFill: true)))
                let nottype = notification.notifcatonType
                Image(systemName: nottype.iconSystemName)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: ProfileImageSize.xSmall.dimention/1.5,height: ProfileImageSize.xSmall.dimention/1.5)
                    .foregroundColor(nottype == .like ? .red: .blue)
                    .offset(x:14,y: 13.8)
                
            }
            VStack(alignment: .leading){
                HStack{
                    Text(user.userName)
                        .font(.footnote)
                        .fontWeight(.bold)
                    Text(notification.timeStamp.timeStampString())
                        .font(.caption)
                        .foregroundColor(.gray)
                        .tint(Color(UIColor(named: "TabColor") ?? .black))
                    Spacer()
                }
                
                Text(notification.notifcatonType.notficatinDescrption)
                    .font(.footnote)
                    .fontWeight(.thin)
                
            }
            if (notification.notifcatonType == .follow){
                Button{
                    viewModel.isFollowed.toggle()
                    Task{
                        try await viewModel.follow(user: user, Isfollow: viewModel.isFollowed)
                    }
                    
                }label: {
                    
                    Text(viewModel.isFollowed == false ? "Follow":"Following")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 100, height: 32)
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        }
                        .foregroundColor(viewModel.isFollowed ? .gray:.black)
                    
                }.padding(.horizontal)
              
            }
            
        }
        
        .onAppear{
            _ = viewModel.isfollowed(user: user)
        }
    }
    
    struct BiteCircle: Shape {
          func path(in rect: CGRect) -> Path {
              let offset = rect.maxX - 15.3
              let crect = CGRect(origin: .zero, size: CGSize(width: 15.3, height: 15.3)).offsetBy(dx: offset, dy: offset)

              var path = Rectangle().path(in: rect)
              path.addPath(Circle().path(in: crect))
              return path
          }
      }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell(user: dev.user, notification:.constant(dev.notfication))
    }
}

