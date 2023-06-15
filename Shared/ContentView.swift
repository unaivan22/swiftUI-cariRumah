//
//  ContentView.swift
//  Shared
//
//  Created by unaivan on 15/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            TabView {
                Home()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                Home()
                    .tabItem {
                        Image(systemName: "safari.fill")
                        Text("Explore")
                    }
                
                Explore()
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("Chat")
                    }
                
                Home()
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                        Text("Saved")
                    }
                
                Home()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
            .accentColor(.blue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Explore: View {
    @StateObject private var viewModel = RumahViewModel()
    
    var body: some View {
        
        NavigationView {
            List(viewModel.rumahs, id: \.id) { rumah in
                NavigationLink(destination: DetailView(rumah: rumah)) {
                    HStack{
                        URLImage(urlString: rumah.thumbnail)
                            .frame(width: 80, height: 80)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading){
                            Text(rumah.title)
                                .font(.caption)
                            
                            Text("Rp \(rumah.price)")
                                .font(.caption)
                            
                            HStack{
                                Group{
                                    Image(systemName: "bed.double.fill")
                                    Text("\(rumah.bedroom)")
                                }
                                Group{
                                    Image(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
                                    Text("\(rumah.long * rumah.wide)")
                                }
                                
                            }
                            
                            
                        }
                    }
                }.listRowSeparator(.hidden)
                
            }
        }.listStyle(.plain)
        .onAppear {
            viewModel.fetchRumahs()
        }
        .navigationTitle("Rumah")
    }
}

struct Home : View {
    var body : some View {
        
        ZStack(alignment: .top){
            VStack(alignment: .leading){
                Text("Rumah Impian Dalam Genggaman")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                TextField("Search ...", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 12)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.bottom, 24)
                
                Text("Nearby")
                    .font(.system(size: 22))
                    .padding(.bottom, 12)
                
                Explore()
                
                
                
            }.navigationViewStyle(StackNavigationViewStyle())
                .padding(.horizontal, 24)
        }
    }
}


struct DetailView: View {
    let rumah: Rumah
    
    var body: some View {
        VStack(alignment: .leading) {
            
            URLImage(urlString: rumah.thumbnail)
            //                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8).frame(height: 200)
            
            Text(rumah.title)
                .font(.largeTitle)
            
            HStack{
                Text(rumah.kecamatan)
                    .font(.caption)
                Text(rumah.kota)
                    .font(.caption)
            }
            
            HStack{
                Group{
                    Image(systemName: "bed.double.fill")
                    Text("\(rumah.bedroom)")
                }
                Group{
                    Image(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
                    Text("\(rumah.long * rumah.wide)")
                }
                HStack{
                    Image(systemName: "drop.fill")
                    Text("\(rumah.bathroom)")
                }
                
            }
            
            Text("Author: \(rumah.price)")
                .font(.subheadline)
            
            
            
            Text(rumah.description)
                .font(.body)
        }.padding(.horizontal,24)
    }
}


struct URLImage: View {
    let urlString: String
    
    var body: some View {
        if let url = URL(string: urlString), let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
            Image(uiImage: image)
                .resizable()
        } else {
            Image(systemName: "photo")
                .resizable()
        }
    }
}
