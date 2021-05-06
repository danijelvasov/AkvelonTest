//
//  ContentView.swift
//  AkvelonTest
//
//  Created by Danijel Vasov on 6.5.21..
//

import SwiftUI


struct MainView: View {
    
    @State var users = [User]()
    @State var currentPage = 1
    @State var didFailToLoadData = false
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                ScrollView(showsIndicators: false){
                    
                    LazyVStack { //for loadMoreData purpose
                        
                        ForEach(users.indices, id: \.self) { index in
                            NavigationLink(
                                destination: Text("USER DETAILS"),
                                label: {
                                   UserCellView(user: users[index])
                                    
                                }).accentColor(.black)
                             
                        }
                        
                        Rectangle().foregroundColor(.clear).onAppear{
                            //detects when scrollview reached bottom
                            if !users.isEmpty {
                                //we dont want the page 2 to be loaded before page 1
                                self.loadMoreData()
                            }
                        }
                    }
                    
                    
                }.navigationTitle("Users")
                
                if didFailToLoadData {
                    Button(action: {
                        didFailToLoadData.toggle()
                        self.loadUsersData()
                    }, label: {
                        Text("Retry")
                            .bold()
                            .padding()
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .background(Color(.green))
                            .cornerRadius(8)
                    })
                }
            }
            
        }.onAppear(perform: loadUsersData)
    }
    
    
    //MARK: - Private methods
    
    fileprivate func loadUsersData(){
        let usersUrl = NetworkServices.getApiUrlString()

        NetworkServices.getUsers(with: usersUrl, page: currentPage) { users in
            DispatchQueue.main.async {
                self.users = users
            }
        } failure: { failed in
            DispatchQueue.main.async {
                self.didFailToLoadData = failed
            }
        }

    }
    
    fileprivate func loadMoreData(){
        currentPage += 1
        let usersUrl = NetworkServices.getApiUrlString()

        NetworkServices.getUsers(with: usersUrl, page: currentPage) { moreUsers in
            let currentList = self.users
            DispatchQueue.main.async {
                self.users = currentList + moreUsers
            }
        } failure: { failed in
            DispatchQueue.main.async {
                self.didFailToLoadData = failed
            }
        }

        
    }

    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
