//
//  LoginView.swift
//  ArchExperiment
//
//  Created by Bobby Pehtrus on 18/08/22.
//

import Combine
import SwiftUI

struct LoginView: View {
    
    // Using combine to receive communication from view model
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 16.0) {
                TVLViewSwiftUI  { context in
                    let label: UILabel = UILabel()
                    label.text = "Text View"
                    label.font = .systemFont(ofSize: 24.0)
                    label.textAlignment = .center
                    return label
                }
                VStack {
                    TextField("Username", text: $viewModel.username)
                        .padding()
                        .frame(height: 55.0)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    if viewModel.usernameErrorText != nil {
                        Text(viewModel.usernameErrorText ?? "")
                            .foregroundColor(Color.red)
                            .font(.system(size: 12.0))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity,  alignment: .leading)
                            .padding(.horizontal, 12.0)
                    }
                }
                
                VStack {
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .frame(height: 55.0)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    if viewModel.passwordErrorText != nil {
                        Text(viewModel.passwordErrorText ?? "")
                            .foregroundColor(Color.red)
                            .font(.system(size: 12.0))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity,  alignment: .leading)
                            .padding(.horizontal, 12.0)
                    }
                    
                }
                Button {
                    // validation
                    viewModel.onLoginButtonTapped()
                } label: {
                    Text("Login")
                        .font(.title3)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .controlSize(.regular)
                
                
            }
            .padding(.horizontal, 24.0)
            .offset(y: -24)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
